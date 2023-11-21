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

	public static final String AVATAR_UPLOAD_DIR = "c:/upload/avatar";
	
	@Autowired
	MemberMapper mapper;

	@Autowired
	private PasswordEncoder passwordEncoder;	
	
	@Override
	public MemberVO getMember(String username) {
		return mapper.read(username);
	}

	
	@Override
	public void registerMember(MemberVO member) {
		//1. 비밀번호 암호화
		String encPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encPassword);
		
		//2. tbl_member에 저장
		mapper.insert(member);

	
		//3. tbl_member_auth에 저장
		AuthorizationVO authorization = new AuthorizationVO(member.getUsername(),
								"ROLE_USER");
		mapper.insertAuthorization(authorization);
		
	}
	
	@Override
	public void updateMember(UpdateMemberVO updateMember) {

		String encodingPassword = passwordEncoder.encode(updateMember.getNewPassword());
			
		updateMember.setNewPassword(encodingPassword);
		mapper.updateMember(updateMember);		
	}
}
