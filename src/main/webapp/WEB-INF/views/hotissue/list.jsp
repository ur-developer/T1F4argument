<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../layouts/headerissue.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<script src="/resources/js/rest.js"></script>
<style>
.likes-container {
	display: flex;
	align-items: center;
}

.likes-icon {
	margin-right: 50px; /* 아이콘과 텍스트 사이 간격 조절 */
}
</style>
<script>
$(document).ready(function() {
	
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

<h1 class="page-header">
 <i class="fa-solid fa-fire fa-lg"></i> HOT 이슈
</h1>

<hr>

<div class="text-left">
	<a href="/issue/list" class="btn btn-primary"> 최신순 </a>
</div>
<hr style="width:40px">

<c:if test="${not empty username}">
</c:if>

<div class="row" style="width: 90%; margin: 0 auto;">
	<c:forEach var="board" items="${list}">
		<div class="col-12 mb-3">
			<div class="card" style="width: 100%">
				<div class="row no-gutters">
					<!-- 왼쪽에 사진 -->
					<div
						class="col-md-3 d-flex align-items-center justify-content-center">
						<a href="${cri.getLink('get')}&bno=${board.bno}"> <img
							class="card-img-top" src="/resources/images/issue.png"
							alt="${board.title}" style="width: 100%;">
						</a>
					</div>

					<!-- 중간에 제목과 내용 -->
					<div class="col-md-6">
						<div class="card-body" style="text-align: center;">
							<h4 class="card-title" style="font-size: 24px;">
								<a href="${cri.getLink('get')}&bno=${board.bno}">
									${board.title} </a>
							</h4>
							<p class="card-text" style="font-size: 16px;">
								<i>${board.content}</i></p>
							<div style="display: grid; grid-template-columns: 1fr 1fr;">
								<div style="margin: 0 auto;min-width:50px;width:auto;height:25px; background-color:#d1495b">
									<p style="color:white">&nbsp;${board.leftword}&nbsp;</p>
								</div>
								<div style="margin: 0 auto ;min-width:50px; width:auto;height:25px; background-color:#00798c">
									<p style="color:white" >&nbsp;${board.rightword}&nbsp;</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 오른쪽에 좋아요 표시와 닉네임 -->
					<div
						class="col-md-3 d-flex justify-content-center align-items-center"
						style="border-left:dotted">
						<div class="likes-text" style="text-align: center;">
						

						</div>
						<div style="margin: 0 20px;">
							<span class="like" style="cursor:pointer"> <i
								class="${ board.myLike ? 'fa-solid' : 'fa-large' } fa-regular fa-thumbs-up fa-2xl"
								style="color:#518df5;" "data-bno="${board.bno}"></i> <span class="like-count">${board.likes}</span>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<hr>
<!-- top버튼 클릭시 화면상단으로 이동 -->
<link rel="stylesheet" type="text/css"
	href="resources/css/topbutton.css">
<a id="backtotop">Top</a>
<!-- javascript -->
<script src="resources/js/topbutton.js"></script>

<%@include file="../layouts/footer.jsp"%>
