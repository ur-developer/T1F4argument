<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<%@ include file="../layouts/header.jsp"%>
<sec:authentication property="principal.member" var="member" />

<link rel="stylesheet"
	href="/resources/css/summernote/summernote-lite.min.css">
<script src="/resources/js/summernote/summernote-lite.min.js"></script>
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<script>
	$(document).ready(function() {
		$('#content').summernote({
			height : 300, // 에디터높이
			focus : true, // 에디터로딩후포커스를맞출지여부
			lang : "ko-KR", // 한글설정
		});
	});

	$('#summernote').summernote('fontName', 'Arial');
</script>
<style>
input[readonly] {
	background-color: #f2f2f2;
	color: #b3b3b3;
	cursor: not-allowed;
}

input[readonly]:hover {
	box-shadow: none;
}
</style>
<%-- 개별 페이지 --%>
<h1 class="page-header">
	<i class="fas fa-edit"></i> 등록하기
</h1>

<div class="panel panel-default">

	<div class="panel-body">
		<form:form modelAttribute="board" role="form">
			<div class="form-group">
				<form:label path="title">제목</form:label>
				<form:input path="title" cssClass="form-control" />
				<form:errors path="title" cssClass="error" />
			</div>
			<div class="form-group">
				<form:label path="nickname">작성자</form:label>
				<form:input path="nickname" cssClass="form-control" value="${member.username }" readonly="true" />
				<form:errors path="title" cssClass="error" />

			</div>

			<div class="form-group">
				<form:label path="content">내용</form:label>
				<form:textarea path="content" cssClass="form-control"></form:textarea>
				<form:errors path="content" cssClass="error" />
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="fas fa-check"></i> 확인
			</button>
			<button type="reset" class="btn btn-primary">
				<i class="fas fa-undo"></i> 취소
			</button>
			<a href="list" class="btn btn-primary"> <i class="fas fa-list"></i>
				목록
			</a>
		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp"%>