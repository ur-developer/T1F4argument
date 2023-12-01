<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="wi	dth=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="author" content="" />
<title>Modern Business - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/main.js"></script>
</head>


<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">

		<!-- Navigation-->
		<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark "
			arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="${pageContext.request.contextPath}/">.갑론을박.</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarsFurni"
					aria-controls="navbarsFurni" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li><a class="nav-link"
							href="${pageContext.request.contextPath}/">메인</a></li>
						<li><a class="nav-link"
							href="${pageContext.request.contextPath}/issue/list">이슈 고르기</a></li>
						<li><a class="nav-link" href="/fame/list">이슈 명예 전당</a></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#"
							data-bs-toggle="dropdown" aria-expanded="false">갑론을박</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									href="/hotissue/get?pageNum=1&amount=10&type&keyword&category=1">첫번째 이슈</a></li>
								<li><a class="dropdown-item"
									href="/hotissue/get?pageNum=1&amount=10&type&keyword&category=2">두번째 이슈</a></li>
								<li><a class="dropdown-item"
									href="/hotissue/get?pageNum=1&amount=10&type&keyword&category=3">세번째 이슈</a></li>
								<li><a class="dropdown-item"
									href="/hotissue/get?pageNum=1&amount=10&type&keyword&category=4">네번째 이슈</a></li>
							</ul>
							<li class="nav-item active"><a class="nav-link"
							href="${pageContext.request.contextPath}/board/list">자유토론장</a></li>
						<li><a class="nav-link"
							href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
						<li><a class="nav-link" href="/suggest/list">요청 게시판</a></li>

					</ul>

					<ul class="navbar-nav ml-auto">
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.username" var="username" />

							<%-- 로그인 된 상태 --%>
							<li class="nav-item"><a class="nav-link"
								href="/security/profile"> ${username} </a></li>
							<li class="nav-item"><a class="nav-link logout-link"
								href="#"> <i class="fa-solid fa-right-from-bracket"></i>
									로그아웃
							</a></li>
						</sec:authorize>
						<sec:authorize access="isAnonymous()">
							<%-- 로그아웃 된 상태 --%>
							<li class="nav-item"><a class="nav-link"
								href="/security/login"> <i
									class="fa-solid fa-right-to-bracket"></i> <img
									src="${pageContext.request.contextPath}/resources/images/user.svg">
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/security/signup"> <i class="fa-solid fa-user-plus"></i>
									회원가입
							</a></li>
						</sec:authorize>
					</ul>
				</div>
			</div>
		</nav>
		
<form id="logoutForm" action="/security/logout" method="post" >
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

<script>
$(document).ready(function() {
	$('.logout-link').click(function(e) {
		e.preventDefault();
		$('#logoutForm').submit();		
	});
});
</script>
		
<a href="${pageContext.request.contextPath}/"> <img
	src="${pageContext.request.contextPath}/resources/images/header.jpg"
	width="100%"></a>
<section style="background-color: aliceblue;">
<br>
	<div style="margin: 140px; margin-top:20px">
				<!-- Header-->