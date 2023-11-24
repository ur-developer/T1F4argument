<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="/resources/js/comment.js"></script>
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/reply.js"></script>
<script src="/resources/js/commentLike.js"></script>

<script>
//댓글, 답글 기본 URL 상수 - 전역 상수
const COMMENT_URL = '/api/board/${param.bno}/comment/';
const REPLY_URL = '/api/board/${param.bno}/reply/';
// const COMMENT_LIKE_URL = '/api/board/${param.bno}/commentlike';
$(document).ready(async function() {

	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;		
		document.forms.removeForm.submit();
	});	
	
	let bno = ${param.bno}; // 글번호
	let nickname = '${username}'; // 작성자(로그인 유저)
	
	
	loadComments(bno, nickname); // 댓글 목록 불러오기
	
	//댓글 추가 버튼 처리
	$('.comment-add-btn').click(function(e) {
		createComment(bno, nickname);
	});
	
	$('.comment-list').on('click', '.comment-update-show-btn', showUpdateComment);
		//console.log('수정 버튼 클릭!', $(this)); //this는 comment-update-show-btn 클래스 중 하나가 선택된다.
	
		
	// 댓글 수정, 삭제 버튼 처리 - 이벤트 버블링(이벤트 처리 위임)
	
		// 댓글 수정 확인 버튼 클릭
		$('.comment-list').on('click', '.comment-update-btn', function (e){
		const el = $(this).closest('.comment');
		updateComment(el, nickname);
		});
		
		// 댓글 수정 취소 버튼 클릭
		$('.comment-list').on('click', '.comment-update-cancel-btn', 
		cancelCommentUpdate);
	
		// 댓글 삭제 버튼
		$('.comment-list').on('click', '.comment-delete-btn', 
				deleteComment);
		
	/////// 답글 버튼 이벤트 핸들링
		// 답글 추가버튼 인터페이스 보이기
		$('.comment-list').on('click', '.reply-add-show-btn', function(e) {
		showReplyAdd($(this), nickname);
		});
		
		// 답글 추가해서 작성 후 "확인" 버튼
		$('.comment-list').on('click', '.reply-add-btn', function(e){
		addReply($(this), nickname);
		});
		
		// 답글 수정 화면 보이기
		$('.comment-list').on('click', '.reply-update-show-btn', function(e) {
		showUpdateReply($(this));
		});
		
		// 답글 수정 등록
		$('.comment-list').on('click', '.reply-update', function(e) {
		updateReply($(this));
		});
		
		// 답글 수정 취소
		$('.comment-list').on('click', '.reply-update-cancel', cancelReplyUpdate);

		
		// 답글 "취소"
		$('.comment-list').on('click', '.reply-add-cancel-btn', cancelReply);
		
		// 답글 삭제
		$('.comment-list').on('click', '.reply-delete-btn', deleteReply);
		
		
		$('.comment-list').on('click', '.fa-thumbs-up.fa-regular', function(e) {
			addCommentLike(nickname, $(this));
			});
				
				
		
		/*  $('.comment-list').on('click', '.fa-thumbs-up.fa-regular', () => {
	         
	         const cno = $(this).data('no')
	         const cno2 = $(this).data('comment')
	         
	         console.log('username on click', nickname)
	         console.log('cno on click', cno)
	         console.log('cno on click', cno2)
	         addCommentLike(username)
	      }); */
		
		$('.comment-list').on('click', '.fa-thumbs-up.fa-solid', function(e) {
			deleteCommentLike(nickname, $(this));
		});
		
	

});

</script>

<h1 class="page-header">
	<i class="far fa-file-alt"></i> ${board.title}
</h1>

<div class="d-flex justify-content-between">
	<div>
		<i class="fas fa-user"></i> ${board.nickname}
	</div>
	<div>
		<i class="fas fa-clock"></i>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}" />
	</div>
</div>

<hr>

<div>${board.content}</div>

<!-- 새 댓글 작성 (작성자 아니어야 가능)-->
<%-- <c:if test="${username != board.nickname }"> --%>
<div class="bg-light p-2 rounded my-5">
	<div>${username == null ? '댓글을 작성하려면 먼저 로그인하세요' : '댓글 작성' }</div>
	<div>
		<textarea class="form-control new-comment-content" rows="3"
			${username == null ? 'disabled' : '' }></textarea>
		<div class="text-right">
			<button onClick="window.location.reload()"
				class="btn btn-primary btn-sm my-2 comment-add-btn"
				${username == null ? 'disabled' : '' }>
				<i class="fa-regular fa-comment"></i> 확인
			</button>
		</div>
	</div>
</div>
<%-- </c:if> --%>


<div class="my-5">
	<i class="fa-regular fa-comments"></i> 댓글 목록
	<hr>
	<div class="comment-list"></div>

</div>



<div class="mt-4">
	<a href="${cri.getLink('list')}" class="btn btn-primary list"> <i
		class="fas fa-list"></i> 목록
	</a>

	<c:if test="${username == board.nickname}">
		<a href="${cri.getLinkWithBno('modify', board.bno) }"
			class="btn btn-primary modify"> <i class="far fa-edit"></i> 수정
		</a>
		<a href="#" class="btn btn-danger remove"> <i
			class="fas fa-trash-alt"></i> 삭제
		</a>
	</c:if>
</div>

<%-- 
<form id="listForm" action="/board/list" method="get" >
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
	<input type="hidden" name="type" value="${cri.type}"/>
	<input type="hidden" name="keyword" value="${cri.keyword}"/>
</form>

<form id="modifyForm" action="/board/modify" method="get" >
	<input type="hidden" id="bno" name="bno" value="${board.bno}"/>
	<input type="hidden" name="pageNum" value="${cri.pageNum}"/>
	<input type="hidden" name="amount" value="${cri.amount}"/>
	<input type="hidden" name="type" value="${cri.type}"/>
	<input type="hidden" name="keyword" value="${cri.keyword}"/>
</form>
 --%>

<form action="remove" method="post" name="removeForm">
	<!-- csrf 토큰 안 넣으면 404 에러 -->
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token }" /> <input type="hidden" name="bno"
		value="${board.bno}" /> <input type="hidden" name="pageNum"
		value="${cri.pageNum}" /> <input type="hidden" name="amount"
		value="${cri.amount}" /> <input type="hidden" name="type"
		value="${cri.type}" /> <input type="hidden" name="keyword"
		value="${cri.keyword}" />
</form>

<%@include file="../layouts/footer.jsp"%>