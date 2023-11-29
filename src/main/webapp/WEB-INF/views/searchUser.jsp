<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
				<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					<%@ page import="java.util.*" %>




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

							    <%-- ======================== --%>
								  <%-- ∥ 상단 네비게이션 바 부분 입니다. ∥ --%>
									<%-- ======================== --%>
										<nav class="navbar navbar-expand-lg bg-body-tertiary" style="background-color: #e3f2fd !important;">
											<div class="container-fluid">
												<a class="navbar-brand" href="#">LoL Search</a>
												<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
													data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
													aria-label="Toggle navigation">
													<span class="navbar-toggler-icon"></span>
												</button>
												<div class="collapse navbar-collapse" id="navbarNav">
													<ul class="navbar-nav">
														<li class="nav-item">
														  <form action="/searchUser" method="get">
															 <a href="/searchUser" class="nav-link active" aria-current="page">Home</a>
														  </form>
														</li>
														<li class="nav-item">
															<form action="/championImages" method="get">
																<a href="/championImages" class="nav-link">Champ</a>
															</form>
														</li>
														<li class="nav-item">
															<a class="nav-link" href="#">Board</a>
														</li>
														<li class="nav-item">
															<a class="nav-link disabled" aria-disabled="true">Disabled</a>
														</li>
													</ul>
												</div>
											</div>
										</nav>

                  <%-- ================== --%>
                  <%-- ∥ 아이디 검색부분 입니다. ∥ --%>
                  <%-- ================== --%>
										<div class="search-box">
											<form action="/searchUser" method="get">
												<label for="id">ID</label>
												<input type="text" id="id" name="id" placeholder="소환사 아이디 입력">
												<input type="image" src="images/search.png" alt="검색" class="search-button">
											</form>
										</div>
										
										<%-- ======================= --%>
                    <%-- ∥ 유저 첫번째 정보 화면 입니다. ∥ --%>
                    <%-- ======================= --%>
										<c:if test="${empty UserInfo}">
											<p>검색하신 아이디는 전적이 존재하지 않습니다.</p>
										</c:if>
										<c:if test="${not empty UserInfo}">
											<div class="container">
												<div class="user_container">
													<div class="item" id="user_imo">
														<c:set var="iconPath" value="${userIconPath}${UserInfo.profileIconId}.png" />
														<img src="${iconPath}">
														<p>${UserInfo.summonerLevel}</p>
														<div>
															${UserInfo.name}
														</div>
													</div>
													<div class="item" id="topChampionsList">

													</div>

													<c:forEach items="${SummonerRank}" var="rankData" varStatus="loop">
														<c:set var="winPercentage"
															value="${Math.round(rankData.wins / (rankData.wins + rankData.losses) * 100)}" />
														<c:set var="winPercentageInt" value="${Integer.parseInt(winPercentage)}" />

														<div class="item">
															<div>
																<c:choose>
																	<c:when test="${rankData.queueType eq 'RANKED_FLEX_SR'}">5:5 RANK</c:when>
																	<c:otherwise>SOLO RANK</c:otherwise>
																</c:choose>
															</div>
															<div style="width: 200px; height: 200px; margin: auto; position: relative;">
																<canvas id="donutChart${loop.index}"></canvas>
																<div
																	style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; color: black; font-size: 18px;">
																	${winPercentageInt}%
																</div>
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
																			// 가운데에 승률 표시
																			if (ctx.datasetIndex === 0) {
																				return winPercentage + '%';
																			} else {
																				return lossPercentage + '%';
																			}
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
												<%@ include file="rank_info.jsp" %>

													<!-- User 전적 드롭다운 데이터 -->
													<%@ include file="match_info.jsp" %>
											</div>
										</c:if>
						</body>
						</html>