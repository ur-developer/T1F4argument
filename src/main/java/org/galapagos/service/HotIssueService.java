package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface HotIssueService {

	public int getHotissueTotal(Criteria cri);

	public List<BoardVO> getHotissueList(Criteria cri, Principal principal);
	
	public BoardVO getHotissue(Long bno, Principal principal) throws Exception;


}
