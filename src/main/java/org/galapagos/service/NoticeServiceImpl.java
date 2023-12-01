package org.galapagos.service;

import java.security.Principal;
import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;
import org.galapagos.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper mapper;
	
	@Override
	public int getNoticeTotal(Criteria cri) {
		log.info("get total count");

		return mapper.getNoticeTotalCount(cri);
	}

	@Override
	public List<BoardVO> getNoticeList(Criteria cri, Principal principal) {
		List<BoardVO> list = mapper.getNoticeList(cri);
		
		return list;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void registerNotice(BoardVO board) throws Exception {
		mapper.insertNoticeSelectKey(board);
		Long bno = board.getBno();

	}

	@Override
	public BoardVO getNotice(Long bno, Principal principal) throws Exception {
		BoardVO board = mapper.readNotice(bno);

		return board;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public boolean modifyNotice(BoardVO board)  throws Exception{
		int reuslt = mapper.updateNotice(board);
		
		Long bno = board.getBno();
		
		return reuslt == 1;
	}

	@Override
	public boolean removeNotice(Long bno) {
		log.info("remove...." + bno);

		return mapper.deleteNotice(bno) == 1;
	}
	
	@Override
	public boolean plusHit(long bno) {
		return mapper.plusHit(bno);
	}

	@Override
	public List<BoardVO> mainNotice() {
		return mapper.mainNotice();
	}
}
