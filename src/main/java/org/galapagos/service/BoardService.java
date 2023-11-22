package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;
import org.springframework.web.multipart.MultipartFile;

public interface BoardService {
	
	public int getBoardTotal(Criteria cri);
	
	public List<BoardVO> getBoardList(Criteria cri, Principal principal);
	
	public BoardVO getBoard(Long bno, Principal principal) throws Exception;

	public void registerBoard(BoardVO board, List<MultipartFile> files) throws Exception;

	public boolean modifyBoard(BoardVO board, List<MultipartFile> files) throws Exception;

	public boolean removeBoard(Long bno);

	public BoardAttachmentVO getAttachment(Long no);

	public boolean removeAttachment(Long no);
	
	// 조회수 +1
	public boolean plusHit(long bno);
}

