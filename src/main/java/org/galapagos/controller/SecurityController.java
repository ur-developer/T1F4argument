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

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/security")
@Controller
public class SecurityController {

	@Autowired
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private UserDetailsService customUser;

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

		return "redirect:/security/login";

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
			Errors errors) {
		
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
		
		Authentication currentAuth = SecurityContextHolder.getContext().getAuthentication();
	    String userID = updateMember.getUsername();
	    
	    SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(currentAuth, userID));
		
		return "redirect:/security/profile";

	}
	
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		
	    UserDetails newPrincipal = customUser.loadUserByUsername(username);
	    UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken
	    		(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
	    newAuth.setDetails(currentAuth.getDetails());
	    
	    return newAuth;
	}
	
	@GetMapping("/deleteform")
	public void deleteForm(Principal principal, Model model, DeleteMemberVO deleteMember) {
		
		deleteMember.setUsername(principal.getName());		
		model.addAttribute("deleteMember", deleteMember);
		
	}
	
	@PostMapping("/deleteform")
	public String deleteForm(@Valid @ModelAttribute("deleteMember") DeleteMemberVO deleteMember,
			Errors errors) {
		
		// 비밀번호 틀려서 false 반환 시
		if(!service.deleteMember(deleteMember)) {
			
			errors.rejectValue("deletePassword", "비밀번호 에러", "비밀번호를 확인하세요.");
			
			return "/security/deleteform";
		}
		
		SecurityContextHolder.clearContext();
		
		return "redirect:/";
	}
	
	@GetMapping({"/authentication", "/findIDResult", "/authenticationPassword"})
	public void authentication() {
		
	}
	
	@PostMapping("/authentication")
	public String authentication(@ModelAttribute("member") MemberVO member, UpdateMemberVO updateMember,
			Model model) {
		
		member = service.getEmail(member.getEmail());
		model.addAttribute("member", member);
		
		return "/security/findIDResult";
	}
	
    @PostMapping("/authenticationPassword")
    public String authenticationPassword(String username, ResetPasswordVO resetPassword, Model model) {
        
        MemberVO member = service.getMember(username);
        
        resetPassword.setUsername(member.getUsername());

        model.addAttribute("resetPassword", resetPassword);
        
        return "/security/resetPassword";
    }
    
    @PostMapping("/resetPassword")
    public String resetPassword(@ModelAttribute("resetPassword") ResetPasswordVO resetPassword,
            Errors errors) {
        
    	log.info("newPassword : " + resetPassword.getNewPassword());
    	log.info("checkPassword : "+ resetPassword.getCheckNewPassword());
    	
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
        
        log.info("update :" + resetPassword);
        
        return "redirect:/security/login";
    }
}
