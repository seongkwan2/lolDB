<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 여기에 CSS 스타일 또는 외부 스타일시트 링크를 추가하세요 -->
</head>
<body>
    <!-- User 랭크 정보 -->
    <div class="rank_container">
        <c:if test="${empty SummonerRank}">
            <!-- SummonerRank 컬렉션이 비어있으면 모두 Unranked 이미지 표시 -->
            <div class="rank_div" style="text-align: center;">
                <p style="font-weight: bold; font-size: 16px;">SOLO RANK</p>
                <img src="/images/unrank.png" alt="Unranked">
                <p style="font-weight: bold; font-size: 16px;">Unranked</p>
            </div>
            <div class="rank_div" style="text-align: center;">
                <p style="font-weight: bold; font-size: 16px;">5:5 TEAM RANK</p>
                <img src="/images/unrank.png" alt="Unranked">
                <p style="font-weight: bold; font-size: 16px;">Unranked</p>
            </div>
        </c:if>
        <c:if test="${not empty SummonerRank}">
            <!-- 솔로 랭크 및 5:5 랭크 정보가 있는 경우 -->
            <c:set var="hasFlexRank" value="false"/>
            <c:forEach items="${SummonerRank}" var="rank">
                <c:if test="${rank.queueType eq 'RANKED_FLEX_SR'}">
                    <c:set var="hasFlexRank" value="true"/>
                </c:if>
                <div class="rank_div">
                    <p>
                        <c:choose>
                            <c:when test="${rank.queueType eq 'RANKED_FLEX_SR'}">
                            <p style="font-weight: bold; font-size: 16px;">5:5 RANK</p></c:when>
                            <c:otherwise><p style="font-weight: bold; font-size: 16px;">SOLO RANK</c:otherwise>
                        </c:choose>
                    </p>
                    <div class="rankImages">
                        <c:choose>
                            <c:when test="${not empty rank.tier and rank.tier ne 'UNRANKED'}">
                                <!-- 랭크에 따른 이미지 표시 -->
                                <img src="/images/${rank.tier.toLowerCase()}.png" alt="${rank.tier}">
                            </c:when>
                            <c:otherwise>
                                <!-- 랭크 정보가 없거나 UNRANKED일 경우 -->
                                <img src="/images/unrank.png" alt="Unranked">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p style="font-weight: bold; font-size: 16px;">
                        <c:out value="${not empty rank.tier ? rank.tier : 'Unranked'}"/>
                        <c:out value="${not empty rank.rank ? rank.rank : ''}"/>
                    </p>
                    <p>
                        <c:out value="${not empty rank.leaguePoints ? rank.leaguePoints : '0'}"/>LP
                    </p>
                    <p>
                        <c:out value="${rank.wins + rank.losses}"/>전
                        <c:out value="${not empty rank.wins ? rank.wins : '0'}"/>승
                        <c:out value="${not empty rank.losses ? rank.losses : '0'}"/>패
                    </p>
                </div>
            </c:forEach>
            <!-- 5:5 랭크 게임에 대한 정보가 없는 경우 Unranked 이미지 표시 -->
            <c:if test="${!hasFlexRank}">
                <div class="rank_div" style="text-align: center;">
                <br>
                    <p style="font-weight: bold; font-size: 16px;">5:5 TEAM RANK</p>
                    <img src="/images/unrank.png" alt="Unranked"> <!-- 이미지를 숨겨서 높이를 맞춤 -->
                    <p style="font-weight: bold; font-size: 16px;">Unranked</p>
                </div>
            </c:if>
        </c:if>
    </div>
</body>
</html>
