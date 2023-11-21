package org.galapagos.controller;

import java.security.Principal;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.validation.Valid;

import org.galapagos.domain.MemberVO;
import org.galapagos.domain.UpdateMemberVO;
import org.galapagos.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/security")
@Log4j
public class SecurityController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@GetMapping("/login")
	public void login() {
		
	}
	
	@GetMapping("/signup")
	public void signup(@ModelAttribute("member") MemberVO member) {
		
	}
	
	@PostMapping("/signup")
	public String signup(
			@Valid @ModelAttribute("member") MemberVO member, Errors errors) {
		
		// 1. 비밀번호, 비밀번호확인 일치여부
		if(!member.getPassword().equals(member.getCheckPassword())) {
			// 에러 추가
			errors.rejectValue("password2", "비밀번호 불일치", "비밀번호 확인이 일치하지 않습니다.");
		}
		
		// 2. 아이디 중복
		if(!errors.hasFieldErrors("username")) {  // username 유효성 통과한 경우에 
			// DB에서 username을 검사 
			if(service.getMember(member.getUsername()) != null) {	// 중복임
				errors.rejectValue("username", "ID 중복", "이미 사용중인 ID입니다.");	
			}
		}
		
		if(errors.hasErrors()) {
			return "security/signup";
		}
		
		// DB 저장
		service.registerMember(member);
		
		return "redirect:/";
	}
	
	@GetMapping("/profile")
	public void profile() {
		
	}
	
	@ResponseBody
	@GetMapping("/sendMail")
	public String sendMail(String email) throws Exception {

		Random random = new Random();
		int checkNum = 0;
		StringBuffer buffer = new StringBuffer();

		// 6자리 난수 생성
		for (int i = 0; i < 6; i++) {

			checkNum = random.nextInt(9); // 0~9까지 정수를 랜덤으로 저장
			buffer.append(checkNum); // StringBuffer에 숫자 한 개씩 저장
		}

		// log.info("auth number: " + buffer);

		// 메일 발송
		String setFrom = "daily_bubbly@naver.com";
		String toMail = email;
		String title = "회원가입 인증 코드입니다.";
		String content = "인증번호는 " + buffer + "입니다.<br>" + "인증번호 확인란에 입력하세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			// true: html 사용
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);

			// 인증 코드 메일 발송
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		// StringBuffer로 생성 된 코드를 String 변수에 담아서 return
		String code = buffer.toString();

		return code;

	}
	
	@GetMapping("/updateform")
	public void updateForm(Principal principal, Model model, UpdateMemberVO updateMember) {
		
		String id = principal.getName();
		MemberVO member = service.getMember(id);
		
		updateMember.setUsername(member.getUsername());
		updateMember.setNewNickname(member.getNickname());
		updateMember.setNewEmail(member.getEmail());
		
		model.addAttribute("updateMember", updateMember);
	}
	
	@PostMapping("/updateform")
	public String updateForm(@Valid @ModelAttribute("updateMember") UpdateMemberVO updateMember,
			Errors errors, MemberVO member) {
		
		// 비밀번호, 비밀번호 확인 일치 여부
		if (!updateMember.getNewPassword().equals(updateMember.getCheckNewPassword())) {

			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("checkNewPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}
		
		// 닉네임 중복 체크
		// 새로 작성 된 닉네임과 저장 된 닉네임이 같지 않을 때만 중복 검사
		if (!errors.hasFieldErrors("newNickname")) {
			
			member = service.getMember(updateMember.getUsername());
			
			if(!updateMember.getNewNickname().equals(member.getNickname())) {
				
				if (service.getNickname(updateMember.getNewNickname())) { // 중복일 경우

					errors.rejectValue("newNickname", "닉네임 중복 에러", "동일한 닉네임이 있습니다.");
				}
			}
		}
		
		// DB에 저장 시 기존 비밀번호와 입력한 비밀번호가 일치하지 않을 경우
		if(!service.updateMember(updateMember)) {
			errors.rejectValue("originallyPassword", "기존 비밀번호 에러", "기존 비밀번호와 일치하지 않습니다.");
		}
		
		if(errors.hasErrors()) {
			return "/security/updateform";
		}

		return "redirect:/security/login";

	}
}
