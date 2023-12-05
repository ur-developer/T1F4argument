package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.DeleteMemberVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.ResetPasswordVO;
import org.galapagos.domain.UpdateMemberVO;

public interface MemberService {
	
public MemberVO getMember(String username);
	
	public boolean getNickname(String nickname);
	
	public MemberVO getEmail(String email);
		
	public void registerMember(MemberVO member);
	
	public boolean resetPassword(ResetPasswordVO resetPassword);
	
	public boolean updateMember(UpdateMemberVO updateMember);
	
	public void updateAuthentication(UpdateMemberVO updateMember);
	
	public boolean deleteMember(DeleteMemberVO deleteMember);
	
	public List<Long> getMemberLikes();
	
	public List<Long> getFirstMember();
	
	public List<Long> getSecondMember();
	
	public List<Long> getThirdMember();
	
	
}
