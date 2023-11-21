package org.galapagos.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.Data;

@Data
public class MemberVO {
	
	@NotBlank(message = "아이디를 입력하세요.")
	private String username;
	
	@NotBlank(message = "비밀번호를 입력하세요.")
	private String password;
	
	@NotBlank(message = "비밀번호를 확인하세요.")
	private String checkPassword;
	
	@NotBlank(message = "닉네임을 입력하세요.")
	private String nickname;
	
	@NotBlank(message = "이메일을 입력하세요.")
	@Email(message = "이메일 형식에 맞게 입력하세요.")
	private String email;
	
	private Date registerDate;
	
	// admin을 제외하고 다른 user들의 권한을 저장
	private List<AuthorizationVO> authorizationList;
		
	// authorizationList를 Collection<SimpleGrantedAuthority>로 변환
	// security framework는 개발자가 정의한 UserVO를 모르기 때문에 따로 설정
	public Collection<SimpleGrantedAuthority> getAuthorities() {
			
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
			
		for(AuthorizationVO authorization : authorizationList)
			authorities.add(new SimpleGrantedAuthority(authorization.getAuthorization()));
		
		return authorities;
	}
	
	public void updateNickname(String nickname) {
		this.nickname = nickname;
	}

}
