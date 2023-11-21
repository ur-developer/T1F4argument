<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp" %>

<div style="width: 500px" class="mx-auto">
	<h1 class="my-5"><i class="fa-solid fa-user-plus"></i> 회원 가입</h1>
	<div>
		<form:form modelAttribute="member"
			action="/security/change_password?_csrf=${_csrf.token}">
		
			<div class="form-group">
				<form:label path="orgPassword"><i class="fa-solid fa-lock"></i> 이전 비밀번호:</form:label>
				<form:password path="orgPassword" class="form-control" />
				<form:errors path="orgPassword" cssClass="error"/>				
			</div>
			
			<div class="form-group">
				<form:label path="newPassword"><i class="fa-solid fa-lock"></i> 새로운 비밀번호:</form:label>
				<form:password path="newPassword" class="form-control" />
				<form:errors path="newPassword" cssClass="error"/>				
			</div>
			
			<div class="form-group">
				<form:label path="newPassword2"><i class="fa-solid fa-lock"></i> 새로운 비밀번호 확인:</form:label>
				<form:password path="newPassword2" class="form-control" />
				<form:errors path="newPassword2" cssClass="error"/>				
			</div>
		
			<div class="text-center">
				<button type="submit" class="btn btn-primary"><i class="fa-solid fa-user-plus"></i> 확인</button>
			</div>
		</form:form>
	</div>
</div>	
<%@ include file="../layouts/footer.jsp" %>
