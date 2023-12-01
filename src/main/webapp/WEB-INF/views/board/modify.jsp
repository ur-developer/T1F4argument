<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../layouts/headerboard.jsp"%>

<link rel="stylesheet" href="/resources/css/summernote/summernote-lite.min.css">
<script src="/resources/js/summernote/summernote-lite.min.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<script>
	$(document).ready(function() {
		$('#content').summernote({
			height : 300, // 에디터높이
			focus : true, // 에디터로딩후포커스를맞출지여부
			lang : "ko-KR", // 한글설정
		});
		
		$('.get').click(function(){
			document.forms.getForm.submit();
			});

	});

	$('#content').summernote('fontName', 'Arial');
	
	
	
</script>
<%-- 개별 페이지 --%>
<h1 class="page-header">
	<i class="fas fa-edit"></i> 수정하기
</h1>
<div class="panel panel-default">
	<div class="panel-body">
		<form role="form" method="post" action="?_csrf=${_csrf.token}">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
			<input type="hidden" name="amount" value="${cri.amount}"/>
			<input type="hidden" name="bno" value=${board.bno }>
			<div class="form-group">
				<label>제목</label>
				<input name="title" class="form-control" value="${board.title }">
			</div>
			<div class="form-group">
				<label>작성자</label>
				<input name="nickname" class="form-control" value="${board.nickname}">
			</div>
			<div class="form-group">
				<label>내용</label>
			<textarea id="content" name="content">${board.content}</textarea>
			</div>
			
			<button type="submit" class="btn btn-primary">
				<i class="fas fa-check"></i> 확인
			</button>
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i> 취소
			</button>
			<a href="#" class="btn btn-primary get">
				<i class="fas fa-file-alt"></i> 돌아가기
			</a>	
			
		</form>
	</div>
</div>

<form id="getForm" action="/board/get" method="get">
	<input type="hidden" id="bno" name="bno" value="${board.bno}"/>
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
</form>

<%@ include file="../layouts/footer.jsp"%>