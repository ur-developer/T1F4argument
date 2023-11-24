package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.CommentLikeVO;
import org.galapagos.domain.CommentVO;
import org.galapagos.domain.Criteria;

public interface CommentMapper {

	List<CommentVO> readAll(Long bno);

	public List<CommentVO> getListWithPaging(Criteria cri);
	
	CommentVO get(Long no);

	void create(CommentVO vo);

	void update(CommentVO vo);

	void delete(Long no);
	
	List<Long> getLikesList(String username);
	
	int addCommentLike(CommentLikeVO commentLike);
	
	int deleteCommentLike(CommentLikeVO commentLike);

	List<CommentVO> getComments(Long bno);

}
