<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../layouts/header.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

<style>
    .likes-container {
        display: flex;
        align-items: center;
    }

    .likes-icon {
        margin-right: 50px; /* 아이콘과 텍스트 사이 간격 조절 */
    }
</style>

<hr> 

<h1 class="page-header" style="margin-left: 20px;">
    <i class="fa-solid fa-fire fa-lg"></i> 인기순
</h1>

<p></p>
<div class="row">
    <c:forEach var="board" items="${list}">
        <div class="col-12 mb-3">
            <div class="card" style="width:100%">
                <div class="row no-gutters">
                    <!-- 왼쪽에 사진 -->
                    <div class="col-md-3 d-flex align-items-center justify-content-center">
						<a href="${cri.getLink('get')}&bno=${board.bno}">
							<img class="card-img-top" src="/resources/images/issue.png" 
						alt="${board.title}" style="width: 100%;">
						</a>
					</div>
                    <!-- 중간에 제목과 내용 -->
                    <div class="col-md-6">
                        <div class="card-body">
                            <h4 class="card-title" style="font-size: 24px;">
                                <a href="${cri.getLink('get')}&bno=${board.bno}">
                                    ${board.title}
                                </a>
                            </h4>
                            <p class="card-text" style="font-size: 16px;">
                                ${board.content}
                            </p>
                        </div>
                    </div>
                    <!-- 오른쪽에 좋아요 표시와 닉네임 -->
					<div class="col-md-3 mb-3 d-flex justify-content-center align-items-center">
						<div class="likes-text">
       						 ${board.nickname}
						</div>
						<div style="margin: 0 20px;"></div>
    					<div class="likes-icon">
        					<i class="fas fa-thumbs-up fa-2x"></i>
    					</div>
						<div>
						${board.likes}
						</div>
					</div>
               	</div>
            </div>
        </div>
    </c:forEach>
</div>
<hr>

<div class="text-right">
    <a href="register" class="btn btn-primary"> <i class="far fa-edit"></i>
        글쓰기
    </a>
</div>

<%@include file="../common/pagination.jsp"%>

<%@include file="../layouts/footer.jsp"%>