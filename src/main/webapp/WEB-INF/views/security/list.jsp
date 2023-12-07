<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../layouts/headersecurity.jsp" %>

<h1 class="page-header">
	<i class="fas fa-list"></i> 게시글 목록
</h1>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th style="width: 60px">No</th>
			<th>제목</th>
			<th style="width: 100px">작성자</th>
			<th style="width: 130px">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="member" items="${member}">
			<tr>
				<td>${member.username}</td>
				<td>${member.email}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
					value="${member.registerDate}" />
				</td>
			</tr>
		</c:forEach>
	</tbody>

</table>

<%@include file="../layouts/footer.jsp"%>
