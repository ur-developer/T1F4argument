<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/header.jsp"%>
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

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', '댓글창');
        data.addColumn('number', '댓글수');
        data.addRows([
        ['후보1', ${board.comment1Count}],
          ['후보2', ${board.comment2Count}],
        ]);

        // Set chart options
        var options = {'title':'갑론을박',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
</script>

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


//두번째 댓글
$(document).ready(async function() { 
	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return; 
		document.forms.removeForm.submit(); });
	
	let bno = ${board.bno}; // 글번호 
	let nickname = '${username}'; // 작성자(로그인유저) 
	loadComments2 (bno, nickname); // 댓글 목록 불러오기 
	
	
	<c:if test="${not empty username}">
		
		$('.comment2-list').on('click', '.fa-thumbs-up.fa-regular', function(e) {
			addComment2Like(nickname, $(this)); }); 
		
		$('.comment2-list').on('click',	'.fa-thumbs-up.fa-solid', function(e) { 
			deleteComment2Like(nickname, $(this));
		});
		
	
	</c:if>
	
	
	//댓글 추가 버튼 처리
	$('.comment2-add-btn').click(function(e) { 
		createComment2(bno, nickname); });
	
	$('.comment2-list').on('click', '.comment2-update-show-btn', showUpdateComment2); 
	//console.log('수정 버튼 클릭!', $(this)); //this는	comment2-update-show-btn 클래스 중 하나가 선택된다. 
	
	// 댓글 수정, 삭제 버튼 처리 - 이벤트 버블링(이벤트 처리 위임) 
	
	// 댓글 수정 확인 버튼 클릭
	$('.comment2-list').on('click', '.comment2-update-btn', function (e){ const el =
	$(this).closest('.comment2'); updateComment2(el, nickname); }); 
	
	// 댓글 수정 취소 버튼 클릭 
	$('.comment2-list').on('click', '.comment2-update-cancel-btn',	cancelComment2Update); 
	// 댓글 삭제 버튼 
	$('.comment2-list').on('click','.comment2-delete-btn', deleteComment2); 
	
	/////// 답글 버튼 이벤트 핸들링 
	
	// 답글 추가버튼 인터페이스 보이기 
	$('.comment2-list').on('click',	'.reply2-add-show-btn', function(e) { 
		showReply2Add($(this), nickname); }); 

	//	답글 추가해서 작성 후 "확인" 버튼 
	$('.comment2-list').on('click', '.reply2-add-btn', function(e){ 
		addReply2($(this), nickname); }); 
	
	// 답글 수정 화면 보이기
	$('.comment2-list').on('click', '.reply2-update-show-btn', function(e) { 
		showUpdateReply2($(this)); });
	
	// 답글 수정 등록
	$('.comment2-list').on('click', '.reply2-update', function(e) {
		updateReply2($(this)); }); 
		
	// 답글 수정 취소 
	$('.comment2-list').on('click',	'.reply2-update-cancel', cancelReply2Update); 
	
	// 답글 "취소"
	$('.comment2-list').on('click', '.reply2-add-cancel-btn', cancelReply2); 
		
	// 답글 삭제 
	$('.comment2-list').on('click', '.reply2-delete-btn', deleteReply2);
		
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

<c:if test="${not empty username}">
<style>	
	.fa-like {
	cursor: pointer;
}
</style>

<script>
$(document).ready(function() {
	
	$('.remove').click(function(){
		if(!confirm('정말 삭제할까요?')) return;		
		document.forms.removeForm.submit();
	});	
	
    let username = '${username}';
    const BASE_URL = '/api/issue/like';

    // 좋아요 추가
    $('span.like').on('click', '.fa-thumbs-up.fa-regular', async function(e){
        let bno = parseInt($(this).data("bno"));
        let like = { bno, username };
        
        await rest_create(BASE_URL + "/add", like);
        
        let likes = $(this).parent().find(".like-count");
        console.log(likes);
        let count = parseInt(likes.text());
        likes.text(count+1);
        
        $(this)
            .removeClass('fa-regular')
            .addClass('fa-solid');
    });

    // 좋아요 제거
    $('span.like').on('click', '.fa-thumbs-up.fa-solid', async function(e){
        let bno = parseInt($(this).data("bno"));
        
        await rest_delete(
       		 `\${BASE_URL}/delete?bno=\${bno}&username=\${username}`);


        let likes = $(this).parent().find(".like-count");
        console.log(likes);
        let count = parseInt(likes.text());
        likes.text(count-1);

        $(this)
            .removeClass('fa-solid')
            .addClass('fa-regular');
    });
});

</script>
</c:if>

<h2> 이슈고르기 </h2>

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
		<td> 추천 수 ${board.likes} </td>
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
	
<span class="like">
	<i class="${ board.myLike ? 'fa-solid' : 'fa-regular' } fa-regular fa-thumbs-up text-primary"
		data-bno="${board.bno}"></i>
	<span class="like-count">${board.likes}</span>
</span>


	<div class="container" style="width: 400px; height: 550px;">
	<div id="chart_div"></div>
	</div>


<div class="d-flex justify-contents-between"
	style="width: 1200px height: auto; text-align: center; margin:50px;">
	<div class="container">
		<div class="my-5">
			<i class="fa-regular fa-comments"></i> 후보1
			<hr>
			<div class="comment-list"></div>
		<div class="bg-light p-2 rounded my-5">
	<c:choose>
		<c:when test="${username == null}">
			<div>댓글을 작성하려면 먼저 로그인하세요</div>
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
			<div>댓글을 중복해서 작성할 수 없습니다</div>
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
			<div>댓글을 중복해서 작성할 수 없습니다</div>
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
			<div>댓글 작성</div>
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
<%-- </c:if> --%>

		</div>

	</div>
	<div class="vr"></div>
	<div class="container">
		<div class="my-5">
			<i class="fa-regular fa-comments"></i> 후보2
			<hr>
			<div class="comment2-list"></div>
		</div>
		<div class="bg-light p-2 rounded my-5">
			<c:choose>
				<c:when test="${username == null}">
					<div>댓글을 작성하려면 먼저 로그인하세요</div>
					<div>
						<textarea class="form-control new-comment2-content" rows="3"
							disabled></textarea>
						<div class="text-right">
							<button onClick="window.location.reload()"
								class="btn btn-primary btn-sm my-2 comment2-add-btn" disabled>
								<i class="fa-regular fa-comment"></i> 확인
							</button>
						</div>
					</div>
				</c:when>
				<c:when test="${board.myComment}">
					<div>댓글을 중복해서 작성할 수 없습니다</div>
					<div>
						<textarea class="form-control new-comment2-content" rows="3"
							disabled></textarea>
						<div class="text-right">
							<button 
								class="btn btn-primary btn-sm my-2 comment2-add-btn" disabled>
								<i class="fa-regular fa-comment"></i> 확인
							</button>
						</div>
					</div>
				</c:when>
				<c:when test="${board.myComment2}">
					<div>댓글을 중복해서 작성할 수 없습니다</div>
					<div>
						<textarea class="form-control new-comment2-content" rows="3"
							disabled></textarea>
						<div class="text-right">
							<button onClick="window.location.reload()"
								class="btn btn-primary btn-sm my-2 comment2-add-btn" disabled>
								<i class="fa-regular fa-comment"></i> 확인
							</button>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div>댓글 작성</div>
					<div>
						<textarea class="form-control new-comment2-content" rows="3"></textarea>
						<div class="text-right">
							<button
								class="btn btn-primary btn-sm my-2 comment2-add-btn">
								<i class="fa-regular fa-comment"></i> 확인
							</button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
	
		</div>
<%-- </c:if> --%>


	</div>
</div>





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