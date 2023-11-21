package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface BoardLikeService {

	public List<BoardVO> getList(Criteria cri, Principal principal);
	
	public BoardVO get(Long bno, Principal principal) throws Exception;
	
}
