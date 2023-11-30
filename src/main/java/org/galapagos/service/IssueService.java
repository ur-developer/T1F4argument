package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.springframework.web.multipart.MultipartFile;


public interface IssueService {
	
	public int getIssueTotal(Criteria cri);
	
	public List<BoardVO> getIssueList(Criteria cri, Principal principal);
	
	public BoardVO getIssue(Long bno, Principal principal) throws Exception;

	public void registerIssue(BoardVO board) throws Exception;

	public boolean modifyIssue(BoardVO board) throws Exception;

	public boolean removeIssue(Long bno);

	// 조회수 +1
	public boolean plusHit(long bno);
	
	public List<BoardVO> mainIssue();
}
