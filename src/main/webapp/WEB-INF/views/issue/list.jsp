<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header.jsp"%>


<hr>

<h1 class="page-header">
	<i class="fas fa-list"></i> 이슈고르기
</h1>

<div class="text-right">
	<a href="register" class="btn btn-primary"> <i class="far fa-edit"></i>
		글쓰기
	</a>
</div>

<p></p>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th style = "text-align: center">No</th>
			<th style = "text-align: center">제목</th>
			<th style = "text-align: center">작성자</th>
			<th style = "text-align: center">등록일</th>
			<th style = "text-align: center">조회</th>
			<th style = "text-align: center">추천</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${list}">
			<tr>
				<td style="width: 60px; text-align: center;">${board.bno}</td>
				<td><a href="get?bno=${board.bno}">${board.title}</a></td>
				<td style="width: 100px; text-align: center;">${board.nickname}</td>
				<td style="width: 130px; text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd"
						value="${board.registerDate}" /></td>
				<td style="width: 80px; text-align: center;">${board.hit}</td>
				<td style="width: 80px; text-align: center;">${board.hit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<hr>

<%@ include file="../common/search_bar.jsp" %>

<%@include file="../common/pagination.jsp"%>

<%@include file="../layouts/footer.jsp"%>
