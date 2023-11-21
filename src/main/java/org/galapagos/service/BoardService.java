package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public int getTotal(Criteria cri);
	
	public List<BoardVO> getList(Criteria cri, Principal principal);
	
	public BoardVO get(Long bno, Principal principal) throws Exception;

	public void register(BoardVO board, List<MultipartFile> files) throws Exception;

	public boolean modify(BoardVO board, List<MultipartFile> files) throws Exception;

	public boolean remove(Long bno);

	public BoardAttachmentVO getAttachment(Long no);

	public boolean removeAttachment(Long no);
	
	// 조회수 +1
	public boolean plusHit(long bno);
}

