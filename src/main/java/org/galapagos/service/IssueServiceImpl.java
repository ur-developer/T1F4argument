package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.IssueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class IssueServiceImpl implements IssueService {

	@Autowired
	private IssueMapper mapper;

	@Override
	public int getIssueTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getIssueTotalCount(cri);
	}
	
	@Override
	public List<BoardVO> getIssueList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getIssueList(cri);

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
	public void registerIssue(BoardVO board) throws Exception {
		mapper.insertSelectKeyIssue(board);
		Long bno = board.getBno();
	}

	@Override
	public BoardVO getIssue(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.readIssue(bno);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
		}
		return board;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modifyIssue(BoardVO board) throws Exception{
		int reuslt = mapper.updateIssue(board);
		
		Long bno = board.getBno();
				
		return reuslt == 1;
	}

	@Override
	public boolean removeIssue(Long bno) {
		log.info("remove...." + bno);

		return mapper.deleteIssue(bno) == 1;
	}

	@Override
	public boolean plusHit(long bno) {
		return mapper.plusHit(bno);
	}
}
