package org.galapagos.mapper;

import org.galapagos.domain.AuthorizationVO;
import org.galapagos.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String username);
	
	public void insert(MemberVO member);
	
	public void insertAuth(AuthorizationVO authorization);
	
	
}
