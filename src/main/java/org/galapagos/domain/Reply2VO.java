package org.galapagos.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class Reply2VO {

	private Long no;
	private Long cno;
	@Size(max = 500)
	private String content;
	private String username;
	private String nickname;
	private Date registerDate;
	private Date updateDate;

}
