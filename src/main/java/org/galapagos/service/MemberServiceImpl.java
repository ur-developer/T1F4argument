package org.galapagos.service;

import org.galapagos.domain.AuthorizationVO;
import org.galapagos.domain.MemberVO;
import org.galapagos.domain.UpdateMemberVO;
import org.galapagos.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
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
	public void registerMember(MemberVO member) {
		//1. 비밀번호 암호화
		String encPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encPassword);
		
		//2. tbl_member에 저장
		mapper.insertMember(member);
	
		//3. tbl_member_auth에 저장
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
}
