package org.galapagos.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;


@Data
public class BoardVO {
	
	private Long bno;
	
	private int categoryId;
	
	private String username;
	
	@NotBlank(message = "제목은 필수항목입니다.")
	private String title;
	
	@NotBlank(message = "내용은 필수항목입니다.")
	private String content;
	
	List<BoardAttachmentVO> attaches;

	private String nickname;
	private Date registerDate;
	private Date updateDate;
	
	private int hit;
	private Integer likes;
	private Boolean myLike;
}