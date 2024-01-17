<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
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
            <td>번호</td>
            <td class="title">제목</td>
            <td class="writer">작성자</td>
            <td>작성일자</td>
            <td>조회수</td>
            <td>추천수</td>
            <td>댓글수</td>
        </tr>
        <!-- 일반 게시판 목록 및 추천 게시판 목록 처리 -->
        <c:choose>
            <c:when test="${not empty popularPosts}">
                <!-- 추천 게시글 목록 처리 -->
                <c:forEach var="boardInfo" items="${popularPosts}">
                    <tr style="${loginInfo.m_id == boardInfo.b_id ? 'background-color: #D3D3D3;' : ''}">
                        <td class="writer">${boardInfo.b_num}</td>
                        <td class="title"><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                        <td>${boardInfo.b_id}</td>
                        <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                        <td>${boardInfo.b_hits}</td>
                        <td <c:if test="${boardInfo.b_likes >= 30}">style="color: red;"</c:if>>${boardInfo.b_likes}</td>
                        <td>${boardInfo.replyCount}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- 일반 게시글 목록 처리 -->
                <c:forEach var="boardInfo" items="${boardList}">
                    <tr style="${loginInfo.m_id == boardInfo.b_id ? 'background-color: #D3D3D3;' : ''}">
                        <td class="writer">${boardInfo.b_num}</td>
                        <td class="title"><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                        <td>${boardInfo.b_id}</td>
                        <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                        <td>${boardInfo.b_hits}</td>
                        <td <c:if test="${boardInfo.b_likes >= 30}">style="color: red;"</c:if>>${boardInfo.b_likes}</td>
                        <td>${boardInfo.replyCount}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>
</div>
<br><br>

<!-- 페이징(쪽나누기) -->
<div class="page_control">
    <!-- "이전" 버튼 -->
    <c:if test="${page > 1}">
        <a href="boardMain?page=${page-1}&b_category=${b_category}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">이전</a>
    </c:if>
    <c:if test="${page <= 1}">
        <span class="page-button disabled">이전</span>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach var="number" begin="${startpage}" end="${endpage}" step="1">
        <c:choose>
            <c:when test="${number == page}">
                <span class="page-button current-page disabled">${number}</span>
            </c:when>
            <c:otherwise>
                <a href="boardMain?page=${number}&b_category=${b_category}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">${number}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- "다음" 버튼 -->
    <c:if test="${page < maxpage}">
        <a href="boardMain?page=${page+1}&b_category=${b_category}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">다음</a>
    </c:if>
    <c:if test="${page >= maxpage}">
        <span class="page-button disabled">다음</span>
    </c:if>
</div>





</body>
</html>