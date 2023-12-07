<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/headersecurity.jsp" %>

<link href="${pageContext.request.contextPath}/resources/css/security.css" rel="stylesheet" />

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
			var mailWarnMessage = $('.mailInputBoxWarn'); // 이메일 형식 인증 메세지
			
			// 형식에 맞지 않을 때 ajax가 실행되지 못하게 false 리턴해서 메소드 나감
			if(!mailAddressCheck(userMail)) {
				
				alert("이메일 형식으로 입력하세요.");
				
				return false;
			}

			if(!userMail == ""){
				$.ajax({
					type: 'GET',
					url: 'checkMail?email=' + userMail,
					data: {userMail: userMail},
					success: function(data){
						
						if(data == true){
							alert('중복된 이메일이 있습니다.');
						}
						
						else {
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
		
		// 이메일 형식 검사
		// form에 저장 된 정규 표현식에 적합하면 true, 그렇지 않으면 false 반환 (test 메소드)
		function mailAddressCheck(userMail) {
			
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			
			return form.test(userMail);
		}
	});
</script>

<div style="width: 500px" class="mx-auto">
	
	<h4 class="mt-5">회원가입</h4>

	<hr>
	<br>

	<div>
	<!-- action은 현재 url로, method는 post로 전송 -->
	<form:form modelAttribute="member" action="/security/signup?_csrf=${_csrf.token}">

			<div class="form-group">
				<form:label path="username">아이디</form:label>
				<form:input path="username" class="input" placeholder="아이디를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="username" cssClass="error"/>
			</div>
			
			<br>
	
			<div class="form-group">
				<form:label path="password">비밀번호</form:label>
				<form:password path="password" class="input" placeholder="비밀번호를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="password" cssClass="error"/>
			</div>
	
			<br>
		
			<div class="form-group">
				<form:label path="checkPassword">비밀번호 확인</form:label>
				<form:password path="checkPassword" class="input" placeholder="다시 한 번 비밀번호를 입력하세요."
					cssClass="form-control"/>
				<form:errors path="checkPassword" cssClass="error"/>
			</div>
			
			<br>
			
			<div class="form-group">
				<form:label path="nickname">닉네임</form:label>
				<form:input path="nickname" class="input" placeholder="닉네임을 입력하세요."
					cssClass="form-control"/>
				<form:errors path="nickname" cssClass="error"/>
			</div>
			
			<br>
		
			<div class="form-group">
				<label for="email" class="mailAddress">이메일</label>
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
						<input class="mailCheckInput" name="checkEmail" disabled="disabled" placeholder="인증번호 입력">
					</div>
				
					<button type="button" class="mailCheckButton">인증요청</button>
					
					<br>
					<br>
					<form:errors path="checkEmail" cssClass="error"/>
					
					<br>
				
					<!-- 인증 번호 일치 여부 알림 -->
					<span id="mailCheckInputBoxWarn"></span>
				</div>
			</div>
			
			<br>
			
			<button type="submit" class="btn btn-primary btn-block signupBtn">
                회원가입
        	</button>

		</form:form>
	</div>
</div>

<%@ include file="../layouts/footer.jsp" %>