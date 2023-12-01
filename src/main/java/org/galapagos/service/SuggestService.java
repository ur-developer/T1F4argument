package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface SuggestService {
	
	public int getSuggestTotal(Criteria cri);
	
	public List<BoardVO> getSuggestList(Criteria cri, Principal principal);
	
	public BoardVO getSuggest(Long bno, Principal principal) throws Exception;

	public void registerSuggest(BoardVO board) throws Exception;

	public boolean modifySuggest(BoardVO board) throws Exception;

	public boolean removeSuggest(Long bno);
	
	// 조회수 +1
	public boolean plusHit(long bno);
	
	public List<BoardVO> mainSuggest();
}
