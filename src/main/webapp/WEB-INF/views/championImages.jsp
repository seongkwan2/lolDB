<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 이미지 목록</title>
    <style>
        .champion-container {
            display: flex;
            flex-wrap: wrap;
        }

        .champion-item {
            width: 20%; /* 5개씩 나오도록 설정 */
            padding: 10px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <h2>챔피언 이미지 목록</h2>
    <c:set var="imageBasePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
    
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
      
    <div class="champion-container">
        <c:forEach var="champion" items="${champions}" varStatus="loop">
            <div class="champion-item">
                <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
                <img src="${imagePath}" alt="${champion.name} Image">
                <p>${champion.name}</p>
                <p>${champion.blurb}</p>
            </div>
            
            <%-- 매 5번째 아이템마다 새로운 행 시작 --%>
            <c:if test="${loop.index % 5 == 3}">
                </div><div class="champion-container">
            </c:if>
        </c:forEach>
    </div>
</body>
</html>
