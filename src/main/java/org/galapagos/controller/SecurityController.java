package org.galapagos.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/security")
@Controller
public class SecurityController {

	@Autowired
	MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	@GetMapping("/login")
	public void login() {
		
	}

	@GetMapping("/signup")
	public void signUp(@ModelAttribute("member") MemberVO member) {

	}

	@PostMapping("/signup")
	public String signUp(@Valid @ModelAttribute("member") MemberVO member, Errors errors) {

		// 비밀번호, 비밀번호 확인 일치 여부
		if (!member.getPassword().equals(member.getCheckPassword())) {

			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("checkPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}

		// 아이디 중복 체크 (유효성 검사 통과 시)
		if (!errors.hasFieldErrors("username")) {
			
			service.getMember(member.getUsername());
			
			if (service.getMember(member.getUsername()) != null) { // 중복일 경우

				errors.rejectValue("username", "아이디 중복 에러", "동일한 ID가 있습니다.");
			}
		}

		if (errors.hasErrors()) {

			return "security/signup";
		}

		// DB 저장
		service.registerMember(member);

		return "redirect:/";

	}

	@ResponseBody
	@GetMapping("/mailSend")
	public String mailSend(String email) throws Exception {
		
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

	@GetMapping("/profile")
	public void profile(@ModelAttribute("member") MemberVO member) {

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
			Errors errors) {
		
		// 비밀번호, 비밀번호 확인 일치 여부
		if (!updateMember.getNewPassword().equals(updateMember.getCheckNewPassword())) {

			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("checkNewPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}
		
		if(errors.hasErrors()) {
			return "/security/updateform";
		}
		
		// DB에 저장
		service.updateMember(updateMember);

		return "redirect:/";
	}
}
