package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.BoardVO;
import org.galapagos.domain.Criteria;

public interface HotIssueMapper {

	public List<BoardVO> getHotissueList(Criteria cri);

	public int getHotissueTotalCount(Criteria cri);

	public List<BoardVO> getHotissueListWithPaging(Criteria cri);
	
	public BoardVO readHotissue(Long bno);
	
	public List<Long> getLikesList(String name);

}
