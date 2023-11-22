package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface NoticeService {
	public int getNoticeTotal(Criteria cri);
	
	public List<BoardVO> getNoticeList(Criteria cri, Principal principal);
	
	public BoardVO getNotice(Long bno, Principal principal) throws Exception;

	public void registerNotice(BoardVO board) throws Exception;

	public boolean modifyNotice(BoardVO board) throws Exception;

	public boolean removeNotice(Long bno);
	
	// 조회수 +1
	public boolean plusHit(long bno);
}
