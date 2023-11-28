package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;

public interface BoardMapper {
	
	public int getBoardTotalCount(Criteria cri);

	public List<BoardVO> getBoardList(Criteria cri);

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

	// 좋아요
	public List<Long> getLikesList(String username);

	public void addLike(LikeVO like);
	
	public void deleteLike(LikeVO like);
	
	public List<Long> getCommentList(String username);
	
	public List<Long> getComment2List(String username);

}