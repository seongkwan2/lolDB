<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/championimages.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
    <title>챔피언 이미지 목록</title>
</head>
<body>

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
    <c:set var="imageBasePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
    <c:set var="champImagePath" value="https://ddragon.leagueoflegends.com/cdn/img/champion/splash/" />
    <c:set var="skillImagePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/spell/" />
    <c:set var="passivePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/passive/" />

    <%-- 성관이가 한 부분
    <!-- 프로퍼티 파일을 로드 -->
    <c:import url="classpath:championNames.properties" var="championNamesProps" />
    
    <c:forEach var="champion" items="${champions}">
    <div>
        <p>${championKoreanNames[champion.name]}</p>
        <img src="${imageBasePath}${champion.image.full}" alt="${championKoreanNames[champion.name]} Image">
    </div>
</c:forEach>
    
</body>
</html>
   --%>   
    <div class="champion-container">
    
        <c:forEach var="champion" items="${champions}" varStatus="loop">
            <div class="champion-item">
                <img src ="${champImagePath}${champion.id}_0.jpg" id="champion-image" onclick="openModal(${loop.index})">
  
                
                
                
            <div id="myModal-${loop.index+1}" class="moodal">
              <div id="close-icon" onclick="closeModal(${loop.index})">X</div>
              <div class="modal-content">
                <div class="modal-item">
                
	                <div>
		               <img src ="${champImagePath}${champion.id}_0.jpg" id="modal-champ-image">
		              </div>
	              
                <div>
                <div id="modal-champ-name">${champion.name}</div>
                  <div class="modal-skill-item">
		              <img src ="${passivePath}${champion.passive.image.full}" id="skill-image" class="passive-image">
		              <p id="passive-content" class="skill-content">${champion.passive.name} / ${champion.passive.description}</p>
		              </div>
		              
		              <c:forEach var="index" begin="0" end="3">
		              <div class="modal-skill-item">
		               <img src ="${skillImagePath}${champion.spells[index].image.full}" id="skill-image">
		               <p class="skill-content">${champion.spells[index].name} / ${champion.spells[index].description}</p>
		               </div>
		              </c:forEach>
                </div>
                
	             </div>
              </div> 
            </div>
            
            
            
                <div id="champ-name">
                  <p>${champion.name}</p>
                </div>
                
            </div>
        </c:forEach>
    </div>
            <script>
            var id;
				        function openModal(id) {
				        	console.log(id);
				        	const index = id + 1;
				            const modal = document.querySelector('#myModal-'+index);
				            modal.style.display = 'block';
				
				            window.addEventListener('click', function (event) {
				                if (event.target === modal) {
				                    modal.style.display = 'none';
				                }
				            });
				        }
				        
				        function closeModal(id) {
				        	const index = id + 1;
				        	const modal = document.querySelector('#myModal-'+index);
				        	modal.style.display = 'none';
				        }
				    </script>
</body>
</html>
