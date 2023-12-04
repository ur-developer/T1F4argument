package org.galapagos.service;

import java.util.List;

import org.galapagos.domain.AuthorizationVO;
import org.galapagos.domain.DeleteMemberVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.ResetPasswordVO;
import org.galapagos.domain.UpdateMemberVO;
import org.galapagos.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public MemberVO getMember(String username) {
		
		return mapper.readMember(username);
	}
	
	@Override
	public boolean getNickname(String nickname) {
				
		return mapper.readNickname(nickname);
	}
	
	@Override
	public MemberVO getEmail(String email) {
		
		MemberVO member = mapper.readEmail(email);
		
		if(member == null) {
			return null;
		}
		
		return member;
	}
	
	@Override
	public boolean resetPassword(ResetPasswordVO resetPassword) {
		
		String encodingPassword = passwordEncoder.encode(resetPassword.getNewPassword());
		
		resetPassword.setNewPassword(encodingPassword);
		mapper.resetPassword(resetPassword);
		
		return true;
	}

	@Override
	public void registerMember(MemberVO member) {
		
		// 1. password 암호화 - 기존에 가지고 있던 비밀번호
		String encodingPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encodingPassword); // 암호화 한 비밀번호 다시 저장
		
		// 2. tbl_member 테이블에 저장
		mapper.insertMember(member);
		
		// 3. tbl_member_auth에 저장
		AuthorizationVO authorization = new AuthorizationVO(member.getUsername(), "ROLE_USER");
		
		mapper.insertAuthorization(authorization);
	}

	@Override
	public boolean updateMember(UpdateMemberVO updateMember) {
		
		MemberVO member = mapper.readMember(updateMember.getUsername());

		// 저장 된 비밀번호와 입력한 기존 비밀번호 일치 시 새로운 비밀번호 수정
		if(passwordEncoder.matches(updateMember.getOriginallyPassword(), member.getPassword())) {
			
			String encodingPassword = passwordEncoder.encode(updateMember.getNewPassword());
			
			updateMember.setNewPassword(encodingPassword);
			mapper.updateMember(updateMember);
			
			return true;
		}
		
		return false;
	}
	
	@Override
	public boolean deleteMember(DeleteMemberVO deleteMember) {
		
		MemberVO member = mapper.readMember(deleteMember.getUsername());
		
		// 비밀번호 일치 시 해당 멤버 삭제
		if(passwordEncoder.matches(deleteMember.getDeletePassword(), member.getPassword())) {
			
			mapper.deleteMember(member);
			
			return true;
		}
		
		return false;
	}

	@Override
	public List<Long> getMemberLikes() {
		return mapper.getMemberLikes();
	}

	@Override
	public List<Long> getFirstMember() {
		return mapper.getFirstMember();
	}

	@Override
	public List<Long> getSecondMember() {
		return mapper.getSecondMember();
	}

	@Override
	public List<Long> getThirdMember() {
		return mapper.getThirdMember();
	}

}
