<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<c:set var="userIconPath"
		value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/profileicon/" />
	<c:set var="champIconPath"
		value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
	<%-- ∥ 네비바부분 입니다. ∥ --%>
	<%@ include file="./include/header.jsp" %>

	<%-- ∥ 아이디 검색부분 입니다. ∥ --%>
	<div class="search-box">
		<form action="/searchUser" method="get">
			<label for="id">ID</label> <input type="text" id="id" name="id"
				placeholder="소환사 아이디 입력"> <input type="image"
				src="images/search.png" alt="검색" class="search-button">
		</form>
	</div>
	<h1 style="text-align: center">L O L D B 홈페이지 입니다.</h1>

</body>
</html>
