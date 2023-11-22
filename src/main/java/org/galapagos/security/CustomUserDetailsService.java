package org.galapagos.security;

import org.galapagos.domain.MemberVO;
import org.galapagos.mapper.MemberMapper;
import org.galapagos.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		//log.warn("load user username : " + username);
		
		MemberVO member = mapper.readMember(username);
		
		if(member == null)
			throw new UsernameNotFoundException(username + "is not found");
		
		//log.warn(member);		
		
		return new CustomUser(member);
	}

}
