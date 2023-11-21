package org.galapagos.controller;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/issue")
public class IssueController {

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
		int total = service.getTotal(cri);//		model.addAttribute("list", service.getList());
		model.addAttribute("list", service.getList(cri, principal));
		model.addAttribute("pageMaker", new PageDTO(cri, total));	// 임의로 123  요청

	}
	
	@GetMapping("/register")
	public void register(@ModelAttribute("board") BoardVO board) {	
		log.info("register");	
	}

	@PostMapping("/register")
	public String register(
			@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			List<MultipartFile> files,
			RedirectAttributes rttr)  throws Exception{

		if(errors.hasErrors()) {
			return "issue/register";
		}

		service.register(board, files);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/issue/list";
	}
	
	@GetMapping({ "/get", "/modify" })
	public String get(
			@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			Principal principal,
			Model model,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
			log.info("/get or modify");

		 // 사용자 정보를 얻어옴
	    String username = (principal != null) ? principal.getName() : "";

	    // 쿠키에서 조회 여부 확인
	    Cookie[] cookies = request.getCookies();
	    boolean hasVisited = false;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (("board_visited_" + bno).equals(cookie.getName())) {
                    hasVisited = true;
                    break;
                }
            }
        }

     // 이미 방문한 경우 처리
        if (hasVisited) {
            // 이미 방문한 사용자에게 처리할 내용
            model.addAttribute("board", service.get(bno, principal));
            return "issue/get";
        }
        
		service.plusHit(bno);
		
		 // 쿠키 설정
        Cookie visitedCookie = new Cookie("board_visited_" + bno, "true");
        visitedCookie.setMaxAge(24 * 60 * 60); // 24시간 유지
        response.addCookie(visitedCookie);
        
		model.addAttribute("board", service.get(bno, principal));
	
		return "issue/get";
	}
	
	@PostMapping("/modify")
	public String modify(
			@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			List<MultipartFile> files,			
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr)  throws Exception{
		log.info("modify:" + board);
	
		if(errors.hasErrors()) {
			return "issue/modify";
		}		
		
		if (service.modify(board, files)) {
			// Flash --> 1회성
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:" + cri.getLinkWithBno("/issue/get", board.getBno());

	}	
	
	@PostMapping("/remove")
	public String remove(
			@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
	
		log.info("remove..." + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/issue/list" + cri.getLink();

	}
	
	@GetMapping("/download/{no}")
	@ResponseBody	// view를 사용하지 않고, 직접 내보냄
	public void download(
			@PathVariable("no") Long no, 
			HttpServletResponse response) throws Exception {

		BoardAttachmentVO attach = service.getAttachment(no);
		attach.download(response);		
		
	}

	@DeleteMapping("/remove/attach/{no}")
	@ResponseBody	
	public String removeAttach(
			@PathVariable("no") Long no) throws Exception {

		service.removeAttachment(no);
		return "OK";
	}
}