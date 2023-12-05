package org.galapagos.controller;

import java.security.Principal;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.validation.Valid;

import org.galapagos.domain.DeleteMemberVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.ResetPasswordVO;
import org.galapagos.domain.UpdateMemberVO;
import org.galapagos.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
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
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	@GetMapping("/login")
	public void login() {

	}

	@GetMapping("/signup")
	public void signUp(@ModelAttribute("member") MemberVO member) {

	}

	@PostMapping("/signup")
	public String signUp(@Valid @ModelAttribute("member") MemberVO member, Errors errors,
			Model model) {

		// 비밀번호, 비밀번호 확인 일치 여부
		if (!member.getPassword().equals(member.getCheckPassword())) {

			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("checkPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}

		// 아이디 중복 체크 (유효성 검사 통과 시)
		if (!errors.hasFieldErrors("username")) {
			if (service.getMember(member.getUsername()) != null) { // 중복일 경우

				errors.rejectValue("username", "아이디 중복 에러", "동일한 ID가 있습니다.");
			}
		}

		// 닉네임 중복 체크
		if (!errors.hasFieldErrors("nickname")) {
			if (service.getNickname(member.getNickname())) { // 중복일 경우

				errors.rejectValue("nickname", "닉네임 중복 에러", "동일한 닉네임이 있습니다.");
			}
		}
		
		// 이메일 인증 체크
		if (errors.hasFieldErrors("email")) {
			
			errors.rejectValue("email", "이메일 인증 에러", "이메일을 인증하세요.");
		}

		if (errors.hasErrors()) {

			return "security/signup";
		}

		// DB 저장
		service.registerMember(member);
		
		model.addAttribute("message", "회원가입이 완료되었습니다.");
		model.addAttribute("url", "/security/login");

		return "/layouts/alert";

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
	
	@ResponseBody
	@GetMapping("/checkMail")
	public boolean checkMail(String email) throws Exception {
		
		if(service.getEmail(email) == null) {
			
			return false;
		}
		
		return true;
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
			Errors errors, Model model) {
		
		// 비밀번호, 비밀번호 확인 일치 여부
		if (!updateMember.getNewPassword().equals(updateMember.getCheckNewPassword())) {

			// 특정 필드에 대해 에러 추가
			// (변수명, 에러코드, 출력할 메세지)
			errors.rejectValue("checkNewPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
		}
		
		// 닉네임 중복 체크
		// 새로 작성 된 닉네임과 저장 된 닉네임이 같지 않을 때만 중복 검사
		if (!errors.hasFieldErrors("newNickname")) {
			
			MemberVO member = service.getMember(updateMember.getUsername());
			
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
		
		service.updateAuthentication(updateMember);
		
	    model.addAttribute("message", "회원정보가 수정되었습니다.");
		model.addAttribute("url", "/security/profile");

		return "/layouts/alert";

	}
	
	@GetMapping("/deleteform")
	public void deleteForm(Principal principal, Model model, DeleteMemberVO deleteMember) {
		
		deleteMember.setUsername(principal.getName());		
		model.addAttribute("deleteMember", deleteMember);
		
	}
	
	@PostMapping("/deleteform")
	public String deleteForm(@Valid @ModelAttribute("deleteMember") DeleteMemberVO deleteMember,
			Errors errors, Model model) {
		
		// 비밀번호 틀려서 false 반환 시
		if(!service.deleteMember(deleteMember)) {
			
			errors.rejectValue("deletePassword", "비밀번호 에러", "비밀번호를 확인하세요.");
			
			return "/security/deleteform";
		}
		
		SecurityContextHolder.clearContext();
		
		model.addAttribute("message", "탈퇴가 완료되었습니다.");
		model.addAttribute("url", "/");
		
		return "/layouts/alert";
	}
	
	@GetMapping({"/authentication", "/findIDResult", "/authenticationPassword"})
	public void authentication(@ModelAttribute("member") MemberVO member) {
		
	}
	
	@PostMapping("/authentication")
	public String authentication(@Valid @ModelAttribute("member") MemberVO member, Errors errors, Model model) {

		if(member.getCheckEmail() == null) {
			
			errors.rejectValue("checkEmail", "이메일 인증 에러", "");
			
			return "/security/authentication";
		}
		
		member = service.getEmail(member.getEmail());
		model.addAttribute("member", member);
		
		return "/security/findIDResult";
	}
	
    @PostMapping("/authenticationPassword")
    public String authenticationPassword(@Valid @ModelAttribute("resetPassword") ResetPasswordVO resetPassword, 
    		Errors errors, Model model) {
        
        if(service.getMember(resetPassword.getUsername()) == null) {
    		
    		errors.rejectValue("username", "사용자 에러", "아이디와 일치하는 사용자가 없습니다.");
    		
    		 if(resetPassword.getCheckEmail() == null) {
    				
    				errors.rejectValue("checkEmail", "이메일 인증 에러", "이메일을 인증하세요.");
    		}
    		
    		return "/security/authenticationPassword";
    	}

        model.addAttribute("resetPassword", resetPassword);
        
        return "/security/resetPassword";
    }
    
    @PostMapping("/resetPassword")
    public String resetPassword(@ModelAttribute("resetPassword") ResetPasswordVO resetPassword,
            Errors errors, Model model) {
    	
        // 비밀번호, 비밀번호 확인 일치 여부
        if (!resetPassword.getNewPassword().equals(resetPassword.getCheckNewPassword())) {

            // 특정 필드에 대해 에러 추가
            // (변수명, 에러코드, 출력할 메세지)
            errors.rejectValue("checkNewPassword", "비밀번호확인 에러", "비밀번호 확인이 일치하지 않습니다.");
        }
        
        if(errors.hasErrors()) {
            return "/security/resetPassword";
        }
        
        service.resetPassword(resetPassword);
        
        model.addAttribute("message", "비밀번호가 변경되었습니다.");
		model.addAttribute("url", "/security/login");
		
		return "/layouts/alert";
    }
}
