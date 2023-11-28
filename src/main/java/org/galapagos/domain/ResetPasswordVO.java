package org.galapagos.domain;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class ResetPasswordVO {
	
	private String username;
	
	@NotBlank(message = "새로운 비밀번호를 입력하세요.")
	private String newPassword;
	
	@NotBlank(message = "비밀번호를 한번 더 입력하세요.")
	private String checkNewPassword;

}
