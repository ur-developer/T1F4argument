package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.Comment2LikeVO;
import org.galapagos.domain.Comment2VO;
import org.galapagos.domain.CommentLikeVO;
import org.galapagos.domain.CommentVO;
import org.galapagos.domain.Criteria;

public interface Comment2Mapper {

	List<Comment2VO> readAll(Long bno);

	
	Comment2VO get(Long no);

	void create(Comment2VO vo);

	void update(Comment2VO vo);

	void delete(Long no);
	
	List<Long> getLikesList(String username);
	
	int addComment2Like(Comment2LikeVO commentLike);
	
	int deleteComment2Like(Comment2LikeVO commentLike);

	int getCommnet2TotalCount(Criteria cri);

}
