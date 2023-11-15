<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Summoner Search</title>
</head>
<body>
    <h1>소환사 전적 검색</h1>
    <form action="/searchUser" method="get"> <!-- 받은 정보를 /searchUser로 보냄  -->
        <label for="id">소환사 아이디:</label>
        <input type="text" id="id" name="id">
        <input type="submit" value="검색">
    </form>
	<hr>
    <c:if test="${not empty UserInfo}">
        <h2>검색 결과</h2>
        
        <p>레벨: ${UserInfo.profileIconId}</p>
        <p>레벨: ${UserInfo.revisionDate}</p>
        <p>이름: ${UserInfo.name}</p>
        <p>ID: ${UserInfo.id}</p>
        <p>레벨: ${UserInfo.puuid}</p>
        <p>레벨: ${UserInfo.summonerLevel}</p>
    </c:if>
</body>
</html>