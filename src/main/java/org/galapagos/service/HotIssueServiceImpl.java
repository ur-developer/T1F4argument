package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.HotIssueMapper;
import org.galapagos.mapper.IssueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class HotIssueServiceImpl implements HotIssueService {

	@Autowired
	private HotIssueMapper mapper;
	
	@Override
	public int getHotissueTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getHotissueTotalCount(cri);
	}
	
	@Override
	public List<BoardVO> getHotissueList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getHotissueList(cri);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			for(BoardVO board: list) {
				board.setMyLike(likes.contains(board.getBno()));
				List<Long> comment = mapper.getCommentList(principal.getName());
				board.setMyComment(comment.contains(board.getBno()));
				List<Long> comment2 = mapper.getComment2List(principal.getName());
				board.setMyComment2(comment2.contains(board.getBno()));
				
			}
		}
		return list;
	}

	@Override
	public BoardVO getHotissue(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.readHotissue(bno);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
			List<Long> comment = mapper.getCommentList(principal.getName());
			board.setMyComment(comment.contains(board.getBno()));
			List<Long> comment2 = mapper.getComment2List(principal.getName());
			board.setMyComment2(comment2.contains(board.getBno()));
		}
		return board;
	}
}
