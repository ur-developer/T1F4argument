package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;

public interface SuggestMapper {
	
	public int getSuggestTotalCount(Criteria cri);

	public List<BoardVO> getSuggestList(Criteria cri);

	public List<BoardVO> getSuggestListWithPaging(Criteria cri);
	
	public BoardVO readSuggest(Long bno);
	
	public void insertSuggest(BoardVO board);

	public void insertSelectKeySuggest(BoardVO board);

	public int deleteSuggest(Long bno);

	public int updateSuggest(BoardVO board);
	
	// 조회수 +1
	public boolean plusHit(long bno);
	
	// 좋아요
	public List<Long> getLikesList(String username);

	public void addLike(LikeVO like);
	
	public void deleteLike(LikeVO like);
}
