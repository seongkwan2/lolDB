<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- User 랭크 정보 -->
	<div class="rank_container">
		<c:forEach items="${SummonerRank}" var="rank">
			<div class="rank_div">
				<p>
					<c:choose>
						<c:when test="${rank.queueType eq 'RANKED_FLEX_SR'}">5:5 RANK</c:when>
						<c:otherwise>SOLO RANK</c:otherwise>
					</c:choose>
				</p>
				
				<!-- 랭크 정보 (랭크 이미지는 Images폴더에 저장된 경로를 통해 이미지를 가져옴) -->
				<div class="rankImages">
					<c:choose>
						<c:when test="${rank.tier eq 'IRON'}">
							<img src="/images/iron.png" alt="Iron">
						</c:when>
						<c:when test="${rank.tier eq 'BRONZE'}">
							<img src="/images/bronz.png" alt="Bronze">
						</c:when>
						<c:when test="${rank.tier eq 'SILVER'}">
							<img src="/images/silver.png" alt="Silver">
						</c:when>
						<c:when test="${rank.tier eq 'GOLD'}">
							<img src="/images/gold.png" alt="Gold">
						</c:when>
						<c:when test="${rank.tier eq 'EMERALD'}">
							<img src="/images/emerald.png" alt="Emerald">
						</c:when>
						<c:when test="${rank.tier eq 'PLATINUM'}">
							<img src="/images/platinum.png" alt="Platinum">
						</c:when>
						<c:when test="${rank.tier eq 'DIAMOND'}">
							<img src="/images/diamond.png" alt="Diamond">
						</c:when>
						<c:when test="${rank.tier eq 'MASTER'}">
							<img src="/images/master.png" alt="Master">
						</c:when>
						<c:when test="${rank.tier eq 'GRANDMASTER'}">
							<img src="/images/grandmaster.png" alt="Grandmaster">
						</c:when>
						<c:when test="${rank.tier eq 'CHALLENGER'}">
							<img src="/images/challenger.png" alt="Challenger">
						</c:when>
						<c:otherwise>
							<img src="/images/unlank.png" alt="Unranked">
						</c:otherwise>
					</c:choose>
				</div>
				<p style="font-weight: bold; font-size: 16px;">${rank.tier}
					${rank.rank}</p>
				<p>${rank.leaguePoints}LP</p>
				<p>${rank.wins + rank.losses}전${rank.wins}승${rank.losses}패</p>
			</div>
		</c:forEach>
	</div>
</body>
</html>