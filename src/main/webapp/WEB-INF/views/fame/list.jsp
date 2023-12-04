<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/headerfame.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<div class="content-section-heading"
	style="text-align: center; margin-top: 0px;">
	<h3 class="text-secondary mb-0">명예의</h3>
	<h2 class="mb-5">핫 이슈</h2>
</div>
<div class="col-md-5" style="float: none; margin: auto; margin-top: 0px">
	<h2 style="text-align: center;">

		</h1>
		<div
			class="col g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
			<div class="col-lg-auto d-none d-lg-block">
				<img
					src="${pageContext.request.contextPath}/resources/images/1st.jpg"
					style="width: 100%">
			</div>
			<div class="col p-1 d-flex flex-column position-static">
				<c:forEach var="board" items="${getFirstFameList}">
					<h2 class="mb-0" style="float: none; margin: 0 auto;">
						${board.title}</h2>

					<div class="mb-1 text-body-secondary"
						style="float: none; margin: 0 auto;">
						<i> <fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.registerDate}" /></i>
					</div>

					<div style="text-align: center">
						<h4 class="card-text mb-auto" style="text-align: center;">${board.content}</h4>
					</div>
				</c:forEach>


			</div>

		</div>
</div>
<br>


<div class="container px-5">

	<div class="row gx-10">

		<div class="row mb-4">

			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col-lg-auto d-none d-lg-block">
							<img
								src="${pageContext.request.contextPath}/resources/images/2nd.jpg"
								style="width: 100%">
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<c:forEach var="board" items="${getSecondFameList}">
								<h2 class="mb-0" style="text-align: center;">
									${board.title}</h2>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;">
									<i><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.registerDate}" /></i>
								</div>
								<div style="text-align: center">
									<h4 class="card-text mb-auto" style="text-align: center;">${board.content}</h4>
								</div>
							</c:forEach>
						</div>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">

					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col-lg-auto d-none d-lg-block">
							<img
								src="${pageContext.request.contextPath}/resources/images/3rd.jpg"
								style="width: 100%">
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<c:forEach var="board" items="${getThirdFameList}">
								<h2 class="mb-0" style="text-align: center;">
									${board.title}</h2>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;">
									<i><fmt:formatDate pattern="yyyy-MM-dd"
											value="${board.registerDate}" /></i>
								</div>
								<h4 class="card-text mb-auto" style="text-align: center;">${board.content}</h4>
							</c:forEach>
						</div>

					</div>
			</div>
		</div>
	</div>
</div>
<br>

<br>

<div class="content-section-heading"
	style="text-align: center; margin-top: 0px;">
	<h3 class="text-secondary mb-0">명예의</h3>
	<h2 class="mb-5">사용자</h2>
</div>
<div class="row gx-4 gx-lg-5" style="text-align: center;">
	<div class="col-lg-4 col-md-6 mb-5 mb-lg-0">
		<span class="service-icon rounded-circle mx-auto mb-3"><i
			class="icon-pencil"></i></span>
		<c:forEach var="board" items="${getFirstMember}">
			<h2 class="mb-0" style="float: none; margin: 0 auto;">
				${board.nickname}</h2>
			<p class="card-text mb-auto" style="float: none; margin: 0 auto;">
				<i>총 좋아요 수<br>${board.totalLikes}</i></p>
		</c:forEach>
	</div>
	<div class="col-lg-4 col-md-6 mb-5 mb-lg-0" style="text-align: center;">
		<span class="service-icon rounded-circle mx-auto mb-3"><i
			class="icon-like"></i></span>
		<c:forEach var="board" items="${getSecondMember}">
			<h2 class="mb-0" style="float: none; margin: 0 auto;">
				${board.nickname}</h2>
			<p class="card-text mb-auto" style="float: none; margin: 0 auto;">
				<i>총 좋아요 수<br>${board.totalLikes}</i></p>
		</c:forEach>
		</div>
	<div class="col-lg-4 col-md-6 mb-5 mb-md-0" style="text-align: center;">
		<span class="service-icon rounded-circle mx-auto mb-3"><i
			class="icon-speech"></i></span>
		<c:forEach var="board" items="${getThirdMember}">
			<h2 class="mb-0" style="float: none; margin: 0 auto;">
				${board.nickname}</h2>
			<p class="card-text mb-auto" style="float: none; margin: 0 auto;">
				<i>총 좋아요 수<br>${board.totalLikes}</i></p>
		</c:forEach>
	</div>
</div>
</div>


<%@include file="../common/pagination.jsp"%>

<%@include file="../layouts/footer.jsp"%>
