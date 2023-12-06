package org.galapagos.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;


@Data
public class BoardVO {
	
	private Long bno;
	
	private Long categoryId;
	
	private String username;
	
	@NotBlank(message = "제목은 필수항목입니다.")
	@Size(max = 20, message = "제목은 20자 이내로 작성해야 합니다.")
	private String title;
	
	@NotBlank(message = "내용은 필수항목입니다.")
	private String content;
	
	List<BoardAttachmentVO> attaches;

	private String nickname;
	private Date registerDate;
	private Date updateDate;
	
	// 좋아요 기능
	private int hit;
	private Integer likes;
	private Boolean myLike;
	private Integer comment1Count;
	private Integer comment2Count;
	private Boolean myComment;
	private Boolean myComment2;
	
	// 단어 추가 기능
	private String leftword;
	private String rightword;
	
	private Integer totalLikes;
}