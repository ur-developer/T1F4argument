package org.galapagos.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class Comment2VO {

	private Long no;
	private Long bno;
	@Size(max = 500)
	private String content;
	private String username;
	private String nickname;
	private Date registerDate;
	private Date updateDate;
	private Integer likeCount;
	private Boolean myLike;

	List<Reply2VO> reply2List;

}
