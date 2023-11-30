package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface FameService {
	
	public int getFameTotal(Criteria cri);
	
	public List<BoardVO> getFameList(Criteria cri, Principal principal);
	
	public BoardVO getFame(Long bno, Principal principal) throws Exception;

	public void registerFame(BoardVO board) throws Exception;

	public boolean modifyFame(BoardVO board) throws Exception;

	public boolean removeFame(Long bno);

	// 조회수 +1
	public boolean plusHit(long bno);
	
	public List<BoardVO> mainFame();
}
