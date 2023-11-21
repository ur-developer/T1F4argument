package org.galapagos.service;

import org.galapagos.domain.MemberVO;
import org.galapagos.domain.UpdateMemberVO;

public interface MemberService {
	public MemberVO getMember(String username);
	
	public void registerMember(MemberVO member);
	
	public void updateMember(UpdateMemberVO updateMember);
}
