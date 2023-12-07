<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header2.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/comment.js"></script>
<script src="/resources/js/comment2.js"></script>
<script src="/resources/js/reply.js"></script>
<script src="/resources/js/reply2.js"></script>
<script src="/resources/js/commentLike.js"></script>
<script src="/resources/js/comment2Like.js"></script>

<script>
//댓글, 답글 기본 URL 상수 - 전역 상수
const COMMENT_URL = '/api/hotissue/${board.bno}/comment/';
const REPLY_URL = '/api/hotissue/${board.bno}/reply/';
const COMMENT2_URL = '/api/hotissue/${board.bno}/comment2/';
const REPLY2_URL = '/api/hotissue/${board.bno}/reply2/';
$(document).ready(async function() {

	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;		
		document.forms.removeForm.submit();
	});	
	
	let bno = ${board.bno}; // 글번호
	let nickname = '${username}'; // 작성자(로그인 유저)
	
	loadComments(bno, nickname); // 댓글 목록 불러오기
	
	<c:if test="${not empty username}">
		
		$('.comment-list').on('click', '.fa-thumbs-up.fa-regular', function(e) {
			addCommentLike(nickname, $(this));
		});
		 
		
		$('.comment-list').on('click', '.fa-thumbs-up.fa-solid', function(e) {
			deleteCommentLike(nickname, $(this));
		});
	
	</c:if>
	
	
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
});

</script>

<style>
    .page-header {
        border-top: 1px solid lightgray;
        border-bottom: 1px solid lightgray; /* 여기서 색상을 조절할 수 있어요 */
        padding-bottom: 5px;
        margin-bottom: 10px;
    }
</style>

<h2> 자유토론장 </h2>

<div class="page-header d-flex justify-content-between">
    <div style="font-size: 2.2em;">${board.title}</div>
    <div class="date-container" style="display: flex; align-items: flex-end;">
        <i class="fas fa-clock" style="margin-bottom: 3px;"></i>
        <fmt:formatDate pattern="yyyy-MM-dd" value="${board.registerDate}"/>
    </div>
</div>


<div class="d-flex justify-content-between">
	<div><i class="fas fa-user"></i> ${board.nickname}</div>
</div>
	
<hr>

<div>${board.content}</div>

<hr>
<div class="container" style="background-color:aliceblue;border-radius: 30px;">
		<div style="text-align:left; width:80%; padding:10px;">
			<i class="fa-regular fa-comments"></i> 댓글	
			<div class="comment-list"></div>
		<div class="p-2 rounded">
	<c:choose>
		<c:when test="${username == null}">
			<div>로그인이 필요합니다.</div>
			<div>
				<textarea class="form-control new-comment-content" rows="3" disabled></textarea>
				<div class="text-right">
					<button class="btn btn-primary btn-sm my-2 comment-add-btn" disabled>
						<i class="fa-regular fa-comment"></i> 확인
					</button>
				</div>
			</div>
		</c:when>
		<c:when test="${board.myComment}">
			<div>의견을 중복해서 작성할 수 없습니다</div>
			<div>
				<textarea class="form-control new-comment-content" rows="3" disabled></textarea>
				<div class="text-right">
					<button class="btn btn-primary btn-sm my-2 comment-add-btn" disabled>
						<i class="fa-regular fa-comment"></i> 확인
					</button>
				</div>
			</div>
		</c:when>
		<c:when test="${board.myComment2}">
			<div>의견을 중복해서 작성할 수 없습니다</div>
			<div>
				<textarea class="form-control new-comment-content" rows="3" disabled></textarea>
				<div class="text-right">
					<button class="btn btn-primary btn-sm my-2 comment-add-btn" disabled>
						<i class="fa-regular fa-comment"></i> 확인
					</button>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div>댓글 달기</div>
			<div>
				<textarea class="form-control new-comment-content" rows="3"></textarea>
				<div class="text-right">
					<button  class="btn btn-primary btn-sm my-2 comment-add-btn">
						<i class="fa-regular fa-comment"></i> 확인
					</button>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
		</div>
	</div>
<hr>
<div class="mt-4">
	<a href="${cri.getLink('list')}" class="btn btn-primary list">
		<i class="fas fa-list"></i> 목록</a>
	
	<c:if test="${username == board.nickname || username == 'admin'}">
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
<!-- top버튼 클릭시 화면상단으로 이동 -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/topbutton.css">
<a id="backtotop">Top</a>
<!-- javascript -->
<script src="../resources/js/topbutton.js"></script>
<%@include file="../layouts/footer.jsp"%>