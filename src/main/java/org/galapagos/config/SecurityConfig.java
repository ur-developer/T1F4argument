package org.galapagos.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.galapagos.security.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
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

import lombok.extern.log4j.Log4j;


@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
		
	protected void configure(HttpSecurity http) throws Exception {
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		
		http.addFilterBefore(filter, CsrfFilter.class);			
		
		
		http.authorizeRequests()
			.antMatchers("/security/login", "/security/signup").permitAll()
			.antMatchers("/security/profile", "/security/updateform").authenticated()
			.antMatchers("/security/profile").authenticated();
		
		http.formLogin()
			.loginPage("/security/login?error=login_required")	// 로그인 안하고 접근한 경우 리다이렉트
			.loginProcessingUrl("/security/login")
			.defaultSuccessUrl("/")
			.failureUrl("/security/login?error=true");	// el : param.error
		

		http.logout()						// 로그아웃 설정 시작
		  	.logoutUrl("/security/logout")	// POST: 로그아웃 호출 url
		  	.invalidateHttpSession(true)	// 세션 invalidate
		  	.deleteCookies("remember-me", "JSESSION-ID")	// 삭제할 쿠키 목록
			.logoutSuccessUrl("/");	// 로그아웃 이후 이동할 페이지
		
		
		http.rememberMe()		// remember-me 기능 설정
			.key("Galapagos")
			.tokenRepository(persistentTokenRepository())
			.tokenValiditySeconds(7*24*60*60);	// 7일
		http.csrf().ignoringAntMatchers("/api/**");
		
	}

	@Autowired
	private DataSource dataSource;

	@Bean
	public UserDetailsService customUserService() {
		return new CustomUserDetailsService();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth)
						throws Exception {

		auth
			.userDetailsService(customUserService())
			.passwordEncoder(passwordEncoder());

	}


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
