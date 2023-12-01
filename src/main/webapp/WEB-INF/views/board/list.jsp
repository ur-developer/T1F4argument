<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ include file="../layouts/headerboard.jsp"%>


<hr>


<%-- 개별 페이지 --%>
<h1 class="page-header">
	<i class="fas fa-list"></i> 자유토론장
</h1>

<div class="text-right">
	<a href="register" class="btn btn-primary"> <i class="far fa-edit">
	</i>글쓰기
	</a>
</div>

<p></p>


<%-- <div class="d-flex justify-content-between align-items-center my-4">
	<div class=" ">
		총 ${pageMaker.total} 건
		( ${pageMaker.cri.pageNum} .. ${pageMaker.totalPage})
	</div>
	<div>
		<form id="searchForm" method="get" class="d-flex">
			<input type="hidden" name="pageNum" value="1">
				<select name="type" class="form-select rounded-0 ml-1">
					<option value="" ${pageMaker.cri.type == null ? 'selected' : ''} >-- 검색대상선택 --</option>
					<option value="T" ${pageMaker.cri.type eq 'T' ? 'selected' : ''}>제목</option>
					<option value="C" ${pageMaker.cri.type eq 'C' ? 'selected' : ''}>내용</option>
					<option value="N" ${pageMaker.cri.type eq 'N' ? 'selected' : ''}>작성자</option>
					<option value="TC" ${pageMaker.cri.type eq 'TC' ? 'selected' : ''}>제목+내용</option>
					<option value="TN" ${pageMaker.cri.type eq 'TN' ? 'selected' : ''}>제목+작성자</option>
					<option value="TCN" ${pageMaker.cri.type eq 'TCN' ? 'selected' : ''}>제목+내용+작성자</option>
				</select>
				<div class="input-group">
					<input type="text" name="keyword" class="form-control rounded-0" />
					<button type="submit" class="btn btn-success rounded-0">
						<i class="fa-solid fa-magnifying-glass"></i> 검색</button>
				</div>
		</form>
	</div>
</div>  --%>


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

<%-- <ul class="pagination justify-content-center">
	<c:if test="${pageMaker.cri.pageNum > 1}">
		<li class="page-item">
			<a class="page-link" href="1">
				<i class="fa-solid fa-backward-step"></i>
			</a>
		</li>
	</c:if>
	<c:if test="${pageMaker.prev}">
		<li class="page-item">
			<a class="page-link" href="${pageMaker.startPage-1}">
				<i class="fa-solid fa-angle-left"></i>
			</a>
		</li>
	</c:if>
	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" 
		var="num">
		<li class="page-item ${ pageMaker.cri.pageNum == num ? 'active' : '' }">
			<a class="page-link" href="${num}">${num}</a>
		</li>
	</c:forEach>
	<c:if test="${pageMaker.next}">
		<li class="page-item">
			<a class="page-link" href="${pageMaker.endPage+1}">
				<i class="fa-solid fa-angle-right"></i>
			</a>
		</li>
	</c:if>
	<c:if test="${pageMaker.cri.pageNum < pageMaker.totalPage}">
		<li class="page-item">
			<a class="page-link" href="${pageMaker.totalPage}">
				<i class="fa-solid fa-forward-step"></i>
			</a>
		</li>
	</c:if>
</ul> --%>




<%@ include file="../common/search_bar.jsp"%>


<%@include file="../common/pagination.jsp"%>


<%-- <form id="actionForm" action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
	<input type="hidden" name="type" value="${pageMaker.cri.type}"/>
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/>
</form> --%>

<%@ include file="../layouts/footer.jsp"%>