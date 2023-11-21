package org.galapagos.mapper;

import org.galapagos.domain.ReplyVO;

public interface ReplyMapper {

	void create(ReplyVO vo);

	void update(ReplyVO vo);

	void delete(Long no);

	ReplyVO get(Long no);

}
