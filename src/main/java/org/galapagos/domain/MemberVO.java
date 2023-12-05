package org.galapagos.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import lombok.Data;

@Data
public class MemberVO {
	@NotBlank(message = "사용자 아이디는 필수항목입니다.")
	@Size(min = 4, message="사용자 아이디는 4글자 이상이어야 합니다.")
	private String username;
	
	@NotBlank(message = "비밀번호는 필수항목입니다.")
	private String password;
	
	@NotBlank(message = "비밀번호 확인은 필수항목입니다.")
	private String checkPassword;

	private String email;
	
	@NotBlank(message = "이메일을 인증하세요.")
	private String checkEmail;
	
	@NotBlank(message = "닉네임은 필수항목입니다.")
	private String nickname;
	
	private Date registerDate;
	private Date updateDate;
	private Integer totalLikes;
	private List<AuthorizationVO> authorizationList;
	
	public Collection<SimpleGrantedAuthority> getAuthorities() {
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		for(AuthorizationVO authorization: authorizationList) {
			authorities.add(new SimpleGrantedAuthority(authorization.getAuthorization()));
		} 		
		return authorities;
	}

}
