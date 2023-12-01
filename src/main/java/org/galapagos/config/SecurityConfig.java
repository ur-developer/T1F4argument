package org.galapagos.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.galapagos.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	// PasswordEncoder (비밀번호 암호화)
	@Bean
	public PasswordEncoder pwEncoder() {
			
		return new BCryptPasswordEncoder();
	}
	
	@Autowired
	private DataSource dataSource;

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		// 문자 필터 추가
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		
		// csrf필터 앞에 문자 필터 추가
		http.addFilterBefore(filter, CsrfFilter.class);
				
		// /api/로 오는 요청은 csrf 체크 무시
		http.csrf().ignoringAntMatchers("/api/**");
		
		// 요청에 대한 접근 권한 설정
		http.authorizeRequests()
			.antMatchers(
					"/security/login", 
					"/security/signup",
                    "/security/authentication",
                    "/security/authenticationPassword").permitAll()
			
			.antMatchers("/security/profile", 
					"/security/updateform",
					"/security/deleteform",
					"/security/findIDResult",
					"/issue/register",
					"/board/register").authenticated()
			
			.antMatchers(
				"/notice/register",
				"/notice/modify",
				"/notice/remove").access("hasRole('ROLE_ADMIN')");
			

		// 로그인 설정
		http.formLogin()
			.loginPage("/security/login?error=login_required") // get요청 (로그인 안 하고 접근 시 리다이렉트)
			.loginProcessingUrl("/security/login") // post요청
			.defaultSuccessUrl("/") // 로그인 성공 시 이동할 페이지
			.failureUrl("/security/login?error=true"); // el:param.error로 접근

		// 로그아웃 설정
		http.logout()
			.logoutUrl("/security/logout") // post = csrf token 필요
			.invalidateHttpSession(true) // 세션 무효
			.deleteCookies("remember-me", "JSESSION-ID") // 삭제할 쿠키 목록
			.logoutSuccessUrl("/"); // 로그아웃 시 이동할 페이지
		
		// remember-me
		http.rememberMe()
			.key("galapagos")
			.tokenRepository(persistentTokenRepository())
			.tokenValiditySeconds(7*24*60*60); // 7일
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth
		.userDetailsService(customUserService())
		.passwordEncoder(pwEncoder());
	}
	
	// user 정보 조회
	@Bean
	public UserDetailsService customUserService() {
		
		return new CustomUserDetailsService();
	}
	
	// remember-me
	@Bean
	public PersistentTokenRepository persistentTokenRepository() {
		
		JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
		repo.setDataSource(dataSource);
		
		return repo;
	}
	
	@Bean
	public JavaMailSender getJavaMailSender() {
		
		Properties properties = new Properties(); 
		properties.put("mail.smtp.auth", true);
		properties.put("mail.transport.protocol", "smtp");
		properties.put("mail.smtp.starttls.enable", true);
		properties.put("mail.smtp.starttls.required", true);
		properties.put("mail.debug", true);
		properties.put("mail.smtp.ssl.enable", true);
		
		// 네이버 smtp 설정
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		mailSender.setHost("smtp.naver.com");
		mailSender.setPort(465); // 네이버 smtp 포트 번호
		mailSender.setUsername("daily_bubbly@naver.com"); // 보내는 이메일
		mailSender.setPassword("J6WU8PRC9XG1"); // 이메일 계정 비밀번호
		mailSender.setDefaultEncoding("utf-8");
		mailSender.setJavaMailProperties(properties);
		
		return mailSender;
		
	}

}