package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.galapagos.domain.BoardAttachmentVO;
import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.domain.LikeVO;
import org.galapagos.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public int getBoardTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getBoardTotalCount(cri);
	}

	@Override
	public List<BoardVO> getBoardList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getBoardList(cri);

		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			for(BoardVO board: list) {
			board.setMyLike(likes.contains(board.getBno()));
			}
		}
		return list;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void registerBoard(BoardVO board, List<MultipartFile> files) throws Exception {
		mapper.insertSelectKey(board);
		Long bno = board.getBno();
		
		/*
		 * for(MultipartFile part: files) { if(part.isEmpty()) continue;
		 * BoardAttachmentVO attach = new BoardAttachmentVO(bno, part);
		 * mapper.insertAttachment(attach); }
		 */
	}

	@Override
	public BoardVO getBoard(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.read(bno);
	
		List<BoardAttachmentVO> list  = mapper.getAttachmentList(bno);
		board.setAttaches(list);
		
		if(principal != null) {
			List<Long> likes = mapper.getLikesList(principal.getName());
			board.setMyLike(likes.contains(board.getBno()));
			List<Long> comment = mapper.getCommentList(principal.getName());
			board.setMyComment(comment.contains(board.getBno()));
			List<Long> comment2 = mapper.getComment2List(principal.getName());
			board.setMyComment2(comment2.contains(board.getBno()));
			
		}
		return board;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modifyBoard(BoardVO board, List<MultipartFile> files)  throws Exception{
		int reuslt = mapper.update(board);
		
		Long bno = board.getBno();
		
		/*
		 * for(MultipartFile part: files) { if(part.isEmpty()) continue;
		 * BoardAttachmentVO attach = new BoardAttachmentVO(bno, part);
		 * mapper.insertAttachment(attach); }
		 */		
		return reuslt == 1;

	}

	@Override
	public boolean removeBoard(Long bno) {
		log.info("remove...." + bno);

		return mapper.delete(bno) == 1;
	}

	public BoardAttachmentVO getAttachment(Long no) {
		return mapper.getAttachment(no);
	}

	public boolean removeAttachment(Long no) {
		return mapper.removeAttachment(no) == 1;		
	} 

	@Override
	public boolean plusHit(long bno) {
		return mapper.plusHit(bno);
	}

	@Override
	public List<BoardVO> mainBoard() {
		return mapper.mainBoard();
	}
}
