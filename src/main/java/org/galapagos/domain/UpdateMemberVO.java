package org.galapagos.domain;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class UpdateMemberVO {
	
	public String username;
	
	@NotBlank(message = "닉네임을 입력하세요.")
	public String newNickname;
	
	@Email(message = "이메일 형식으로 입력하세요.")
	@NotBlank(message = "이메일을 입력하세요.")
	public String newEmail;
	
	@NotBlank(message = "기존 비밀번호를 입력하세요.")
	public String originallyPassword;
	
	@NotBlank(message = "새로운 비밀번호를 입력하세요.")
	public String newPassword;
	
	@NotBlank(message = "새로운 비밀번호를 확인하세요.")
	public String checkNewPassword;

}
