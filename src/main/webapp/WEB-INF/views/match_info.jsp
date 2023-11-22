<%@ page contentType="text/html; charset=UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
            $(document).ready(function () {
              $(".game-header button").click(function () {
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
<c:set var="imageBasePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
<c:set var="spellPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/" />
<div class="record_container">
                <h2>최근 전적</h2>
                <c:forEach items="${MatchList}" var="match">
                  <script>console.log(${ match.info.teams[0].objectives.champion.kills })
                    console.log(${ match.info.teams[0].teamId })</script>
                  <div class="game-header" id="${match.info.teams[0].win ? 'winback' : 'lossback'}">
                    <div>
                      ${match.info.teams[0].objectives.champion.kills} :
                      ${match.info.teams[1].objectives.champion.kills}
                    </div>

                    <c:forEach items="${match.info.participants}" var="participant">
                      <c:if test="${participant.summonerName eq UserInfo.name}">
                        <c:set var="itemList"
                          value="${participant.item0},${participant.item1},${participant.item2},${participant.item3},${participant.item4},${participant.item5},${participant.item6}" />
                        
                        <c:forEach var="champion" items="${champions}">
                        <c:if test="${participant.championId eq champion.key}">
                          <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
                          <img src="${imagePath}" alt="${champion.name}" id="record-champ-image">
                          </c:if>
                        </c:forEach>
                        
                        <c:forEach var="spell" items="${spells}">
												    <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
												        <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
												        <img src="${spellPaths}" alt="${spell.name}" id="record-champ-image">
												    </c:if>
												</c:forEach>

                        
                        
                        <c:forEach var="item" items="${itemList}">
                          <c:if test="${item ne '0'}">
                            <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                              alt='item Image' id="bar-item-image">
                          </c:if>
                        </c:forEach>
                        <span>${participant.kills} / ${participant.deaths} / ${participant.assists}</span>
                       
                        
                      </c:if>
                    </c:forEach>
                    | <span>플레이 시간: ${fn:substringBefore(match.info.gameDuration div 60, '.')}분
                      ${match.info.gameDuration
                      % 60}초</span> |
                    <span class="${match.info.teams[0].win ? 'win' : 'loss'}"> ${match.info.teams[0].win ? 'WIN' :
                      'LOSE'}</span>
                    <button>펼치기</button>
                  </div>

                  <!-- 숨겨져 있던 정보(펼치기를 눌러야 나오는 정보들) -->
                  <div class="game-details" style="display: none;">

                    <!-- 블루 팀 -->

                    <div class="blue-team">
                      <h4>BLUE Team</h4>
                      <table>
                        <thead>
                          <tr>
                            <th>Champ</th>
                            <th>ID</th>
                            <th>Lv</th>
                            <th>KDA</th>
                            <th>S/R</th>
                            <th>Item</th>
                            <th>G/CS</th>
                            <th>딜량</th>
                            <th>피해량</th>
                            <th>와드</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach items="${match.info.participants}" var="participant">
                            <tr class="participant-row">
                              <c:if test="${participant.teamId == 100}">
                                <c:set var="champPath" value="${champIconPath}${participant.championName}.png" />
                                <c:set var="itemList"
                                  value="${participant.item0},${participant.item1},${participant.item2},${participant.item3},${participant.item4},${participant.item5},${participant.item6}" />

                                <td>
                                <c:forEach var="champion" items="${champions}">
					                        <c:if test="${participant.championId eq champion.key}">
					                          <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
					                          <img src="${imagePath}" alt="${champion.name}" id="record-champ-image">
					                          </c:if>
					                        </c:forEach>
                                </td>
                                <td>${participant.summonerName}</td>
                                <td> ${participant.champLevel} </td>
                                <td>${participant.kills} / ${participant.deaths} / ${participant.assists}</td>
                                <td><c:forEach var="spell" items="${spells}">
                            <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
                                <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
                                <img src="${spellPaths}" alt="${spell.name}" id="record-champ-image">
                            </c:if>
                        </c:forEach></td>
                                <td>
                                  <c:forEach var="item" items="${itemList}">
                                    <c:if test="${item ne '0'}">
                                      <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                                        alt='item Image' id="record-item-image">
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>${participant.goldEarned}G <br> ${participant.totalMinionsKilled}CS</td>
                                <td>${participant.totalDamageDealt}</td>
                                <td>${participant.totalDamageTaken}</td>
                                <td>${participant.visionWardsBoughtInGame}<br>${participant.wardsPlaced} /
                                  ${participant.wardsKilled}</td>
                              </c:if>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>

                    </div>

                    <!-- 레드 팀 -->
                    <div class="red-team">
                      <h4>RED Team</h4>
                      <table>
                        <thead>
                          <tr>
                            <th>Champ</th>
                            <th>ID</th>
                            <th>Lv</th>
                            <th>KDA</th>
                            <th>S/R</th>
                            <th>Item</th>
                            <th>G/CS</th>
                            <th>딜량</th>
                            <th>피해량</th>
                            <th>와드</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach items="${match.info.participants}" var="participant">
                            <tr class="participant-row">
                              <c:if test="${participant.teamId == 200}">
                                <c:set var="champPath" value="${champIconPath}${participant.championName}.png" />
                                <c:set var="itemList"
                                  value="${participant.item0},${participant.item1},${participant.item2},${participant.item3},${participant.item4},${participant.item5},${participant.item6}" />

                                <td>
                                <c:forEach var="champion" items="${champions}">
                                  <c:if test="${participant.championId eq champion.key}">
                                    <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
                                    <img src="${imagePath}" alt="${champion.name}" id="record-champ-image">
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>${participant.summonerName}</td>
                                <td> ${participant.champLevel} </td>
                                <td>${participant.kills} / ${participant.deaths} / ${participant.assists}</td>
                                <td>
                                <c:forEach var="spell" items="${spells}">
                            <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
                                <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
                                <img src="${spellPaths}" alt="${spell.name}" id="record-champ-image">
                            </c:if>
                        </c:forEach>
                        </td>
                                
                                <td>
                                  <c:forEach var="item" items="${itemList}">
                                    <c:if test="${item ne '0'}">
                                      <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                                        alt='item Image' id="record-item-image">
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>${participant.goldEarned}G <br> ${participant.totalMinionsKilled}CS</td>
                                <td>${participant.totalDamageDealt}</td>
                                <td>${participant.totalDamageTaken}</td>
                                <td>${participant.visionWardsBoughtInGame}<br>${participant.wardsPlaced} /
                                  ${participant.wardsKilled}</td>
                              </c:if>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>

                    </div>
                  </div>
                </c:forEach>
              </div>
</body>
</html>