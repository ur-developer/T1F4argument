package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;

public interface FameMapper {
	
	public int getFameTotalCount(Criteria cri);

	public List<BoardVO> getFameList(Criteria cri);

	public List<BoardVO> getFameListWithPaging(Criteria cri);
		
	public BoardVO readFame(Long bno);
	
	public void insertFame(BoardVO board);

	public void insertSelectKeyFame(BoardVO board);

	public int deleteFame(Long bno);

	public int updateFame(BoardVO board);

	// 조회수 +1
	public boolean plusHit(long bno);

	// 좋아요
	public List<Long> getLikesList(String username);

	public void addLike(LikeVO like);
	
	public void deleteLike(LikeVO like);

}
