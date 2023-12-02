package org.galapagos.mapper;

import java.util.List;

import org.galapagos.domain.AuthorizationVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.ResetPasswordVO;
import org.galapagos.domain.UpdateMemberVO;

public interface MemberMapper {
	
public MemberVO readMember(String username);
	
	public boolean readNickname(String nickname);
	
	public MemberVO readEmail(String email);
	
	public void insertMember(MemberVO member);
	
	public void insertAuthorization(AuthorizationVO authorization);
	
	public void updateMember(UpdateMemberVO updateMember);
	
	public void deleteMember(MemberVO member);
	
	public void resetPassword(ResetPasswordVO resetPassword);
	
	public List<Long> getMemberLikes();
}
