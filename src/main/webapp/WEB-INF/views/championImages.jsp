<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>챔피언 이미지 목록</title>
</head>
<body>
    <h2>챔피언 이미지 목록</h2>
    <c:set var="imageBasePath" value="https://ddragon.leagueoflegends.com/cdn/13.22.1/img/champion/" />
      
    <c:forEach var="champion" items="${champions}">
        <div>
            <p>${champion.name}</p>
            <c:set var="imagePath" value="${imageBasePath}${champion.image.full}" />
            <img src="${imagePath}" alt="${champion.name} Image">
        </div>
    </c:forEach>
</body>
</html>