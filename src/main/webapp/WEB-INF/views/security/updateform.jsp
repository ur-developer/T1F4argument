<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/header.jsp" %>

<div style="width: 500px" class="mx-auto">

	<h4 class="mt-5"><i class="fa-solid fa-users"></i> 정보 수정</h4>

	<hr>
	<br>
	<br>
	
	<form:form modelAttribute="updateMember" action="/security/updateform?_csrf=${_csrf.token}">
		
		<form:hidden path="username" value="${updateMember.username}"/>
		
		<div class="form-group">
			<form:label path="newNickname"><i class="fa-solid fa-file-signature"></i> 닉네임</form:label>
			<form:input path="newNickname" value="${updateMember.newNickname}" class="form-control"/>
			<form:errors path="newNickname" cssClass="error"/>
		</div>
		
		<div class="form-group">
			<form:label path="originallyPassword"><i class="fa-solid fa-lock"></i> 현재 비밀번호</form:label>
			<form:password path="originallyPassword" class="form-control"/>
			<form:errors path="originallyPassword" cssClass="error"/>
		</div>
		
		<div class="form-group">
			<form:label path="newPassword"><i class="fa-solid fa-lock"></i> 새 비밀번호</form:label>
			<form:password path="newPassword" class="form-control"/>
			<form:errors path="newPassword" cssClass="error"/>
		</div>
		
		<div class="form-group">
			<form:label path="checkNewPassword"><i class="fa-solid fa-lock"></i> 새 비밀번호 확인</form:label>
			<form:password path="checkNewPassword" class="form-control"/>
			<form:errors path="checkNewPassword" cssClass="error"/>
		</div>
		
		<div class="form-group">
			<form:label path="newEmail"><i class="fa-solid fa-envelope-open-text"></i> 이메일</form:label>
			<form:input path="newEmail" value="${updateMember.newEmail}" class="form-control"/>
			<form:errors path="newEmail" cssClass="error"/>
		</div>
		
		<button type="submit" class="btn btn-primary">
             <i class="fas fa-check"></i> 수정
		</button>
		
	</form:form>
</div>

<%@ include file="../layouts/footer.jsp" %>