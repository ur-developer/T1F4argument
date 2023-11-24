package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.FameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class FameServiceImpl implements  FameService {

	@Autowired
	private FameMapper mapper;

	@Override
	public int getFameTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getFameTotalCount(cri);
	}
	
	@Override
	public List<BoardVO> getFameList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getFameList(cri);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			for(BoardVO board: list) {
			board.setMyLike(likes.contains(board.getBno()));
			}
		}
		return list;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void registerFame(BoardVO board) throws Exception {
		mapper.insertSelectKeyFame(board);
		Long bno = board.getBno();
	}

	@Override
	public BoardVO getFame(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.readFame(bno);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
		}
		return board;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modifyFame(BoardVO board) throws Exception{
		int reuslt = mapper.updateFame(board);
		
		Long bno = board.getBno();
				
		return reuslt == 1;
	}

	@Override
	public boolean removeFame(Long bno) {
		log.info("remove...." + bno);

		return mapper.deleteFame(bno) == 1;
	}

	@Override
	public boolean plusHit(long bno) {
		return mapper.plusHit(bno);
	}
}
