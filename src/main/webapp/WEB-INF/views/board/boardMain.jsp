<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 메인페이지</title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/board/board.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<%@ include file="boardHeader.jsp"%>


<div class="interface">
<input type="button" value="전체글">
<input type="button" value="개념글">
<input type="button" value="공지사항">
<input type="button" value="글쓰기" style="float:right; margin-right: 200px" onclick = "goWrite()";>
<script>
	function goWrite(){
		location = '/board/boardWrite';
	}
</script>
</div>

<br>

<div class="board-container">
    <table border="1">
        <tr>
            <td>번호</td> <td>제목</td> <td>글쓴이</td> <td>작성일</td> <td>조회수</td> <td>추천</td>
        </tr>
        <c:forEach var="boardInfo" items="${boardList}">	<%--내가 작성한글은 배경색상이 존재 --%>
            <tr style="${memberInfo.m_id == boardInfo.b_id ? 'background-color: lightgray;' : ''}">
                <td>${boardInfo.b_num}</td>
                <td><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                <td>${boardInfo.b_id}</td>
                <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                <td>${boardInfo.b_hits}</td>
                <td>${boardInfo.b_likes}</td>
            </tr>
        </c:forEach>
    </table>
</div>



<%--페이징(쪽나누기)--%>
<br>
<div id="page_control" style="display: flex; align-items: center; justify-content: center; font-size:18px">
	<%--검색전 페이징 --%>
	<c:if test="${(empty find_field)&&(empty find_name)}">
		<c:if test="${page <=1}">[이전]&nbsp;</c:if>
		<c:if test="${page >1}">
			<a href="boardMain?page=${page-1}">[이전]</a>&nbsp;
				</c:if>

		<%--쪽번호 출력부분 --%>
		<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
			<c:if test="${a == page}"><${a}></c:if>
			<c:if test="${a != page}">
				<a href="boardMain?page=${a}">[${a}]</a>&nbsp;
					</c:if>
		</c:forEach>
		<c:if test="${page>=maxpage}">[다음]</c:if>
		<c:if test="${page<maxpage}"><a href="boardMain?page=${page+1}">[다음]</a></c:if>
	</c:if>
	
	<%-- 검색후 페이징(쪽나누기) --%>
	<c:if test="${(!empty find_field) || (!empty find_name)}">
		<c:if test="${page <=1}">[이전]&nbsp;</c:if>
		<c:if test="${page >1}">
			<a href="boardMain?page=${page-1}&find_field=${find_field}
				&find_name=${find_name}">[이전]</a>&nbsp;
			</c:if>

	<%--쪽번호 출력부분 --%>
	<c:forEach var="a" begin="${startpage}" end="${endpage}" step="1">
		<c:if test="${a == page}"><${a}></c:if>
		<c:if test="${a != page}">
			<a href="boardMain?page=${a}&find_field=${find_field}
				&find_name=${find_name}">[${a}]</a>&nbsp;
			</c:if>
	</c:forEach>

	<c:if test="${page>=maxpage}">[다음]</c:if>
	<c:if test="${page<maxpage}">
		<a href="boardMain?page=${page+1}&find_field=${find_field}
			&find_name=${find_name}">[다음]</a>
	</c:if>
</c:if>
</div>

<div  class="write-menu">
<c:if test="${(!empty find_field) && (!empty find_name)}">
	<input type="button" value="전체목록" onclick="location='boardMain?page=${page}';" />
</c:if>
</div>

<%--alert 메시지에 반응하는 코드 --%>
<c:if test="${not empty message}">
    <script>
        alert('${message}');	//addFlashAttribute로 생성한것은 1회사용후 사라지기에 삭제코드가 필요없음
    </script>
</c:if>



</body>
</html>