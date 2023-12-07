<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../layouts/headersecurity.jsp" %>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

<div style="width: 500px" class="mx-auto">

	<h4 class="mt-5">아이디 찾기 결과</h4>
	<hr>
	
	<p>고객님의 정보와 일치하는 아이디입니다.</p>
	
	<br>
	
	<div class="form-group">
		<label for="username"><i class="fa-solid fa-at"></i> 아이디</label>
		<input type="text" class="form-control" id="username" value="${member.username}"
			name="username" readonly="readonly">
	</div>
	
	<br>
	
	<div class="form-group">
		<label for="registerDate"><i class="fa-regular fa-calendar"></i> 가입일</label>
		<input type="text" class="form-control" id="registerDate" 
			value="<fmt:formatDate value="${member.registerDate}" pattern="yyyy-MM-dd"/>"
			name="registerDate" readonly="readonly">
	</div>
	
	<br>
	
	<div class="memberBtn">
		<a href="/security/login" class="btn btn-primary findloginBtn">로그인</a>
		<a href="/security/authenticationPassword" class="btn btn-primary findBtn"> 비밀번호찾기</a>
	</div>

</div>

<%@ include file="../layouts/footer.jsp" %>