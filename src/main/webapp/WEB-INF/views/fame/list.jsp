<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/headerfame.jsp"%>

<div id="floatMenu">광고 / api</div>

<h1 class="page-header">
	<i class="fas fa-list"></i> 명예의전당
</h1>
<hr>

<section class="pt-5">
	<div class="col-md-5" style="float: none; margin: auto;">
		<h2 style="text-align: center;">
			.1.
			</h1>
			<div
				class="col g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col-lg-auto d-none d-lg-block">
					<img
						src="${pageContext.request.contextPath}/resources/images/1st.jpg" style="width:100%">
				</div>
				<div class="col p-1 d-flex flex-column position-static">
					<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
						<c:forEach var="board" items="${getFirstFameList}">	
							<h2 class="mb-0" style="float: none; margin: 0 auto;">
								${board.title}
								</h2>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}" /></div>
								<br> <br>
								<h3 class="card-text mb-auto"
									style="float: none; margin: 0 auto;">${board.content}</h3>
						</c:forEach>			
						
						<br> 
						<a
							href="${pageContext.request.contextPath}/hotissue/list"
							class="icon-link gap-1 icon-link-hover stretched-link"> 핫 이슈
							보러가기 </a>
				</div>

			</div>
	</div>
	<br> <br>
</section>
<hr class="hr-layout">
<Br>
<br>
<div class="container px-5">
	<div class="row gx-10">

		<div class="row mb-4">

			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					.2.
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col-lg-auto d-none d-lg-block">
							<img
						src="${pageContext.request.contextPath}/resources/images/2nd.jpg" style="width:100%">
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
							<c:forEach var="board" items="${getSecondFameList}">
							<h2 class="mb-0" style="float: none; margin: 0 auto;">
								${board.title}
								</h2>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}" /></div>
								<br> <br>
								<p class="card-text mb-auto"
									style="float: none; margin: 0 auto;">${board.content}</p>
							</c:forEach>		
								<br> <a
									href="${pageContext.request.contextPath}/hotissue/list"
									class="icon-link gap-1 icon-link-hover stretched-link"> 핫
									이슈 보러가기 </a>
						</div>

					</div>
			</div>
			<div class="col-md-5" style="float: none; margin: 0 auto;">
				<h2 style="text-align: center;">
					.3.
					</h1>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col-lg-auto d-none d-lg-block">
							<img
						src="${pageContext.request.contextPath}/resources/images/3rd.jpg" style="width:100%">
						</div>
						<div class="col p-1 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-primary-emphasis"></strong>
							<c:forEach var="board" items="${getThirdFameList}">
							<h2 class="mb-0" style="float: none; margin: 0 auto;">
								${board.title}
								</h2>

								<div class="mb-1 text-body-secondary"
									style="float: none; margin: 0 auto;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}" /></div>
								<br> <br>
								<p class="card-text mb-auto"
									style="float: none; margin: 0 auto;">${board.content}</p>
								</c:forEach>
								<br> <a
									href="{pageContext.request.contextPath}/hotissue/list"
									class="icon-link gap-1 icon-link-hover stretched-link"> 핫
									이슈 보러가기 </a>
						</div>

					</div>
			</div>
		</div>
	</div>
</div>
<br>

<hr class="hr-layout">


<%@include file="../common/pagination.jsp"%>

<%@include file="../layouts/footer.jsp"%>
