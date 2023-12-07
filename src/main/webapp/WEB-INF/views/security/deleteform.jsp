<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/headersecurity.jsp" %>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

<div style="width: 500px" class="mx-auto">
	
	<h4 class="mt-5">회원 탈퇴</h4>

	<hr>
	<br>
	
	<form:form modelAttribute="deleteMember" action="/security/deleteform?_csrf=${_csrf.token}">
	
		<form:hidden path="username" value="${deleteMember.username}"/>

		<div class="warningText">
		
			<p>탈퇴하시기 전에 꼭 안내사항을 읽어주세요</p>
			
			<br>
			<br>
			
			<h5><i class="fa-solid fa-check" style="color: #ff0000;"></i>
			 사용 중인 아이디(<strong>${deleteMember.username}</strong>)는</h5>
			<h5>탈퇴할 경우 복구가 불가하니 신중하게 결정해 주세요.</h5>
			
			<br>
			
			<p class="warningRed">탈퇴 시 <strong>개인 정보가 모두 삭제</strong>됩니다.</p>
			
			<br>
			<hr>
			<br>
			
			<p><i class="fa-solid fa-check" style="color: #ff0000;"></i>
				 탈퇴를 계속하시려면 비밀번호 입력 후 확인 버튼을 눌러주세요.
			</p>
			
			<div class="form-group">
				<form:password path="deletePassword" placeholder="비밀번호를 입력하세요." class="form-control"/>
				<form:errors path="deletePassword" cssClass="error"/>
			</div>
			
		</div>
		
		<br>
		
		<div class="memberBtn">
			<button type="submit" class="btn btn-primary btn-block deleteBtn">
				<i class="fa-solid fa-right-to-bracket"></i> 회원 탈퇴
	       	</button>
       	</div>
       	
	</form:form>
	
</div>


<%@ include file="../layouts/footer.jsp" %>