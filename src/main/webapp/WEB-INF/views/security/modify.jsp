<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp" %>

<sec:authentication property="principal.member" var="member" />

<div style="width: 500px" class="mx-auto">
	<h1 class="my-5"><i class="fa-solid fa-user-plus"></i> 회원정보 변경</h1>
	<div>
		<form:form modelAttribute="member"
			action="/security/modify?_csrf=${_csrf.token}" 
			enctype="multipart/form-data">
		
			<div class="form-group">
				<form:label path="username"><i class="fa-solid fa-user"></i>사용자 ID: </form:label>
	 			<h1> ${member.username}	</h1>
	 		</div>
	 		
            <div class="row_item lock">
            	<form:label path="password"><i class="fa-solid fa-user"></i> 비밀번호:
            	<a class="nav-link" href="/security/change_password">        	  		
            	    <span class="item_text">비밀번호 수정</span>
                </a>
				</form:label>
       	    </div>
			
			<div class="form-group">
				<form:label path="nickname"><i class="fa-solid fa-user"></i> 사용자 이름:</form:label>
				<form:input path="nickname" cssClass="form-control"/>
				<form:errors path="nickname" cssClass="error"/>
	 		</div>
	 		
			<div class="form-group">
				<form:label path="email"><i class="fa-regular fa-envelope"></i> email:</form:label>
				<form:input path="email" class="form-control" />
				<form:errors path="email" cssClass="error"/>				
			</div>
			
			<input type="file" name="avatar" />
		<hr>
		
		<div>			
			<button type="submit" class="btn btn-primary">
        	     <i class="fas fa-check"></i> 확인</button>
			<button type="reset" class="btn btn-primary">
          	   <i class="fas fa-undo"></i> 취소</button>
			<a href="/security/profile" class="btn btn-primary get">
            	 <i class="fas fa-file-alt"></i> 돌아가기</a>
         </div>
             
		</form:form>
	</div>
</div>	
<%@ include file="../layouts/footer.jsp" %>
