<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 이미지 목록</title>
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
