<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="layouts/headermain.jsp"%>
<!-- Header-->
<div class="user-wrap">
	<div class="user-image" style="text-align:center;">
		<img
			src="${pageContext.request.contextPath}/resources/images/mainexex.jpg"
			style="width:1540px; height:100%;"></a>
	</div>
	<div class="user-text">
	<br>
		<h1 style="color: white">논쟁가들의 콜로세움</h1>
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
				<h2 style="text-align: center; color: white;">논쟁 참여하기</h2>
			</div>

			<div class="mx-5"
				style="background-image: url('images/mainex2.jpg'); border-style: solid; border-color: gray;">

				<div class="slide slide_wrap " style="height: 120px;">
					<c:forEach var="board" items="${getHotissueList}">
						<div class="slide_item item1" style="height: 120px;">
							<div class="overflow-hidden ">
								<p>

									<h3 style="text-align: center;"><a href="/hotissue/get?bno=${board.bno}" style="color: white;">${board.title}</a></h3>
								</p>
								<img src="" alt="">
							</div>
						</div>
					</c:forEach>

					<div class="slide_prev_button slide_button">
						<h3 style="color: white">◀</h3>
					</div>
					<div class="slide_next_button slide_button">
						<h3 style="color: white">▶</h3>
					</div>
					<ul class="slide_pagination"></ul>

				</div>

			</div>


		</div>
	</div>
</section>
<a href="${pageContext.request.contextPath}/howtouse">
<div class="sideBanner">
  </div>
  
  </a>
<!-- 메인 섹션 1 -->
<section class="py-5" style="text-align:center; background-color:aliceblue;">
	
		<h2><i>갑론을박(甲論乙駁)</i></h2>
		<p><i>「명사」 여러 사람이 서로 자신의 주장을 내세우며 상대편의 주장을 반박함.</i></p>
</section>

<section class="py-5 bg-light" >
	<div class="container px-5" style="width: 900px;">
		<div class="row gx-10" style="float: none; margin: 0 auto;">

			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					이슈명예전당
					</h1>
					<hr class="layouts">
					<br>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px; height: 250px; float: none; margin: 0 auto;">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th style="text-align: center">제목</th>
									<th style="text-align: center">작성자</th>
								</tr>
							</thead>
							<tbody>
								 <c:forEach var="board" items="${getFameList}">
									<tr>
                                    <td><a href="issue/get?bno=${board.bno}">${board.title}</a></td>
                                   	<td style="width: 130px; text-align: center;">${board.nickname}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					이슈고르기
					</h1>
					<hr class="layouts">
					<a href="issue/list" style="color: gray;"><h4
							style="margin: 0; text-align: right;">+</h4></a>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px; height: 250px; float: none; margin: 0 auto;">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th style="text-align: center">제목</th>
									<th style="text-align: center">작성자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="board" items="${mainIssue}">
									<tr>
										<td><a href="issue/get?bno=${board.bno}">${board.title}</a></td>
										<td style="width: 130px; text-align: center;">${board.nickname}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			</div>
		</div>
		</div>
			<div class="container px-5" style="width: 800px;">
			
				<h2 style="text-align: center;">
					오늘의 실시간 검색어는?
					</h2>
					<hr class="layouts">
					
		<script type="text/javascript" src="https://ssl.gstatic.com/trends_nrtr/3523_RC02/embed_loader.js"></script> <script type="text/javascript"> trends.embed.renderWidget("dailytrends", "", {"geo":"KR","guestPath":"https://trends.google.co.kr:443/trends/embed/"}); </script>
		</div>
</section>

<!-- Testimonial section-->
<section class="py-5" style="background-color: #edae49; text-align:center;">
<h2 style="margin-bottom:30px; color:white;" text-align:center;>명예의 유저</h2>
	<div class="container px-5" style="width: 500px;">
	    
	    <table class="styled-table" style="width:100%;height:250px;">
    <thead style=" text-align:center;">
        <tr>
            <th style="text-align:center;">닉네임</th>
            <th style="text-align:center;">추천 수</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="board" items="${getMemberLikes}">
                <tr>
                    <td style="width: 130px; text-align: center;"><strong>${board.nickname}</strong></td>
                    <td style="width: 130px; text-align: center;"><strong>${board.totalLikes}</strong></td>
                </tr>
            </c:forEach>
	            </tbody>
	</table>
    
</section>

<!-- -->

<section class="py-5">
	
		<div class="container px-5" style="width: 900px; ">
		<div class="row gx-10" style="float: none; margin: 0 auto;">

			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					자유토론장
					</h1>
					<hr class="layouts">
					<br>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px; height: 250px; float: none; margin: 0 auto;">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th style="text-align: center">제목</th>
									<th style="text-align: center">작성자</th>
								</tr>
							</thead>
							<tbody>
										<c:forEach var="board" items="${mainBoard}">
											<tr>
												<td><a href="/board/get?bno=${board.bno}">${board.title}</a></td>
												<td style="width: 130px; text-align: center;"><fmt:formatDate
														pattern="yyyy-MM-dd" value="${board.registerDate}" /></td>
											</tr>
										</c:forEach>
									</tbody>
						</table>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					공지사항
					</h1>
					<hr class="layouts">
					<a href="issue/list" style="color: gray;"><h4
							style="margin: 0; text-align: right;">+</h4></a>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
						style="width: 300px; height: 250px; float: none; margin: 0 auto;">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th style="text-align: center">제목</th>
									<th style="text-align: center">등록일</th>
								</tr>
							</thead>
							<tbody>
										<c:forEach var="board" items="${mainNotice}">
											<tr>
												<td><a href="/notice/get?bno=${board.bno}">${board.title}</a></td>
												<td style="width: 130px; text-align: center;"><fmt:formatDate
														pattern="yyyy-MM-dd" value="${board.registerDate}" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="text-end mb-5 mb-xl-0">
									<a class="text-decoration-none" href="/notice/list"> 공지사항
										보기 <i class="bi bi-arrow-right"></i>
									</a>
								</div>
			</div>
		</div>
		</div>	
		</div>
</section>


<%@ include file="layouts/footermain.jsp"%>
