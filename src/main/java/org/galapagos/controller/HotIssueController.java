package org.galapagos.controller;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.HotIssueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/hotissue")
public class HotIssueController {

	@Autowired
	private HotIssueService service;
	
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
	public void listIssue(@ModelAttribute("cri") Criteria cri, Principal principal, Model model) {
	
		log.info("list" + cri);
		int total = service.getHotissueTotal(cri);
		model.addAttribute("list", service.getHotissueList(cri, principal));
		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping("/get")
	public String getIssue(
			@RequestParam(name = "bno", required = false) Long bno,
			@ModelAttribute("cri") Criteria cri,
			Principal principal,
			Model model,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
			log.info("/get");
			if(bno != null) {	// 직접 글 선택한 경우 
				
				model.addAttribute("board", service.getHotissue(bno, principal));
			} else  {	// 메뉴를 통해서 온경우 
				List<BoardVO> list = service.getHotissueList(cri, principal);
				BoardVO board = list.get(cri.getCategory() - 1);
				model.addAttribute("board", board);
			}

		return "hotissue/get";
	}
}
