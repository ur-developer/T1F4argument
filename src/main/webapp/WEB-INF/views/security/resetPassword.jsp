<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/headersecurity.jsp" %>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<div style="width: 500px" class="mx-auto">

	<h4 class="mt-5">비밀번호 수정</h4>

	<hr>
	<br>
	
	<form:form modelAttribute="resetPassword" action="/security/resetPassword?_csrf=${_csrf.token}">
	
		<form:hidden path="username" value="${resetPassword.username}"/>
	
		<div class="form-group">
			<form:label path="newPassword">새 비밀번호</form:label>
			<form:password path="newPassword" class="form-control"/>
			<form:errors path="newPassword" cssClass="error"/>
		</div>
		
		<br>
			
		<div class="form-group">
			<form:label path="checkNewPassword">새 비밀번호 확인</form:label>
			<form:password path="checkNewPassword" class="form-control"/>
			<form:errors path="checkNewPassword" cssClass="error"/>
		</div>
		
		<br>
		
		<button type="submit" class="btn btn-primary submitBtn">수정</button>
		
	</form:form>

</div>

<%@ include file="../layouts/footer.jsp" %>