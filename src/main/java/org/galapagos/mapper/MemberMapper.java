package org.galapagos.mapper;

import org.galapagos.domain.AuthorizationVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.UpdateMemberVO;

public interface MemberMapper {
	
	public MemberVO readMember(String username);
	
	public boolean readNickname(String nickname);
	
	public void insertMember(MemberVO member);
	
	public void insertAuthorization(AuthorizationVO authorization);
	
	public void updateMember(UpdateMemberVO updateMember);
}
