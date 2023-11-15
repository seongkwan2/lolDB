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
		<input type="text" id="id" name="id" placeholder="소환사 아이디 입력">
        <input type="submit" value="검색">
    </form>
	<hr>
    <c:if test="${not empty UserInfo}">
        <h2>검색 결과</h2>
        
        <p>accountId: ${UserInfo.accountId}</p>
        <p>profileIconId: ${UserInfo.profileIconId}</p>
        <p>revisionDate: ${UserInfo.revisionDate}</p>
        <p>이름(name): ${UserInfo.name}</p>
        <p>ID(id): ${UserInfo.id}</p>
        <p>puuid: ${UserInfo.puuid}</p>
        <p>레벨(summonerLevel): ${UserInfo.summonerLevel}</p>
        <hr>
        <c:if test="${not empty MatchCodes}">
		<p>전적 코드:</p>
		    <c:forEach var="Match" items="${MatchCodes}">
		        ${Match} <br/>
    	</c:forEach>
    	<hr>
    	<p>전적</p>
    	${MatchList}
    	
</c:if>

        
        
    </c:if>
</body>
</html>