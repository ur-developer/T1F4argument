package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.NoticeMapper;
import org.galapagos.mapper.SuggestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class SuggestServiceImpl implements SuggestService {

	@Autowired
	private SuggestMapper mapper;
		
	@Override
	public int getSuggestTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getSuggestTotalCount(cri);
	}

	@Override
	public List<BoardVO> getSuggestList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getSuggestList(cri);

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
	public void registerSuggest(BoardVO board) throws Exception {
		mapper.insertSelectKeySuggest(board);
		Long bno = board.getBno();

	}

	@Override
	public BoardVO getSuggest(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.readSuggest(bno);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
		}
		
		return board;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modifySuggest(BoardVO board)  throws Exception{
		int reuslt = mapper.updateSuggest(board);
		
		Long bno = board.getBno();
		
		return reuslt == 1;
	}

	@Override
	public boolean removeSuggest(Long bno) {
		log.info("remove...." + bno);

		return mapper.deleteSuggest(bno) == 1;
	}
	
	@Override
	public boolean plusHit(long bno) {
		return mapper.plusHit(bno);
	}
}
