package org.galapagos.mapper;

import org.galapagos.domain.Reply2VO;

public interface Reply2Mapper {

	void create(Reply2VO vo);

	void update(Reply2VO vo);

	void delete(Long no);

	Reply2VO get(Long no);

}
