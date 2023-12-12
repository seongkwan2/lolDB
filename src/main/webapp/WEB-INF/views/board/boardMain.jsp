<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/js/jquery.js"></script>
<link href="/css/main.css" rel="stylesheet"/>
<link href="/css/board.css" rel="stylesheet"/>
</head>
<body>
<%@ include file="../navbar.jsp"%>

<div class="clear"></div>

<%-- 질문 검색바 --%>
<div class="search-container">
	<form>
	
	<div class="search_bar">
	      <input type="search" name="find_name" id="find_name" 
	      class="search_box" placeholder="&nbsp; 검색" value="${find_name}">
	      
	      <input type="submit" class="box" value="찾기">                                                                                                                                                                                
	      <input type="button" class="box" value="설정">                                                                                                                                                                                
	</div>
	</form>
</div>

<br><br>

<div class="interface">
<input type="button" value="전체글">
<input type="button" value="개념글">
<input type="button" value="공지사항">
</div>

<br>

<div class="board-container">
	<table border="1">
		<tr>
			<td>번호</td> <td>제목</td> <td>글쓴이</td> <td>작성일</td> <td>조회수</td> <td>추천</td>
		</tr>
		<c:forEach var="board" items="${boardList}">
		<tr>
				<td>${board.b_num}</td>
				<td>${board.b_title}</td>
				<td>${board.b_id}</td>
				<td><fmt:formatDate value="${board.b_time}" pattern="yyyy-MM-dd"/> </td>
				<td>${board.b_hits}</td>
				<td>${board.b_likes}</td>
		</tr>
		</c:forEach>
	</table>
</div>

<%--페이징(쪽나누기)--%>
<div id="page_control">
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

</body>
</html>