package org.galapagos.controller;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;
	
	@ModelAttribute("searchTypes")
	public Map<String, String> searchTypes() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("", "-- 검색대상선택 --");
		map.put("T", "제목");
		map.put("W", "작성자");
		map.put("C", "내용");
		map.put("TC", "제목+내용");
		map.put("TW", "제목+작성자");
		map.put("TWC", "제목+작성자+내용");
		
		return map;
	}	

	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Principal principal, Model model) {
		
		log.info("list" + cri);
		int total = service.getBoardTotal(cri);
		model.addAttribute("list", service.getBoardList(cri, principal));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void register(@ModelAttribute("board") BoardVO board) {
		
	}
	
	@PostMapping("/register")
	public String register(
			@Valid @ModelAttribute("board") BoardVO board,
			Errors errors, 
			List<MultipartFile> files,
			RedirectAttributes rttr) throws Exception {

		if (errors.hasErrors()) {
			return "board/register";
		}
		
		board.setCategoryId(2L);

		service.registerBoard(board, files);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, 
			Principal principal, Model model) throws Exception {

		model.addAttribute("board", service.getBoard(bno, principal));

	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		if (service.removeBoard(bno)) {
			//rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
		}
		return "redirect:/board/list";

	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri,
			List<MultipartFile> files, RedirectAttributes rttr) throws Exception {

		if (service.modifyBoard(board, files)) {
			//rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("bno", board.getBno());
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
		}	
		return "redirect:/board/get";

	}

}
