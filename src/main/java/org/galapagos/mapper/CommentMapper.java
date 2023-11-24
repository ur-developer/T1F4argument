package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.CommentLikeVO;
import org.galapagos.domain.CommentVO;
import org.galapagos.domain.Criteria;

public interface CommentMapper {

	public List<CommentVO> readAll(Long bno);

	public List<CommentVO> getListWithPaging(Criteria cri);
	
	public CommentVO get(Long no);

	public void create(CommentVO vo);

	public void update(CommentVO vo);

	public void delete(Long no);
	
	public List<Long> getLikesList(String username);
	
	public int addCommentLike(CommentLikeVO commentLike);
	
	public int deleteCommentLike(CommentLikeVO commentLike);



}
