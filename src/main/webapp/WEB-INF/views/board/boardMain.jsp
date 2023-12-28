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

<div class="big-container">
<div class="interface">
<input type="button" value="전체글">
<input type="button" value="개념글">
<input type="button" value="공지사항">이 부분 해결할것 셀렉부분
<select style = "width: 150px;"> 여기부터 수정할것 카테고리 나눈것으로 이거하고 페이징 처리할것
	<option>자유게시판</option>
	<option>팁게시판</option>
</select>
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
        <tr style="font-weight: bold; background-color: #49557d; color:#f8f8f8;">
            <td>번호</td> <td>제목</td> <td>작성자</td> <td>작성일자</td> <td>조회수</td> <td>추천</td> <td>댓글수</td>
        </tr>
        <c:forEach var="boardInfo" items="${boardList}">	<%--내가 작성한글은 배경색상이 존재 --%>
            <tr style="${memberInfo.m_id == boardInfo.b_id ? 'background-color: lightblue;' : ''}">
                <td>${boardInfo.b_num}</td>
                <td><a href="boardCont?b_num=${boardInfo.b_num}">${boardInfo.b_title}</a></td>
                <td>${boardInfo.b_id}</td>
                <td><fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd"/></td>
                <td>${boardInfo.b_hits}</td>
                <td>${boardInfo.b_likes}</td>
                <td>${boardInfo.replyCount}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<%--행의 아무곳이나 선택해도 해당 글의 링크에 들어가짐 --%>
<script>
function addRowClickEvent() {
    // 테이블의 각 행에 대해 이벤트 리스너 추가
    var rows = document.querySelectorAll(".board-container tr");
    rows.forEach(function(row) {
        row.addEventListener("click", function() {
            var link = this.querySelector("a");
            if(link) {
                window.location.href = link.href; // 링크로 이동
            }
        });
    });
}
//DOM이 완전히 로드된 후 함수 실행
document.addEventListener("DOMContentLoaded", addRowClickEvent);
</script>




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

<%--새로고침 강제 (사용자가 새로고침 하지 않아도 조회수가 바로바로 갱신)--%>
<script>
window.onpageshow = function(event) {
    if (event.persisted) {
        window.location.reload();
    }
};
</script>
</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>