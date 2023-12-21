<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOLDB : 로그인페이지</title>

<link rel="stylesheet" type="text/css" href="/css/member/login.css">
<script src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/member/login.js"></script>

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

<h2>로그인 에러 입니다.</h2>
<%-- 에러 메시지 확인 및 알림 (로그인 실패시 메시지 출력) --%>
<c:if test="${!empty message}">
    <script>
        alert('${message}');
    </script>
</c:if>




<%-- include : footer --%>
<%@ include file="../include/footer.jsp" %>
</body>
</html>