<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoL Search</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<c:set var="userIconPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/profileicon/" />
<c:set var="champIconPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
<%@ include file="navbar.jsp"%>

<div class="search-box">
    <form action="/searchUser" method="get">
        <label for="id">ID</label> 
        <input type="text" id="id" name="id" placeholder="소환사 아이디 입력"> 
        <input type="image" src="images/search.png" alt="검색" class="search-button">
    </form>
</div>

<c:choose>
    <c:when test="${not searchCheck}">
        <p style="font-size:28px; text-align: center">아이디를 검색해주세요!</p>
    </c:when>
    <c:when test="${empty UserInfo}">
        <p style="font-size:28px; text-align: center">해당 아이디는 존재하지 않습니다.</p>
    </c:when>
    <c:otherwise>
        <c:if test="${not empty UserInfo}">
            <div class="container">
                <div class="user_container">
                    <div>
                        <c:set var="iconPath" value="${userIconPath}${UserInfo.profileIconId}.png" />
                        <img src="${iconPath}">
                        <p>${UserInfo.summonerLevel}</p>
                        <div>${UserInfo.name}</div>
                    </div>
                    
                    <c:forEach items="${SummonerRank}" var="rankData" varStatus="loop">
                        <!-- 랭크 정보 및 차트 -->
                        <%-- 랭크 정보와 차트 관련 스크립트 --%>
                    </c:forEach>
                </div>
                <%-- User 랭크 정보 --%>
                <%@ include file="rank_info.jsp"%>
                <%-- User 전적 드롭다운 데이터 --%>
                <%@ include file="match_info.jsp"%>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>
</body>
</html>
