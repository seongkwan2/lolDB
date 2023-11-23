<%@ page contentType="text/html; charset=UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

          <c:set var="userIconPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/profileicon/" />
          <c:set var="champIconPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />


          <div class="head-content">
          <h1>LoL Search</h1>
          <div>
          <form action="/championImages" method="get">
            <a href="/championImages" class="button-link"> 챔피언 </a>
          </form>
          </div>
            </div>


            <div class="search-box">
              <form action="/searchUser" method="get">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" placeholder="소환사 아이디 입력">
                <input type="image" src="images/search.png" alt="검색" class="search-button">
</form>
              </form>
            </div>

          <%-- <%@ include file="mode_toggle.jsp" %>--%> <%-- 다크모드 라이트모드 주석처리 --%>
          

          <c:if test="${empty UserInfo}">
            <p>검색하신 아이디는 전적이 존재하지 않습니다.</p>
          </c:if>

          <!-- User 아이디 레벨 정보 -->
          <c:if test="${not empty UserInfo}">
            <div class="container">
              <div class="user_container">
                <div>
                  <c:set var="iconPath" value="${userIconPath}${UserInfo.profileIconId}.png" />
                  <img src="${iconPath}">
                  <p>${UserInfo.summonerLevel}</p>
                  <div>
                    ${UserInfo.name}
                  </div>
                </div>

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
              <%@ include file="rank_info.jsp" %>

              <!-- User 전적 드롭다운 데이터 -->
              <%@ include file="match_info.jsp" %>
          </c:if>
          </div>
        </body>

        </html>