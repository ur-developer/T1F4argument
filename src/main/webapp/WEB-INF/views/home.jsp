<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="layouts/headermain.jsp"%>
<!-- Header-->

<div class="user-wrap">
<div class="user-image">
 <img src="${pageContext.request.contextPath}/resources/images/mainexex.jpg"
	width=100%; height=100%;></a>
</div>
<div class="user-text">
<p style="color:white">갑론을박</p>
<h3 style="color:white">논쟁가들의 콜로세움</h3>
</div>
</div>

<!-- Features section-->
<!-- 자동 슬라이드-->
<!-- 가운데 정렬 해야합니다.-->

<section class="py-3 pb-3" id="features"
	style="background-color: black; height: auto;">
	<div style="width: 50%; margin: auto;">

		<div class="container-sm px-5 my-3">
			<div class="row gx-5 sh">
				<h2 style="text-align: center; color:white;">금일의 갑론을박 주제</h2>
			</div>

			<div class="mx-5"
				style="background-image: url('images/mainex2.jpg'); border-style: solid; border-color: gray;">

				<div class="slide slide_wrap " style="height: 120px;">
					<div class="slide_item item1" style="height: 120px;">
						<div class="overflow-hidden ">
							<p>
							<h4 style="text-align: center;">
								<a href="" style="color:white;">주제 넣어주세요</a>
							</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item2">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center;color:white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item3">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center;color:white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item4">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center;color:white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_prev_button slide_button"><h4 style="color:white">◀</h4></div>
					<div class="slide_next_button slide_button"><h4 style="color:white">▶</h4></div>
					<ul class="slide_pagination"></ul>
				</div>
			</div>
			<!--  <script src="./slide.js"></script> -->

		</div>
	</div>
</section>
<section class="py-5" style="background-color:aliceblue;">
	<div class="container px-5"style=" justify-content : center;" >
		<div class="row gx-10"style="width: 800px; float: none; margin:auto;">
			<div class="col-md-5" style="float: none; margin:auto;">
				<h2 style="text-align: center;">
					이슈 명예전당
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 100%; height: 200px;float: none; margin: 0 auto;">
						<div class="col-lg-auto d-none d-lg-block">
							<!--  <img
								src="${pageContext.request.contextPath}/resources/images/hotissue.png">
						-->
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
							<!-- <h2 class="mb-0" style="float: none; margin: 0 auto;">
									제목
									</h3>

									<div class="mb-1 text-body-secondary"
										style="float: none; margin: 0 auto;">날짜</div>
									<br> <br>
									<p class="card-text mb-auto"
										style="float: none; margin: 0 auto;">내용</p>
									<br> <a href="이슈 명예 전당 페이지"
										class="icon-link gap-1 icon-link-hover stretched-link">
										명예전당 바로가기 </a> -->
						</div>

					</div>
					<h2 style="text-align: center;">
					이슈 고르기
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 100%; height: 200px;float: none; margin: 0 auto;">
						<div class="col-lg-auto d-none d-lg-block">
							<!--  <img
								src="${pageContext.request.contextPath}/resources/images/hotissue.png">
						-->
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
							<!-- <h2 class="mb-0" style="float: none; margin: 0 auto;">
									제목
									</h3>

									<div class="mb-1 text-body-secondary"
										style="float: none; margin: 0 auto;">날짜</div>
									<br> <br>
									<p class="card-text mb-auto"
										style="float: none; margin: 0 auto;">내용</p>
									<br> <a href="이슈 명예 전당 페이지"
										class="icon-link gap-1 icon-link-hover stretched-link">
										명예전당 바로가기 </a> -->
						</div>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin:auto;">
			<h2 style="text-align: center;">오늘의 구글은?</h2><script type="text/javascript" src="https://ssl.gstatic.com/trends_nrtr/3523_RC02/embed_loader.js"></script> <script type="text/javascript"> trends.embed.renderWidget("dailytrends", "", {"geo":"KR","guestPath":"https://trends.google.co.kr:443/trends/embed/"}); </script>
		</div>
		</div>
</section>

<hr class="hr-layout">


<!-- -->

<section class="py-5">



	<div class="container px-5">
		<div class="row gx-10">


			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					갑론을박 게시판
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px;">
						<div class="mb-4">
							<div class="small text-muted">May 12, 2023</div>
							<a class="link-dark" href="#!">
								<h3>여러가지</h3>
							</a>
						</div>
						<!-- News item-->
						<div class="mb-5">
							<div class="small text-muted">May 5, 2023</div>
							<a class="link-dark" href="#!">
								<h3>바락바락 버럭버럭</h3>
							</a>
						</div>
						<!-- News item-->
						<div class="mb-5">
							<div class="small text-muted">Apr 21, 2023</div>
							<a class="link-dark" href="#!">
								<h3>글을 더 넣을 수도 있습니당</h3>
							</a>
						</div>
						<div class="text-end mb-5 mb-xl-0">
							<a class="text-decoration-none" href="#!"> 갑론을박 게시판 <i
								class="bi bi-arrow-right"></i>
							</a>
						</div>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					공지사항
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px;">
						<div class="mb-4">
							<div class="small text-muted">05 12, 2023</div>
							<a class="link-dark" href="#!">
								<h3>프로젝트 어쩌고,,, 글 어쩌고,,</h3>
							</a>
						</div>
						<!-- News item-->
						<div class="mb-5">
							<div class="small text-muted">May 5, 2023</div>
							<a class="link-dark" href="#!">
								<h3>글이 들어갈 자리 입니다</h3>
							</a>
						</div>
						<!-- News item-->
						<div class="mb-5">
							<div class="small text-muted">Apr 21, 2023</div>
							<a class="link-dark" href="#!">
								<h3>글이 들어갈 자리 입니다</h3>
							</a>
						</div>
						<div class="text-end mb-5 mb-xl-0">
							<a class="text-decoration-none" href="#!"> 공지사항 보기 <i
								class="bi bi-arrow-right"></i>
							</a>
						</div>

					</div>
			</div>
</section>

<!-- Testimonial section-->
<div class="py-5" style="background-color: bisque;">
	<div class="container px-5 my-5">
		<div class="row gx-5 justify-content-center">
			<div class="col-lg-10 col-xl-7">
				<div class="text-center">
					<div class="fs-4 mb-4 fst-italic">채팅방</div>
					<div class="container"
						style="border-style: solid; width: 720px; height: 720px;"></div>
					<br>
					<div class="d-flex align-items-center justify-content-center">


						<img class="rounded-circle me-3"
							src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
						<div class="fw-bold">
							닉네임<span class="fw-bold text-primary mx-1">/</span> 아이디
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="layouts/footermain.jsp"%>
