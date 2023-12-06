<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/headerissue.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script src="/resources/js/rest.js"></script>
<script src="/resources/js/comment.js"></script>
<script src="/resources/js/reply.js"></script>

<style>
	.word-section {
		display: flex; /* Flexbox 사용 */
		justify-content: center; /* 가운데 정렬 */
	}

	.word-container {
		text-align: center; /* 텍스트를 중앙 정렬 */
		margin-right: 200px; /* 이미지와 텍스트 사이의 간격 조절 */
	}

	.word-container img {
		display: block; /* 이미지를 블록 요소로 설정 */
		margin: 0 auto; /* 가운데 정렬 */
	}
  
   .word-image {
		width: 150px; /* 그림의 가로 크기를 조절 */
    	height: 150px; /* 그림의 세로 크기를 조절 */
   	 	margin-bottom: 5px; /* 그림과 단어 사이의 간격을 조절 */
    }
    
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
	

<hr>

<div><h4>${board.content}</h4></div>
	
<div class="word-section">
	<div class="word-container">
		<img src="/resources/images/dora.jpg" alt="Leftword Image" class="word-image">
			<p>${board.leftword}</p> 
	</div>
	<div class="word-container">
		<img src="/resources/images/dora.jpg" alt="Rightword Image" class="word-image">
			<p>${board.rightword}</p> 
	</div>
</div>
	
<span class="like" style="cursor:pointer"> <i
								class="${ board.myLike ? 'fa-solid' : 'fa-large' } fa-regular fa-thumbs-up fa-2xl"
								style="color:#518df5;" data-bno="${board.bno}"></i> <span class="like-count">${board.likes}</span>
							</span>

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
<link rel="stylesheet" type="text/css"
	href="../resources/css/topbutton.css">
<a id="backtotop">Top</a>
<!-- javascript -->
<script src="../resources/js/topbutton.js"></script>

<%@include file="../layouts/footer.jsp"%>