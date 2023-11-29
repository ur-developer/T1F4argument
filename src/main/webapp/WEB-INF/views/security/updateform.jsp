<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

<%@ include file="../layouts/header.jsp" %>

<div style="width: 500px" class="mx-auto">

	<br>
	
	<h4>정보 수정</h4>

	<hr>
	<br>
	
	<form:form modelAttribute="updateMember" action="/security/updateform?_csrf=${_csrf.token}">
		
		<form:hidden path="username" value="${updateMember.username}"/>
		
		<div class="form-group">
			<form:label path="newNickname">닉네임</form:label>
			<form:input path="newNickname" value="${updateMember.newNickname}" class="form-control"/>
			<form:errors path="newNickname" cssClass="error"/>
		</div>
		
		<br>
		
		<div class="form-group">
			<form:label path="originallyPassword">현재 비밀번호</form:label>
			<form:password path="originallyPassword" class="form-control"/>
			<form:errors path="originallyPassword" cssClass="error"/>
		</div>
		
		<br>
		
		<div class="form-group">
			<form:label path="newPassword">비밀번호</form:label>
			<form:password path="newPassword" class="form-control"/>
			<form:errors path="newPassword" cssClass="error"/>
		</div>
		
		<br>
		
		<div class="form-group">
			<form:label path="checkNewPassword">비밀번호 확인</form:label>
			<form:password path="checkNewPassword" class="form-control"/>
			<form:errors path="checkNewPassword" cssClass="error"/>
		</div>
		
		<br>
		
		<div class="form-group">
			<form:label path="newEmail">이메일</form:label>
			<form:input path="newEmail" value="${updateMember.newEmail}" class="form-control"/>
			<form:errors path="newEmail" cssClass="error"/>
		</div>
		
		<br>
		
		<button type="submit" class="btn btn-primary submitBtn">
             수정
		</button>
		
	</form:form>
</div>

<%@ include file="../layouts/footer.jsp" %>