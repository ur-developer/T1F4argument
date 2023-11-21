package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;

public interface IssueMapper {
	
	public int getIssueTotalCount(Criteria cri);

	public List<BoardVO> getIssueList(Criteria cri);

	public List<BoardVO> getIssueListWithPaging(Criteria cri);
	
	public BoardVO readIssue(Long bno);
	
	public void insertIssue(BoardVO board);

	public void insertSelectKeyIssue(BoardVO board);

	public int deleteIssue(Long bno);

	public int updateIssue(BoardVO board);

	// 조회수 +1
	public boolean plusHit(long bno);

	// 좋아요
	public List<Long> getLikesList(String username);

	public void addLike(LikeVO like);
	
	public void deleteLike(LikeVO like);

}
