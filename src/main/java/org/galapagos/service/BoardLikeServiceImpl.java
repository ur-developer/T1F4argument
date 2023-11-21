package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;

public class BoardLikeServiceImpl implements BoardLikeService{
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getList(cri);
		if(principal != null) {
				List<Long> likes = mapper.getLikesList(principal.getName());
				for(BoardVO board: list) {
					board.setMyLike(likes.contains(board.getBno()));
				}
		}
		return list;
	}
	
	@Override
	public BoardVO get(Long bno, Principal principal) {
		BoardVO board = mapper.read(bno);
		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
	}
	return board;
	}
}
