<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOLDB : 로그인페이지</title>

<link rel="stylesheet" type="text/css" href="/css/member/login.css">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<script src="/js/jquery.js"></script>
<script src="/js/member/login.js"></script>

<!-- 네이버 인증 로그인 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="UTF-8"></script>

<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<%-- include : main --%>
<%@ include file="../include/header.jsp" %>
<div class="clear"></div>

<form action="/member/login" method="post" onsubmit="return logCk();">
	<div id="wrap">
		<div id="all_form">
			<div id="logo">
				<hr>
				로그인
				<hr>
			</div>
			<%--로그인 폼 --%>
			<div id="log_form">
			
				<%--ID칸 --%>
				<div id="id_form">
					<input type="text" id="m_id" name="m_id" placeholder="아이디">
				</div>
				
				<%--PW칸 --%>
				<div id="pwd_form">
					<input type="password" id="m_pwd" name="m_pwd" placeholder="비밀번호">
				</div>
				
				
				<div id="maintain">
					<input type="checkbox" id="remember-me" name="remember-me" checked><label for="remember-me" ><span>로그인 상태 유지</span></label>
				</div>
				<br>
				<%--로그인 버튼 --%>
				<div id="button_form">
					 <strong><input type="submit" value="로그인" id="btn1"></strong>
				</div>
			</div>
			
			<%--아이디, 비밀번호찾기 & 회원가입 --%>
			<div id="another_form">
				<a href="../member/serch_pwd">비밀번호 찾기</a>&nbsp;&nbsp;&#124;
				<a href="../member/serch_id">아이디 찾기</a>&nbsp;&nbsp;&#124;
				<a href="../member/sign">회원가입</a>&nbsp;&nbsp;
			</div>
			
			<%-- SNS 로그인 --%>
			<div id="social">
				<a href="#"><img src="../imgs/member/naver_icon.png"  id="naver"></a>
				<a href="#"><img src="../imgs/member/kakao_icon.png" id="kakao"></a>
				<a href="#"><img src="../imgs/member/google_icon.png"  id="google"></a>
			</div>
			
			<%-- 기타--%>
			<div id="ano">
				<span>LOLDB&nbsp;&nbsp;&#124;</span>
				<span> Copyright&nbsp;</span>
				<span>All Rights Reserved.</span>
			</div>
		</div><%--allform end --%>
	</div><%-- wrap end --%>
</form>

<%-- 각종 전달된 메시지 출력 --%>
<c:if test="${!empty message}">
    <script>
        alert('${message}');
    </script>
    <c:remove var="message" scope="session"/>
</c:if>




<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>