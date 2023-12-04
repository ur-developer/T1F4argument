package org.galapagos.controller;

import java.security.Principal;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.PageDTO;
import org.galapagos.mapper.BoardMapper;
import org.galapagos.mapper.HotIssueMapper;
import org.galapagos.service.BoardService;
import org.galapagos.service.FameService;
import org.galapagos.service.HotIssueService;
import org.galapagos.service.IssueService;
import org.galapagos.service.MemberService;
import org.galapagos.service.NoticeService;
import org.galapagos.service.SuggestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	IssueService issueService;
	
	@Autowired
	HotIssueService hotIssueService;
	
	@Autowired
	FameService fameService;
	
	@Autowired
	SuggestService suggestService;

	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, Criteria cri, Principal principal) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("mainNotice", noticeService.mainNotice());
		model.addAttribute("mainIssue", issueService.mainIssue());
		model.addAttribute("getFameList", fameService.getFameList(cri, principal));
		model.addAttribute("mainSuggest", suggestService.mainSuggest());
		model.addAttribute("getHotissueList", hotIssueService.getHotissueList(cri, principal));
		model.addAttribute("mainBoard", boardService.mainBoard());
		model.addAttribute("getMemberLikes", memberService.getMemberLikes());
		return "home";
	}
	
	
}
