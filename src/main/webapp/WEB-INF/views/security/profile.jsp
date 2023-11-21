<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<sec:authentication property="principal.member" var="member" />

<div style="width: 500px" class="mx-auto">
	
	<h1 class="mt-5"><i class="fa-solid fa-users"></i> 마이페이지</h1>

	<hr>
	<br>
	<br>

	<!-- <form action="update" method="post"> -->
		<div class="form-group">
			<label for="username"><i class="fa-solid fa-at"></i> 아이디</label>
			<input type="text" class="form-control" id="username" value="${member.username}"
				name="username" readonly="readonly">
		</div>
		
		<br>
		
		<div class="form-group">
			<label for="nickname"><i class="fa-solid fa-file-signature"></i> 닉네임</label>
			<input type="text" class="form-control" id="nickname" value="${member.nickname}"
				name="nickname" readonly="readonly">
		</div>
		
		<br>
		
		<div class="form-group">
			<label for="email"><i class="fa-solid fa-envelope-open-text"></i> 이메일</label>
			<input type="text" class="form-control" id="nickname" value="${member.email}"
				name="email" readonly="readonly">
		</div>
		
		<br>
			
		<div class="form-group">
			<label for="registerDate"><i class="fa-regular fa-calendar"></i> 가입일</label>
			<input type="text" class="form-control" id="registerDate" 
				value="<fmt:formatDate value="${member.registerDate}" pattern="yyyy-MM-dd HH:mm"/>"
				name="registerDate" readonly="readonly">
		</div>
		
		<br>
		
		<div class="btn">
			<a href="/security/updateform" class="btn btn-primary modifyBtn">
				<i class="fa-regular fa-pen-to-square"></i> 정보수정
			</a>
						
			<a href="#" class="btn btn-primary deleteBtn">
				<i class="fa-solid fa-user-slash"></i> 회원탈퇴
			</a>		
		</div>
		
</div>

<%@ include file="../layouts/footer.jsp" %>
