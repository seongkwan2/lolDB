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


</head>

<body>

	<header>
		<div class="login">
		<c:choose>
			<c:when test="${!empty m_id}">	<%--로그인이 되었을때 --%>
				<b><span style="color: #1c2b37;">${m_id}님</span><a href="/member/mypage"> 마이페이지</a></b>
				<b><a href="/member/logout">로그아웃</a></b>
			</c:when>
			
			<c:otherwise> <%--로그아웃 상태일때 --%>
				<b><a href="/member/login" class="login_Link">로그인</a></b>
				<b><a href="/member/sign" class="login_Link">회원가입</a></b>
			</c:otherwise>
		</c:choose>
		</div>
	</header>

	<nav>
		<ul class="menuTop">
			<li><a href="/searchUser">홈</a></li>
			<li><a href="/championImages">챔피언</a></li>
			<li><a href="/board/boardMain">커뮤니티</a></li>
		</ul>
	</nav>

	<c:set var="userIconPath"
		value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/profileicon/" />
	<c:set var="champIconPath"
		value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />


	<%--검색 창 --%>
	<div class="search-box">
		<form action="/searchUser" method="get">
			<label for="id">아이디</label> 
			<input type="text" id="id" name="id" placeholder="소환사 아이디 입력"> 
			<input type="image" src="images/search.png" alt="검색" class="search-button">
		</form>
	</div>

	<%-- <%@ include file="mode_toggle.jsp" %>--%>
	<%-- 다크모드 라이트모드 주석처리 --%>


	<%-- 아이디를 입력하지 않았을때와 해당 아이디가 존재하지 않을때의 경우를 나눔 --%>
	<c:choose>
		<c:when test="${not searchCheck}">
			<p style="font-size:28px; text-align: center">아이디를 검색해주세요!</p>
		</c:when>
		<c:when test="${empty UserInfo}">
			<p style="font-size:28px; text-align: center">해당 아이디는 존재하지 않습니다.</p>
		</c:when>
		<c:otherwise>

			<!-- User 아이디 레벨 정보 -->
			<c:if test="${not empty UserInfo}">
				<div class="container">
					<div class="user_container">
						<div>
							<c:set var="iconPath"
								value="${userIconPath}${UserInfo.profileIconId}.png" />
							<img src="${iconPath}">
							<p>${UserInfo.summonerLevel}</p>
							<div>${UserInfo.name}</div>
						</div>
						
						<!-- 랭크 정보 -->
						<c:forEach items="${SummonerRank}" var="rankData" varStatus="loop">
							<div>
								<div>
									<c:choose>
										<c:when test="${rankData.queueType eq 'RANKED_FLEX_SR'}">5:5 RANK</c:when>
										<c:otherwise>SOLO RANK</c:otherwise>
									</c:choose>
								</div>
								<div style="width: 200px; height: 200px; margin: auto;">
									<canvas id="donutChart${loop.index}"></canvas>
								</div>
							</div>
							<script>
                    // rankData에서 데이터 추출
                    var wins = ${ rankData.wins };
                    var losses = ${ rankData.losses };
                    var totalGames = wins + losses;

                    // 승리와 패배의 백분율 계산
                    var winPercentage = (wins / totalGames * 100).toFixed(0);
                    var lossPercentage = (losses / totalGames * 100).toFixed(0);
                    // 차트 데이터
                    var data = {

                      datasets: [{
                        data: [wins, losses],
                        backgroundColor: ['blue', 'red']
                      }]
                    };

                    // 차트 옵션
                    var options = {
                      cutoutPercentage: 70,
                      legend: {
                        display: false
                      },
                      tooltips: {
                        enabled: false // 툴팁 비활성화
                      },
                      plugins: {
                        datalabels: {
                          formatter: (value, ctx) => {
                            return value + ' (' + (ctx.dataset.data[ctx.dataIndex] / totalGames * 100).toFixed(2) + '%)';
                          },
                          color: '#fff',
                          display: true,
                          align: 'center',
                          anchor: 'center'
                        }
                      }
                    };

                    // 차트 생성
                    var myDonutChart = new Chart(document.getElementById("donutChart${loop.index}").getContext('2d'), {
                      type: 'doughnut',
                      data: data,
                      options: options
                    });
                  </script>
						</c:forEach>


					</div>

				<!-- User 랭크 정보 -->
				<%@ include file="rank_info.jsp"%>

				<!-- User 전적 드롭다운 데이터 -->
				<%@ include file="match_info.jsp"%>
				
				</div>
			</c:if>
		</c:otherwise>
	</c:choose>
</body>

</html>