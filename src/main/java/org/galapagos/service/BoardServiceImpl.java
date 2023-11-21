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
	public int getTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getList(Criteria cri, Principal principal) {
		
		return mapper.getListWithPaging(cri);
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void register(BoardVO board, List<MultipartFile> files) throws Exception {
		mapper.insertSelectKey(board);
		Long bno = board.getBno();
		
		for(MultipartFile part: files) {
			if(part.isEmpty()) continue;
			BoardAttachmentVO attach = new BoardAttachmentVO(bno, part);
			mapper.insertAttachment(attach);
		}
	}

	@Override
	public BoardVO get(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.read(bno);
	
		List<BoardAttachmentVO> list  = mapper.getAttachmentList(bno);
		board.setAttaches(list);
		
		return mapper.read(bno);

	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modify(BoardVO board, List<MultipartFile> files)  throws Exception{
		int reuslt = mapper.update(board);
		
		Long bno = board.getBno();
		
		for(MultipartFile part: files) {
			if(part.isEmpty()) continue;
			BoardAttachmentVO attach = new BoardAttachmentVO(bno, part);
			mapper.insertAttachment(attach);
		}
		
		return reuslt == 1;

	}

	@Override
	public boolean remove(Long bno) {
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
	public boolean plusLikes(long bno) {
		return mapper.plusLikes(bno);
	}
}
