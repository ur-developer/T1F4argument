package org.galapagos.controller;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.Comment2VO;
import org.galapagos.domain.CommentVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.Comment2Mapper;
import org.galapagos.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/api/hotissue/{bno}/comment2") // ("")로 할 경우 공통 url로 들어갈 부분
@Log4j
public class Comment2Controller {
	@Autowired
	Comment2Mapper mapper;
	
	public int getCommentTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getCommnet2TotalCount(cri);
	}

	@GetMapping("")
	public List<Comment2VO> readComments(@PathVariable Long bno, Principal principal, Criteria cri) { // 글번호(게시글 보여줌)
		
		List<Comment2VO> list = mapper.readAll(bno);
		
		log.info("Comments " + principal );
		if(principal != null) { 
			List<Long> likes = mapper.getLikesList(principal.getName());
			log.info("like list" + likes);
			for(Comment2VO comment : list) {
				log.info("check " + comment.getNo());
				comment.setMyLike(likes.contains(comment.getNo())); 
			}
		  
		 }
		 
		return list; // 경로변수에 있던 글번호
		
		
	}

	@GetMapping("/{no}") // 자체적인 pathvariable List<>로 생성된 배열[] 뒤에 붙여라.
	public Comment2VO readComment(@PathVariable Long bno, @PathVariable Long no) { // 글번호(게시글) + 댓글 id(달린 댓글들)
		return mapper.get(no); // 댓글 보는 거니 글번호 bno는 필요없으면 빼도 된다.
	}

	@PostMapping("")
	public Comment2VO create(@RequestBody Comment2VO vo) { // body 전달 (생성할 댓글내용)
		mapper.create(vo);
		return mapper.get(vo.getNo()); // 생성한 댓글 다시 꺼내서 리턴(댓글 id = no)
	}

	@PutMapping("/{no}")
	public Comment2VO update(@PathVariable Long no, @RequestBody Comment2VO vo) { // 댓글 id + body(수정할 댓글내용)
		System.out.println("==> " + vo); // 수정한 댓글의 내용 body
		mapper.update(vo);
		return mapper.get(vo.getNo()); // 올바른 방법
		// return vo; //그냥 받은 대로 바로 리턴
	}

	@DeleteMapping("/{no}")
	public String delete(@PathVariable Long no) { // 댓글 id
		System.out.println("delete ==>" + no); // 댓글삭제 (댓글 id를 삭제했다고 알림)
		mapper.delete(no);
		return "OK";
	}
}