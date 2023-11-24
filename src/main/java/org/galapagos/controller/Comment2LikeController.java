package org.galapagos.controller;

import org.galapagos.domain.Comment2LikeVO;
import org.galapagos.domain.CommentLikeVO;
import org.galapagos.mapper.Comment2Mapper;
import org.galapagos.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/api/board/comment2like")
@Log4j
public class Comment2LikeController {

	@Autowired
	Comment2Mapper mapper;
	
	
	@PostMapping("/add")
	public Comment2LikeVO add(@RequestBody Comment2LikeVO commentLike) {
		
		mapper.addCommentLike(commentLike);
		return commentLike;
		
	}
	
	@DeleteMapping("/delete")
	public String deleteCommentLike(Comment2LikeVO commentLike) {
		log.info("Comment Delete" + commentLike);
		mapper.deleteCommentLike(commentLike);
		return "OK";
		
	}
	
	
	
}
