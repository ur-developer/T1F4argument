<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../layouts/headerboard.jsp"%>

<%-- 개별 페이지 --%>
<h1 class="page-header">
	<i class="fas fa-list"></i> 자유토론장
</h1>
<hr>

<div id="floatMenu">광고 / api</div>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th style = "text-align: center">탭</th>
			<th style = "text-align: center">제목</th>
			<th style = "text-align: center">작성자</th>
			<th style = "text-align: center">등록일</th>
		</tr>
	</thead>

	<tbody>
		<c:forEach var="board" items="${list}">
			<tr>
				<td style="width: 100px">자유토론</td>
				<td><a class="move"
					href="${cri.getLinkWithBno('get', board.bno)}">${board.title}</a></td>
				<td style="width: 100px">${board.nickname}</td>
				<td style="width: 130px"><fmt:formatDate pattern="yyyy-MM-dd"
						value="${board.registerDate }" /></td>
			</tr>
		</c:forEach>
	</tbody>

</table>
<hr>

<div class="text-right" style="float:right">
	<a href="register" class="btn btn-primary"> <i class="far fa-edit">
	</i>글쓰기
	</a>
</div>




<%@ include file="../common/search_bar.jsp"%>
<hr>


<%@include file="../common/pagination.jsp"%>



<%@ include file="../layouts/footer.jsp"%>