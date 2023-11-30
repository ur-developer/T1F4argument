package org.galapagos.controller;

import org.galapagos.domain.CommentLikeVO;
import org.galapagos.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/api/hotissue/commentlike")
@Log4j
public class CommentLikeController {

	@Autowired
	CommentMapper mapper;
	
	
	@PostMapping("/add")
	public CommentLikeVO add(@RequestBody CommentLikeVO commentLike) {
		
		mapper.addCommentLike(commentLike);
		return commentLike;
		
	}
	
	@DeleteMapping("/delete")
	public String deleteCommentLike(CommentLikeVO commentLike) {
		log.info("Comment Delete" + commentLike);
		mapper.deleteCommentLike(commentLike);
		return "OK";
		
	}
	
	
	
}
