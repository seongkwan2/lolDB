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
					    $(".game-header #bar-arrow").click(function () {
					    	var gameDetails = $(this).parent().next(".game-details");
					      var downImage = $(this).find("#down-image");
					      var upImage = $(this).find("#up-image");
					
					      if (downImage.is(":visible")) {
					        gameDetails.slideDown();
					        downImage.hide();
					        upImage.show();
					      } else {
					        gameDetails.slideUp();
					        downImage.show();
					        upImage.hide();
					      }
					    });
					  });
          </script>
          
</head>
<body>
<c:set var="imageBasePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
<c:set var="spellPath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/" />
<c:set var="perkPath" value="https://ddragon.leagueoflegends.com/cdn/img/" />
<div class="record_container">
                <c:forEach items="${MatchList}" var="match">
                  <div class="game-header" id="${match.info.teams[0].win ? 'winback' : 'lossback'}">

                    <c:forEach items="${match.info.participants}" var="participant">
                      <c:if test="${participant.summonerName eq UserInfo.name}">
                        <c:set var="itemList"
                          value="${participant.item0},${participant.item1},${participant.item2},${participant.item3},${participant.item4},${participant.item5},${participant.item6}" />
                        <div class="game-header-element" id="bar-champ">
                        <c:forEach var="champion" items="${champions}">
                        <c:if test="${participant.championId eq champion.key}">
                          <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
                          <img src="${imagePath}" alt="${champion.name}" id="record-champ-image">
                          </c:if>
                        </c:forEach>
                        </div>
                        <div class="game-header-element" id="bar-level">
                          Lv.${participant.champLevel}
                        </div>
                         <div class="game-header-element">
                         <div>
                        <c:forEach var="spell" items="${spells}">
												    <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
												        <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
												        <img src="${spellPaths}" alt="${spell.name}" id="spell-image">
												    </c:if>
												</c:forEach>
												</div>
												<div>
												<c:forEach var="runes" items="${runes}">
												    <%-- 핵심 룬 --%>
												    <c:forEach var="rune" items="${runes.slots[0].runes}" varStatus="loop">
												        <c:if test="${participant.perks.styles[0].selections[0].perk eq rune.id}">
												            <img src="${perkPath}${rune.icon}" alt="Perk Image ${loop.index}" id="rune-image"/>
												        </c:if>
												    </c:forEach>
												    <%-- 보조 룬 --%>
												    <c:if test="${participant.perks.styles[1].style eq runes.id}">
                              <img src="${perkPath}${runes.icon}" alt="Perk Image" id="rune-image"/>
                             </c:if>
												</c:forEach>
												</div>
												</div>
												
										
                        
                        <div class="game-header-element" id="bar-item">
                        <c:forEach var="item" items="${itemList}">
                          <c:if test="${item ne '0'}">
                            <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                              alt='item Image' id="bar-item-image">
                          </c:if>
                        </c:forEach>
                        </div>
                        
                        <div class="game-header-element" id="bar-kda">${participant.kills} / ${participant.deaths} / ${participant.assists}</div>
                        
                        <div class="game-header-element" id="bar-goldcs">
                        ${participant.goldEarned}G <br> ${participant.totalMinionsKilled + participant.neutralMinionsKilled}CS
                        </div>
                        
                      <div class="game-header-element" id="bar-ward">
                    <img src="/images/pinkward.png" alt="pinkward" id="pinkward"> ${participant.visionWardsBoughtInGame}<br>
                    ${participant.wardsPlaced} / ${participant.wardsKilled}
                    </div>
                        
                      </c:if>
                    </c:forEach>
                   <div class="game-header-element" id="bar-time">${fn:substringBefore(match.info.gameDuration div 60, '.')}분
                      ${match.info.gameDuration
                      % 60}초</div> 
                    
                    <div class="${match.info.teams[0].win ? 'win' : 'loss'} game-header-element" id = "bar-winloss"> 
                    ${match.info.teams[0].win ? 'WIN' :
                      'LOSE'}</div>
                    
                    <div class="game-header-element" id="bar-arrow">
                      <img src="/images/down.png" id="down-image" style="display: block;">
                      <img src="/images/up.png" id="up-image" style="display: none;">
                     </div>
                   
                  </div>

                  <!-- 숨겨져 있던 정보(펼치기를 눌러야 나오는 정보들) -->
                  <div class="game-details" style="display: none;">

                    <!-- 블루 팀 -->

                    <div class="blue-team" id="${match.info.teams[0].win ? 'winback' : 'lossback'}">
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
                                <td>
                                <div><c:forEach var="spell" items="${spells}">
                            <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
                                <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
                                <img src="${spellPaths}" alt="${spell.name}" id="spell-image">
                            </c:if>
                            
                        </c:forEach>
                        </div>
                        <div>
                        <c:forEach var="runes" items="${runes}">
                            <%-- 핵심 룬 --%>
                            <c:forEach var="rune" items="${runes.slots[0].runes}" varStatus="loop">
                                <c:if test="${participant.perks.styles[0].selections[0].perk eq rune.id}">
                                    <img src="${perkPath}${rune.icon}" alt="Perk Image ${loop.index}" id="rune-image"/>
                                </c:if>
                            </c:forEach>
                            <%-- 보조 룬 --%>
                            <c:if test="${participant.perks.styles[1].style eq runes.id}">
                              <img src="${perkPath}${runes.icon}" alt="Perk Image" id="rune-image"/>
                             </c:if>
                        </c:forEach>
                        </div>
                        </td>
                                <td>
                                  <c:forEach var="item" items="${itemList}">
                                    <c:if test="${item ne '0'}">
                                      <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                                        alt='item Image' id="record-item-image">
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>${participant.goldEarned}G <br> ${participant.totalMinionsKilled + participant.neutralMinionsKilled}CS</td>
                                <td>${participant.totalDamageDealt}</td>
                                <td>${participant.totalDamageTaken}</td>
                                <td>
                                <img src="/images/pinkward.png" alt="pinkward" id="pinkward">
                                ${participant.visionWardsBoughtInGame}<br>${participant.wardsPlaced} /
                                  ${participant.wardsKilled}</td>
                              </c:if>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>

                    </div>

                    <!-- 레드 팀 -->
                    <div class="red-team" id="${match.info.teams[1].win ? 'winback' : 'lossback'}">
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
                                <div>
                                <c:forEach var="spell" items="${spells}">
                            <c:if test="${participant.summoner1Id eq spell.key or participant.summoner2Id eq spell.key}">
                                <c:set var="spellPaths" value="${spellPath}${spell.image.full}" />
                                <img src="${spellPaths}" alt="${spell.name}" id="spell-image">
                            </c:if>
                        </c:forEach>
                        </div>
                        <div>
                        <c:forEach var="runes" items="${runes}">
                            <%-- 핵심 룬 --%>
                            <c:forEach var="rune" items="${runes.slots[0].runes}" varStatus="loop">
                                <c:if test="${participant.perks.styles[0].selections[0].perk eq rune.id}">
                                    <img src="${perkPath}${rune.icon}" alt="Perk Image ${loop.index}" id="rune-image"/>
                                </c:if>
                            </c:forEach>
                            <%-- 보조 룬 --%>
                            <c:if test="${participant.perks.styles[1].style eq runes.id}">
                              <img src="${perkPath}${runes.icon}" alt="Perk Image" id="rune-image"/>
                             </c:if>
                        </c:forEach>
                        </div>
                        </td>
                                
                                <td>
                                  <c:forEach var="item" items="${itemList}">
                                    <c:if test="${item ne '0'}">
                                      <img src="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/item/${item}.png"
                                        alt='item Image' id="record-item-image">
                                    </c:if>
                                  </c:forEach>
                                </td>
                                <td>${participant.goldEarned}G <br> ${participant.totalMinionsKilled + participant.neutralMinionsKilled}CS</td>
                                <td>${participant.totalDamageDealt}</td>
                                <td>${participant.totalDamageTaken}</td>
                                <td>
                                <img src="/images/pinkward.png" alt="pinkward" id="pinkward">
                                 ${participant.visionWardsBoughtInGame}<br>${participant.wardsPlaced} /
                                  ${participant.wardsKilled}</td>
                              </c:if>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>

                    </div>
                  </div>
                </c:forEach>
                <button>버튼</button>
              </div>
</body>
</html>