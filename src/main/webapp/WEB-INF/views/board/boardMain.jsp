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
<input type="button" value="공지사항">

<%--카테고리로 게시판 이동--%>
<select id="boardSelect" style="width: 150px;">
    <option value="자유게시판">자유게시판</option>
    <option value="팁게시판">팁게시판</option>
</select>

<button style="float:right; margin-right: 200px" onclick = "goWrite();">글쓰기</button>
<script>
	function goWrite(){
		location = '/board/boardWrite';
	}
</script>
</div>
파일 올리는것도 구현하기

<%--boardList를 include하여 출력 --%>
<div id="boardContent">
	<%@ include file="boardList.jsp" %>
</div>

<%--카테고리 별 글을 가져오는 ajax구현 --%>
<script>
// 카테고리 변경 시 호출되는 함수   카테고리 변경시 해당 카테고리의 게시글 수만큼 페이징이 남게하기 //무조건 여기부터할것
function updatePageByCategory(category, page) {
    // AJAX 요청을 보냅니다.
    $.ajax({
        url: '/board/boardMain', // 요청할 URL을 지정하세요.
        type: 'GET',
        data: { 
            b_category: category,
            page: page // 페이지를 파라미터로 전달합니다.
        },
        success: function(response){
            $('#boardContent').html(response); // 받은 데이터로 게시판 내용을 업데이트합니다.
        }
    });
}

// 카테고리 선택 요소의 변경 이벤트 핸들러
$('#boardSelect').change(function(){
    var category = $(this).val();
    var page = 1; // 페이지 초기화
    updatePageByCategory(category, page); // 카테고리 변경 시 페이지 업데이트
});

// 페이지 번호를 클릭할 때 호출되는 함수
function goToPage(page) {
    var category = $('#boardSelect').val();
    updatePageByCategory(category, page); // 페이지 변경 시 페이지 업데이트
}

</script>



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



<br><br>
<%--페이징(쪽나누기)--%>
<div class="page_control">
    <!-- "이전" 버튼 섹션 -->
    <c:if test="${page > 1}">
        <a href="boardMain?page=${page-1}" class="page-button">이전</a>&nbsp;
    </c:if>
    <c:if test="${page <= 1}">
        <span class="page-button disabled">이전</span>&nbsp;
    </c:if>

    <!-- 페이지 번호를 출력하는 섹션 -->
    <c:forEach var="number" begin="${startpage}" end="${endpage}" step="1">
        <c:if test="${number == page}">
            <span class="page-button current-page disabled">${number}</span>
        </c:if>
        <c:if test="${number != page}">
            <a href="boardMain?page=${number}" class="page-button">${number}</a>
        </c:if>
    </c:forEach>

    <!-- "다음" 버튼 섹션 -->
    <c:if test="${page < maxpage}">
        <a href="boardMain?page=${page+1}" class="page-button">다음</a>
    </c:if>
    <c:if test="${page >= maxpage}">
        <span class="page-button disabled">다음</span>
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