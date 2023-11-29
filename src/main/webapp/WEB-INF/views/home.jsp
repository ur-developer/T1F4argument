<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="layouts/headermain.jsp"%>
<!-- Header-->

<div class="user-wrap">
	<div class="user-image">
		<img
			src="${pageContext.request.contextPath}/resources/images/mainexex.jpg"
			width=100%; height=100%;></a>
	</div>
	<div class="user-text">
		<p style="color: white">갑론을박</p>
		<h4 style="color: white">논쟁가들의 콜로세움</h4>
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
				<h2 style="text-align: center; color: white;">금일의 갑론을박 주제</h2>
			</div>
			<div class="mx-5"
				style="background-image: url('images/mainex2.jpg'); border-style: solid; border-color: gray;">

				<div class="slide slide_wrap " style="height: 120px;">
					<div class="slide_item item1" style="height: 120px;">
						<div class="overflow-hidden ">
							<p>
							<h4 style="text-align: center;">
								<a href="" style="color: white;">주제 넣어주세요</a>
							</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item2">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center; color: white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item3">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center; color: white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_item item4">
						<div class="overflow-hidden">
							<p>
							<h4 style="text-align: center; color: white;">주제 넣어주세요</h4>
							</p>
							<img src="" alt="">
						</div>
					</div>
					<div class="slide_prev_button slide_button">
						<h4 style="color: white">◀</h4>
					</div>
					<div class="slide_next_button slide_button">
						<h4 style="color: white">▶</h4>
					</div>
					<ul class="slide_pagination"></ul>
				</div>
			</div>


		</div>
	</div>
</section>

<!-- 사이드 플로팅 -->

<div id="floatMenu">플로팅 메뉴</div>

<!-- 메인 섹션 1 -->

<section class="py-5" style="background-color: aliceblue;">
	<div class="container px-5">
		<div class="row gx-10"
			style="width: 800px; float: none; margin: auto;">
			<div class="col-md-5" style="float: none; margin: auto;">
				<h2 style="text-align: center;">
					이슈 명예전당
					</h1>
					<hr class="layouts">
					<br>
					<div
							class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
							style="width: 100%; height: 200px; float: none; margin: 0 auto; background-color: white">

							<h2 class="mb-0" style="float: none; margin: 0 auto;">
								제목
								</h3>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;">날짜</div>
								<br> <br>
								<p class="card-text mb-auto"
									style="float: none; margin: 0 auto;">내용</p>
								<br> <a href="${pageContext.request.contextPath}/fame/list"
									class="icon-link gap-1 icon-link-hover stretched-link">
									명예전당 바로가기 </a>
						</div>
					<h2 style="text-align: center;">
						이슈 고르기
						</h1>
						<hr class="layouts">
						<a href="issue/list" style="color: gray;"><h4
								style="margin: 0; text-align: right;">+</h4></a>
						<div
							class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
							style="width: 100%; height: 200px; float: none; margin: 0 auto; background-color: white">

							<h2 class="mb-0" style="float: none; margin: 0 auto;">
								제목
								</h3>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;">날짜</div>
								<br> <br>
								<p class="card-text mb-auto"
									style="float: none; margin: 0 auto;">내용</p>
								<br> <a href="이슈 명예 전당 페이지"
									class="icon-link gap-1 icon-link-hover stretched-link">
									이슈 고르기 바로가기 </a>
						</div>
			</div>
			<div class="col-md-5" style="float: none; margin: auto;">

				<h2 style="text-align: center;">오늘의 구글은?</h2>
				<hr class="layouts">
				<br>
				<script type="text/javascript"
					src="https://ssl.gstatic.com/trends_nrtr/3523_RC02/embed_loader.js"></script>
				<script type="text/javascript">
					trends.embed
							.renderWidget(
									"dailytrends",
									"",
									{
										"geo" : "KR",
										"guestPath" : "https://trends.google.co.kr:443/trends/embed/"
									});
				</script>
			</div>
		</div>
</section>

<hr class="hr-layout">


<!--  메인섹션 2 -->

<section class="py-5">

		<div class="container px-5">
		<div class="row gx-10">

			<div class="row mb-4">

				<div class="col-md-4" style="float: none; margin: 0 auto;">
					<h2 style="text-align: center;">
						자유게시판
						</h1>
						<div
							class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							
							<div class="col p-1 d-flex flex-column position-static">
								<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
								<h2 class="mb-0" style="float: none; margin: 0 auto;">
									제목
									</h3>

									<div class="mb-1 text-body-secondary"
										style="float: none; margin: 0 auto;">날짜</div>
									<br> <br>
									<p class="card-text mb-auto"
										style="float: none; margin: 0 auto;">내용</p>
									<br> <a
										href="${pageContext.request.contextPath}/notice/list"
										class="icon-link gap-1 icon-link-hover stretched-link">게시판 가기 </a>
							</div>

						</div>
				</div>
				<div class="col-md-4" style="float: none; margin: 0 auto;">
					<h2 style="text-align: center;">
						공지사항
						</h1>
						<div
							class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							
							<div class="col p-1 d-flex flex-column position-static">
								<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
								<h2 class="mb-0" style="float: none; margin: 0 auto;">
									제목
									</h3>

									<div class="mb-1 text-body-secondary"
										style="float: none; margin: 0 auto;">날짜</div>
									<br> <br>
									<p class="card-text mb-auto"
										style="float: none; margin: 0 auto;">내용</p>
									<br> <a
										href="{pageContext.request.contextPath}/notice/list"
										class="icon-link gap-1 icon-link-hover stretched-link">게시판 가기 </a>
							</div>

						</div>
				</div>
				<div class="col-md-4" style="float: none; margin: 0 auto;">
					<h2 style="text-align: center;">
						요청사항
						</h1>
						<div
							class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							<div class="col p-1 d-flex flex-column position-static">
								<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
								<h2 class="mb-0" style="float: none; margin: 0 auto;">
									제목
									</h3>

									<div class="mb-1 text-body-secondary"
										style="float: none; margin: 0 auto;">날짜</div>
									<br> <br>
									<p class="card-text mb-auto"
										style="float: none; margin: 0 auto;">내용</p>
									<br> <a
										href="{pageContext.request.contextPath}/suggest/list"
										class="icon-link gap-1 icon-link-hover stretched-link"> 게시판 가기 </a>
							</div>

						</div>
				</div>
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
