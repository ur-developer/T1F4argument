<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/comment.js"></script>
<script src="/resources/js/reply.js"></script>

<script>
$(document).ready(function() {
	
	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;		
		document.forms.removeForm.submit();
	});	
	
});

</script>

<h2> 공지사항 </h2>

<div class="page-header d-flex justify-content-between">
    <div style="font-size: 2.2em;">${board.title}</div>
    <div class="date-container" style="display: flex; align-items: flex-end;">
        <i class="fas fa-clock" style="margin-bottom: 3px;"></i>
        <fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}"/>
    </div>
</div>


<div class="d-flex justify-content-between">
	<div><i class="fas fa-user"></i> ${board.nickname}</div>
	<tr>
		<td> 조회 수 ${board.hit} </td>
	</tr>
</div>
	
<div class="text-right">
	<c:forEach var="file" items="${board.attaches}">
		<div class="attach-file-item">
			<a href="/board/download/${file.no}" class="file-link">
				<i class="fa-solid fa-floppy-disk"></i> 
					${file.filename} (${file.formatSize})<br>
			</a>
		</div>
	</c:forEach>
</div>

<hr>

<div>${board.content}</div>

<hr>

<div class="mt-4">
	<a href="${cri.getLink('list')}" class="btn btn-primary list">
		<i class="fas fa-list"></i> 목록</a>
	
	<c:if test="${username == board.nickname }">
		<a href="${cri.getLinkWithBno('modify', board.bno) }" class="btn btn-primary modify">
			<i class="far fa-edit"></i> 수정</a>
		<a href="#" class="btn btn-danger remove">
			<i class="fas fa-trash-alt"></i> 삭제</a>
	</c:if>
</div>

<form action="remove" method="post" name="removeForm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="bno" value="${board.bno}"/>
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
	<input type="hidden" name="type" value="${cri.type}"/>
	<input type="hidden" name="keyword" value="${cri.keyword}"/>
</form>

<%@include file="../layouts/footer.jsp"%>