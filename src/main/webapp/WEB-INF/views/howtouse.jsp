<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Stylish Portfolio - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Simple line icons-->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.5.5/css/simple-line-icons.min.css"
	rel="stylesheet" />
<!-- Google fonts-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/howto.css" rel="stylesheet" />
</head>
<body id="page-top">
	<!-- Navigation-->
	<!-- Header-->
	<header class="masthead d-flex align-items-center">
		<div class="container px-4 px-lg-5 text-center">
			<h1 class="mb-1" style="color: white;">갑론을박</h1>
			<h3 class="mb-5" style="color: white;">
				<em>논쟁가들의 콜로세움</em>
			</h3>
			<a class="btn btn-primary btn-xl" href="#services">사용 설명서 시작</a>
		</div>
	</header>
	<!-- Services-->
	<section class="content-section bg-primary text-white text-center"
		id="services">
		<div class="container px-4 px-lg-5">
			<div class="content-section-heading">
				<h3 class="text-secondary mb-0">갑론을박</h3>
				<h2 class="mb-5">무엇을 할 수 있나요?</h2>
			</div>
			<div class="row gx-4 gx-lg-5">
				<div class="col-lg-3 col-md-6 mb-5 mb-lg-0">
					<span class="service-icon rounded-circle mx-auto mb-3"><i
						class="icon-pencil"></i></span>
					<h4>
						<strong>이슈 만들기</strong>
					</h4>
					<p class="text-faded mb-0">여러분이 원하는 이슈를 직접 만들어 보세요!</p>
				</div>
				<div class="col-lg-3 col-md-6 mb-5 mb-lg-0">
					<span class="service-icon rounded-circle mx-auto mb-3"><i
						class="icon-like"></i></span>
					<h4>
						<strong>핫 이슈 고르기</strong>
					</h4>
					<p class="text-faded mb-0">좋아요를 눌러 유저들이 직접 만든 이슈들 중 오늘의 핫 이슈를
						골라보세요!</p>
				</div>
				<div class="col-lg-3 col-md-6 mb-5 mb-md-0">
					<span class="service-icon rounded-circle mx-auto mb-3"><i
						class="icon-speech"></i></span>
					<h4>
						<strong>갑론을박 게시판</strong>
					</h4>
					<p class="text-faded mb-0">오늘의 핫 이슈로 선정된 주제에 대하여 논쟁을 시작하세요! 두개의
						진영 중 하나만 선택할 수 있어요!</p>
				</div>
				<div class="col-lg-3 col-md-6">
					<span class="service-icon rounded-circle mx-auto mb-3"><i
						class="icon-diamond"></i></span>
					<h4>
						<strong>명예의 전당</strong>
					</h4>
					<p class="text-faded mb-0">참신한 아이디어와 활발한 활동을 통해 명예의 유저, 명예의 이슈를
						차지해보세요!</p>
				</div>
			</div>
		</div>
	</section>
	<!-- About-->
	<section class="content-section" id="about">
		<div class="container px-4 px-lg-5 text-center">
			<div class="row gx-4 gx-lg-5 justify-content-center">
				<div class="col-lg-10">
					<h2>"논쟁은 절제된 감정 아래 행해야 한다"</h2>
					<p class="lead mb-5">
						과도한 비난과 욕설은 자제 부탁드립니다! 갑론을박 커뮤니티는 긍정적인 토론 문화를 지향합니다! <br>
						커뮤니티의 기본 규칙을 지키지 않는 유저가 보인다면?

					</p>
					<a class="btn btn-dark btn-xl" href="suggest/list">신고하러 가기</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Callout-->
	<section class="callout">
		<div class="container px-4 px-lg-5 text-center">
			<h2 class="mx-auto mb-5">
				지금 바로 <br> 시작해보세요!
			</h2>
			<a class="btn btn-primary btn-xl"
				href="issue/list">이슈
				고르기</a>
		</div>
	</section>
	<!-- Portfolio-->

	<!-- Footer-->
	<footer class="footer text-center">
		
			<p class="text-muted small mb-0">Copyright &copy; Your Website
				2023</p>
		
	
	
	</footer>

