<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
    
    <title>검색 결과</title>
    <script src="/js/jquery.js"></script>
    <link href="/css/main.css" rel="stylesheet"/>
    <link href="/css/board/board.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="../include/header.jsp" %><!-- 상단 메뉴바 -->
<%@ include file="boardHeader.jsp"%><!-- 검색 바 -->

<div class="big-container">
    <div class="interface">	 
        
        <button onclick="goboardMain();">게시판 메인이동</button>
        <button style="float:right; margin-right: 200px" onclick="goWrite();">글쓰기</button>
        <script>
            function goboardMain(){
                location = '/board/boardMain';
            }
            
            function goWrite(){
                location = '/board/boardWrite';
            }
        </script>

        <!-- 검색 결과 표시 -->
        <span><span style="color: red;">" ${b_title} "</span>에 대한 검색 결과입니다.</span>&nbsp;&nbsp;
        <span>총 <span style="color: red;">${listCount}개</span>의 검색 결과가 있습니다.</span><br><br>
    </div>

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

            <!-- 검색 결과 처리 -->
            <c:forEach var="boardInfo" items="${boardList}">
                <tr style="${memberInfo.m_id == boardInfo.b_id ? 'background-color: lightblue;' : ''}">
                    <td class="writer">${boardInfo.b_num}</td>
                    <td class="title"><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                    <td>${boardInfo.b_id}</td>
                    <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                    <td>${boardInfo.b_hits}</td>
                    <td <c:if test="${boardInfo.b_likes >= 30}">style="color: red;"</c:if>>${boardInfo.b_likes}</td>
                    <td>${boardInfo.replyCount}</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <%--alert 메시지에 반응하는 코드 --%>
    <c:if test="${not empty message}">
        <script>
            alert('${message}'); //addFlashAttribute로 생성한 것은 1회 사용 후 사라지기에 삭제 코드가 필요 없음
        </script>
    </c:if>
    <br><br>

<!-- 페이징(쪽나누기) -->
<div class="page_control">
    <!-- "이전" 버튼 -->
    <c:if test="${page > 1}">
        <a href="boardSearch?page=${page-1}&b_category=${bCategory}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">이전</a>
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
                <a href="boardSearch?page=${number}&b_category=${bCategory}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">${number}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- "다음" 버튼 -->
    <c:if test="${page < maxpage}">
        <a href="boardSearch?page=${page+1}&b_category=${bCategory}&b_title=${fn:escapeXml(b_title)}&viewMode=${viewMode}" class="page-button">다음</a>
    </c:if>
    <c:if test="${page >= maxpage}">
        <span class="page-button disabled">다음</span>
    </c:if>
</div>


</div>
</body>
</html>
