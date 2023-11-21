package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;

public interface BoardMapper {
	
	public int getTotalCount(Criteria cri);

	public List<BoardVO> getList(Criteria cri);

	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public BoardVO read(Long bno);
	
	public void insert(BoardVO board);

	public void insertSelectKey(BoardVO board);

	public int delete(Long bno);

	public int update(BoardVO board);
	
	public void insertAttachment(BoardAttachmentVO attach);
	
	public List<BoardAttachmentVO> getAttachmentList(Long bno);

	public BoardAttachmentVO getAttachment(Long no);

	public int removeAttachment(Long no); 

	// 조회수 +1
	public boolean plusHit(long bno);
	
	// 좋아요수 +1
	public boolean plusLikes(long bno);
	
	// 좋아요 처리
	public List<Long> getLikesList(String username);
	
	public int addLike(LikeVO like);
	
	public int deleteLike(LikeVO like);
}