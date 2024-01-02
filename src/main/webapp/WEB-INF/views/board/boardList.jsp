<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/board/board.css" rel="stylesheet"/>
</head>
<body>
<%--게시판 목록 출력 테이블 --%>
<br>
<div class="board-container">
    <table border="1">
        <tr style="font-weight: bold; background-color: #49557d; color:#f8f8f8;">
            <td>번호</td> <td class="title">제목</td> <td class="writer">작성자</td> <td>작성일자</td> <td>조회수</td> <td>추천</td> <td>댓글수</td>
        </tr>
        <c:forEach var="boardInfo" items="${boardList}">	<%--내가 작성한글은 배경색상이 존재 --%>
            <tr style="${memberInfo.m_id == boardInfo.b_id ? 'background-color: lightblue;' : ''}">
                <td class="writer">${boardInfo.b_num}</td>
                <td class="title"><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                <td>${boardInfo.b_id}</td>
                <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                <td>${boardInfo.b_hits}</td>
                <td>${boardInfo.b_likes}</td>
                <td>${boardInfo.replyCount}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>