<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>lolDB : 회원가입 페이지</title>
<script src="/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="/css/member/sign.css">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<script type="text/javascript" src="/js/member/sign.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&display=swap" rel="stylesheet">

<!--알람(alert) 라이브러리-->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" type="text/css" href="/css/alert.css">

</head>
<body>

<div id="bigbox">
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>

<form name="memberInfo" method="post">
	<div id="logo">
		<hr>
		회원가입
		<hr>
	</div>
	<div id="wrap" >
		<!--아이디 & 비밀번호  -->
		<div id="form1">
			<div id="idform">
				<input type="text" id="m_id" name="m_id" placeholder="아이디"><br>
				<span id="idcheck"></span>
			</div>
			<div id="checkid">
				<strong><input type="button" id="ckidbtn" onclick="return checkid();" value="중복 확인"></strong>
			</div>
			<div id="pwdform">
				<input type="password" id="m_pwd" name="m_pwd" placeholder="비밀번호">
				<span class="pwdck"></span>
			</div>
			<div id="pwdCKform">
				<input type="password" id="m_pwd2" name="m_pwd2" placeholder="비밀번호 확인">
				<span class="m_pwd2"></span>
			</div>
		
		<!-- 개인정보 -->
			<div id="nameform">
				<input type="text" id="m_name" name="m_name" placeholder="이름">
				<span class="nameck"></span>
			</div>
			
			<div id="birthform">
				<input type="text" id="m_birth" name="m_birth" placeholder="생년월일 ex: 20020102">
				<span class="birthck"></span>
			</div>
			
			<div id="emailform">
				<input type="text" id="m_email" name="m_email" placeholder="이메일">
			</div>
			
			<div id="phoneform">
				<input type="text" id="m_phone" name="m_phone" placeholder="전화번호 ex: 01011112222">
				<span class="phoneck"></span>
			</div>

			<!-- 유효성 검증 창 -->
			<span id="text"></span>
			<!-- 버튼 -->
			<div id="form3">
				<strong>
				<button type="button" value="Y" name="Y" id="sign" onclick=" return joinCheck()" >가입하기</button>
				</strong>
			</div>
		</div><%--form1 end --%>
	</div> <%-- wrap end --%>
</form>
</div>

<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>

