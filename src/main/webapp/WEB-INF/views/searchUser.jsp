<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>전적 검색</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>

    <script>
	    $(document).ready(function() {
	        $(".game-header button").click(function() {
	            var gameDetails = $(this).parent().next(".game-details");
	            var buttonText = $(this).text();
	            
	            if (buttonText === "펼치기") {
	                gameDetails.slideDown();
	                $(this).text("접기");
	            } else {
	                gameDetails.slideUp();
	                $(this).text("펼치기");
	            }
	        });
	    });
    </script>
    
</head>
<body>

<h1>소환사 전적 검색</h1>
<form action="/searchUser" method="get">
    <!-- 받은 정보를 /searchUser로 보냄  -->
    <label for="id">소환사 아이디:</label> <input type="text" id="id" name="id" placeholder="소환사 아이디 입력"> <input type="submit" value="검색">
</form>

<hr>

<c:if test="${empty UserInfo}">
    <p>검색하신 아이디는 전적이 존재하지 않습니다.</p>
</c:if>

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
    
    <h2>랭크 정보</h2>
    <div class="rank_session">
     
	    <c:forEach items="${SummonerRank}" var="rank">
		    <div class="rank_div">
		    <c:choose>
		        <c:when test="${rank.tier eq 'IRON'}">
              <img src="/images/iron.png" alt="Iron" width="200" height="200">
            </c:when>
		        <c:when test="${rank.tier eq 'BRONZE'}">
              <img src="/images/bronz.png" alt="Bronze" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'SILVER'}">
              <img src="/images/silver.png" alt="Silver" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'GOLD'}">
              <img src="/images/gold.png" alt="Gold" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'EMERALD'}">
              <img src="/images/emerald.png" alt="Emerald" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'PLATINUM'}">
              <img src="/images/platinum.png" alt="Platinum" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'DIAMOND'}">
              <img src="/images/diamond.png" alt="Diamond" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'MASTER'}">
              <img src="/images/master.png" alt="Master" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'GRANDMASTER'}">
              <img src="/images/grandmaster.png" alt="Grandmaster" width="200" height="200">
            </c:when>
            <c:when test="${rank.tier eq 'CHALLENGER'}">
              <img src="/images/challenger.png" alt="Challenger" width="200" height="200">
            </c:when>
            <c:otherwise>
              <img src="/images/unlank.png" alt="Unranked" width="200" height="200">
            </c:otherwise>
        </c:choose>		    
		      <p>큐 타입: 
		      <c:choose>
            <c:when test="${rank.queueType eq 'RANKED_FLEX_SR'}">자유 랭크</c:when>
            <c:otherwise>솔로 랭크</c:otherwise>
        </c:choose>
		      </p>
		      <p>티어: ${rank.tier}</p>
		      <p>계급: ${rank.rank}</p>
		      <p>리그 포인트: ${rank.leaguePoints}</p>
		    </div>
	    </c:forEach>
    </div>
    <hr>
    <h2>최근 전적</h2>
    <c:forEach items="${MatchList}" var="match">
        <div class="game-header">
            <span>게임코드: ${match.metadata.matchId}</span> |
            <span>게임 플레이 시간: ${fn:substringBefore(match.info.gameDuration div 60, '.')}분 ${match.info.gameDuration % 60}초</span> |
            <span class="${match.info.teams[0].win ? 'win' : 'loss'}">게임 결과: ${match.info.teams[0].win ? '승리' : '패배'}</span>
            <button>펼치기</button>
        </div>

        <!-- 숨겨져 있던 정보(펼치기를 눌러야 나오는 정보들) -->
        <div class="game-details" style="display: none;">
        
        <!-- 블루 팀 -->
            <h4>BLUD Team</h4>
            <ul class="team-list">
                <c:forEach items="${match.info.participants}" var="participant">
                    <c:if test="${participant.teamId == 100}">
                         <li>${participant.summonerName} | 
                         챔프: ${participant.championId} | ${participant.championName}  |  
                         이미지: <img src=https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/${participant.championName}.png alt='Champion Image'>
                         KDA: ${participant.kills} / ${participant.assists} / ${participant.deaths} | 
                         </li>
                    </c:if>
                </c:forEach>
            </ul>
            
            <hr>
         
        <!-- 레드 팀 -->
            <h4>RED Team</h4>
            <ul class="team-list">
                <c:forEach items="${match.info.participants}" var="participant">
                    <c:if test="${participant.teamId == 200}">
                         <li>${participant.summonerName} | 
                         챔프: ${participant.championId} | ${participant.championName}  |  
                         이미지: <img src=https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/${participant.championName}.png alt='Champion Image'>
                         KDA: ${participant.kills} / ${participant.assists} / ${participant.deaths} | 
                         </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</c:if>

</body>
</html>