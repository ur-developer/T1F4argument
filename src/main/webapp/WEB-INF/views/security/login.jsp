<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/header.jsp"%>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

<div style="width: 500px" class="mx-auto">

	<c:if test="${param.error == 'true' }">
		<div class="error">사용자 ID 또는 비밀번호가 일치하지 않습니다.</div>
	</c:if>
	<c:if test="${param.error == 'login_required' }">

		<div class="error">
			로그인이 필요한 서비스입니다.
		</div>
	</c:if>	
	
	<div>
    	<sec:authorize access="isAnonymous()">
        
            <form action="/security/login" method="post" >
            
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                
                <div class="form-group">
                  <label for="username">아이디</label>
                  <input type="text" name="username" id="username" class="form-control" />
                </div>
                
                <br>
            
                <div class="form-group">
                  <label for="password">비밀번호</label>
                  <input type="password" name="password" id="password" class="form-control" />
                </div>
                
                <br>
            
                <div class="form-group form-check">
                  <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" name="remember-me" /> 로그인 유지
                  </label>
                </div>
                
                <br>
            
                <button type="submit" class="btn btn-primary btn-block loginBtn">
                  로그인
                </button>
                
                <br>
                <br>
                
                <div class="memberBtn">
                    <a href="/security/authentication">아이디찾기</a>
                    <a href="/security/authenticationPassword"> 비밀번호찾기</a>
                </div>	    
			</form>
		</sec:authorize>
	</div>
	
    <sec:authorize access="isAuthenticated()">
        
	    <input type="hidden" name="username" value='<sec:authentication property="principal.username"/>'/>
        
        <div class="memberBtn">
            <form action="/security/logout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" class="btn btn-primary logoutBtn" value="로그아웃"/>
            </form>
            
            <br>
            
            <form action="/security/profile" method="get">
                <input type="submit" class="btn btn-primary profileBtn" value="마이페이지"/>            
            </form>
            
        </div>    
    </sec:authorize>
</div>


<%@ include file="../layouts/footer.jsp"%>