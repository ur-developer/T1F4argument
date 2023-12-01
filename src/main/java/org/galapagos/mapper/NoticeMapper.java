package org.galapagos.mapper;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface NoticeMapper {
	public int getNoticeTotalCount(Criteria cri);

	public List<BoardVO> getNoticeList(Criteria cri);

	public List<BoardVO> getNoticeListWithPaging(Criteria cri);
	
	public BoardVO readNotice(Long bno);
	
	public void insertNotice(BoardVO board);

	public void insertNoticeSelectKey(BoardVO board);

	public int deleteNotice(Long bno);

	public int updateNotice(BoardVO board);
	
	// 조회수 +1
	public boolean plusHit(long bno);
	
	public List<BoardVO> mainNotice();
}
