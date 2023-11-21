<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
	$('document').ready(function() {
		
		var code = ""; // 인증 번호 저장
		
		/* 인증 번호 버튼 클릭 */
		$('.mailCheckButton').click(function(e){
			
			<!-- 입력한 이메일 저장 변수 -->
			var userMail = $('.mailInput').val(); // 입력 받은 이메일
			var checkBox = $('.mailCheckInput'); // 인증 번호 입력 (칸 활성화 위함)
			var boxWrap = $('.mailCheckInputBox'); // 인증 번호 입력 박스 활성화

			if(!userMail == ""){
				$.ajax({
					type:'GET',
					url:'sendMail?email=' + userMail,
					data: {userMail: userMail},
					
					success:function(data){
					
						console.log(data);
						alert('인증번호가 발송되었습니다.');
						checkBox.attr('disabled', false); // 인증 번호 입력 칸 속성 변경
						boxWrap.attr('id', 'mailCheckInputBoxTrue'); // 인증 입력란 색상 변경을 위한 속성 변경
						code = data; // controller에서 받은 인증 번호 값 저장
					
					}
				});
			}
		});
		
		/* 인증 번호 비교 */
	$('.mailCheckInput').blur(function(){
			
		var inputCode = $('.mailCheckInput').val(); // 사용자가 입력 한 인증 번호
		var checkCode = $('#mailCheckInputBoxWarn'); // 비교 결과 표시
			
		if(inputCode == code) {
			checkCode.html('인증번호가 일치합니다.');
			checkCode.attr('class', 'correct');
			emailCheck = true;
		}
		else {
			checkCode.html('인증번호가 일치하지 않습니다.');
			checkCode.attr('class', 'incorrect');
			emailCheck = false;
		}
	});
		
});

</script>

<div style="width: 500px" class="mx-auto">
	
	<h1 class="mt-5"><i class="fa-solid fa-user-plus"></i> 회원가입</h1>

	<hr>
	<br>

	<div>
	<!-- action은 현재 url로, method는 post로 전송 -->
	<form:form modelAttribute="member" action="/security/signup?_csrf=${_csrf.token}">

			<div class="form-group">
				<form:label path="username"><i class="fa-solid fa-at"></i>  아이디</form:label>
				<form:input path="username" class="input" placeholder="아이디를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="username" cssClass="error"/>
			</div>
	
			<div class="form-group">
				<form:label path="password"><i class="fa-solid fa-lock"></i> 비밀번호</form:label>
				<form:password path="password" class="input" placeholder="비밀번호를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="password" cssClass="error"/>
			</div>
		
			<div class="form-group">
				<form:label path="checkPassword"><i class="fa-solid fa-lock"></i> 비밀번호 확인</form:label>
				<form:password path="checkPassword" class="input" placeholder="다시 한 번 비밀번호를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="checkPassword" cssClass="error"/>
			</div>
			
			<div class="form-group">
				<form:label path="nickname"><i class="fa-solid fa-file-signature"></i> 닉네임</form:label>
				<form:input path="nickname" class="input" placeholder="닉네임을 입력하세요."
					cssClass="form-control"/>
				<form:errors path="nickname" cssClass="error"/>
			</div>
		
			<div class="form-group">
				<label for="email" class="mailAddress"><i class="fa-solid fa-at"></i> 이메일</label>
				<span class="mailCheckWarn"></span>
				
				<div class="mailInputBox">
					<input type="text" name="email" class="mailInput" 
					autocomplete="off" placeholder="인증 코드를 받을 이메일을 입력하세요."/>
					<span class="emailCheck"></span>
					<span id="mailInputBoxWarn"></span>
				</div>
				
				<br>
			
				<div class="mailCheckWrap">
					<div class="mailCheckInputBox" id="mailCheckInputBoxFalse">
						<input class="mailCheckInput" disabled="disabled" placeholder="인증번호 입력">
					</div>
				
					<button type="button" class="mailCheckButton">인증요청</button>
					
					<br>
					<br>
					
					<form:errors path="email" cssClass="error"/>
					
					<br>
				
					<!-- 인증 번호 일치 여부 알림 -->
					<span id="mailCheckInputBoxWarn"></span>
				</div>
			</div>
			
			<button type="submit" class="btn btn-primary btn-block">
                <i class="fa-solid fa-right-to-bracket"></i> 회원가입
        	</button>

		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp" %>