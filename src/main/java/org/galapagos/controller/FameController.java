package org.galapagos.controller;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.PageDTO;
import org.galapagos.service.FameService;
import org.galapagos.service.IssueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
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
@RequestMapping("/fame")
public class FameController {

	@Autowired
	private FameService service;

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
		int total = service.getFameTotal(cri);
		model.addAttribute("list", service.getFameList(cri, principal));
		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}
	
	@GetMapping("/register")
	public void registerFame(@ModelAttribute("board") BoardVO board) {	
		log.info("register");	
	}

	@PostMapping("/register")
	public String registerFame(
			@Valid @ModelAttribute("board") BoardVO board,
			Errors errors,
			List<MultipartFile> files,
			RedirectAttributes rttr)  throws Exception{

		if(errors.hasErrors()) {
			return "fame/register";
		}
		 
	    // categoryId 값 확인
	    System.out.println("categoryId: " + board.getCategoryId());
	    
		service.registerFame(board);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/fame/list";
	}
	
	@GetMapping("/get")
	public String getFame(
			@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			Principal principal,
			Model model,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
			log.info("/get");

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
            model.addAttribute("board", service.getFame(bno, principal));
            return "fame/get";
        }
        
		service.plusHit(bno);
		
		 // 쿠키 설정
        Cookie visitedCookie = new Cookie("board_visited_" + bno, "true");
        visitedCookie.setMaxAge(24 * 60 * 60); // 24시간 유지
        response.addCookie(visitedCookie);
        
		model.addAttribute("board", service.getFame(bno, principal));
	
		return "/fame/get";
	}
	
	@GetMapping("/modify")
	public String modifyFame(
			@RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri,
			Principal principal,
			Model model,
			HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
			log.info("/modify");

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
            model.addAttribute("board", service.getFame(bno, principal));
            return "fame/modify";
        }
        
		service.plusHit(bno);
		
		 // 쿠키 설정
        Cookie visitedCookie = new Cookie("board_visited_" + bno, "true");
        visitedCookie.setMaxAge(24 * 60 * 60); // 24시간 유지
        response.addCookie(visitedCookie);
        
		model.addAttribute("board", service.getFame(bno, principal));
	
		return "/fame/get";
	}
	
	@PostMapping("/modify")
	public String modifyIssue(
			BoardVO board,
			@ModelAttribute("cri")
			Criteria cri,
			RedirectAttributes rttr) throws Exception {

		if (service.modifyFame(board)) {
			rttr.addAttribute("bno", board.getBno());
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
		}	
		return "redirect:/fame/get";

	}	
	
	@PostMapping("/remove")
	public String removeIssue(
			@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
	
		log.info("remove..." + bno);
		if (service.removeFame(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/fame/list" + cri.getLink();
	}
	
	@GetMapping("/download/{no}")
	@ResponseBody
	public void download(
			@PathVariable("no") Long no, 
			HttpServletResponse response) throws Exception {	
	}
}