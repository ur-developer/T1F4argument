<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/headernotice.jsp"%>




<h1 class="page-header">
	<i class="fas fa-list"></i> 공지사항
</h1>
<hr>

<p></p>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th style = "text-align: center">탭</th>
			<th style = "text-align: center">제목</th>
			<th style = "text-align: center">작성자</th>
			<th style = "text-align: center">등록일</th>
			<th style = "text-align: center">조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${list}">
			<tr>
				<td style="width: 60px; text-align: center;">공지</td>
       	 		<td><a href="get?bno=${board.bno}">${board.title}</a></td>
      			<td style="width: 100px; text-align: center;">${board.nickname}</td>
        		<td style="width: 130px; text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}" /></td>
        		<td style="width: 80px; text-align: center;">${board.hit}</td>
      		</tr>
		</c:forEach>
	</tbody>
</table>

<hr>

<c:if test="${username == 'admin'}">
<div class="text-right" style="float:right">
	<a href="register" class="btn btn-primary"> <i class="far fa-edit"></i>
		글쓰기
	</a>
</div>
</c:if>



<%@ include file="../common/search_bar.jsp" %>

<hr>

<%@include file="../common/pagination.jsp"%>
<!-- top버튼 클릭시 화면상단으로 이동 -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/topbutton.css">
<a id="backtotop">Top</a>
<!-- javascript -->
<script src="../resources/js/topbutton.js"></script>
<%@include file="../layouts/footer.jsp"%>
