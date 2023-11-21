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
	
	@NotBlank(message = "비밀번호 확인을 입력하세요.")
	private String checkPassword;
	
	@NotBlank(message = "닉네임을 입력하세요.")
	private String nickname;
	
	@NotBlank(message = "이메일을 입력하세요.")
	@Email(message = "이메일 형식에 맞게 입력하세요.")
	private String email;
	
	private Date registryDate;
	
	private List<AuthorizationVO> authorizationList;
	
	public Collection<SimpleGrantedAuthority> getAuthorities() {
			
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
			
		for(AuthorizationVO authorization : authorizationList)
			authorities.add(new SimpleGrantedAuthority(authorization.getAuthorization()));
		
		return authorities;
	}

}
