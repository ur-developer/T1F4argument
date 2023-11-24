package org.galapagos.domain;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class DeleteMemberVO {
	
	private String username;
	
	@NotBlank(message = "비밀번호를 입력하세요.")
	private String deletePassword;

}
