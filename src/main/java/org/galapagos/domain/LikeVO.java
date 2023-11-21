package org.galapagos.domain;

import lombok.Data;

@Data
public class LikeVO {
	private Long lno;
	private Long bno;
	private String username;
	private Integer likeCount;
}
