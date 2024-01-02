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
$(document).ready(function(){
    // 현재 선택된 카테고리 값을 저장하거나 가져오는 함수
    function setCategory(category) {
        if (category) { //sessionStorage에 현재의 카테고리를 저장해서 페이징 처리해도 유지되게함
            sessionStorage.setItem('category', category);
        } else {
            return sessionStorage.getItem('category');
        }
    }

    // 페이지 로딩 시 저장된 카테고리 값을 select 요소에 설정
    var savedCategory = setCategory();
    if (savedCategory) {
        $('#boardSelect').val(savedCategory);
    }

    $('#boardSelect').change(function(){
        var category = $(this).val();
        setCategory(category); // 선택된 카테고리 저장

        // AJAX 요청
        $.ajax({
            url: '/board/boardMain',
            type: 'GET',
            data: { 
                b_category: category,
                page: 1
            },
            success: function(response){
                $('#boardContent').html(response);
            }
        });
    });

    // 페이징 링크에 카테고리 값을 포함시키는 로직 추가
    $(document).on('click', '.page-button', function(e) {
        e.preventDefault();
        var pageLink = $(this).attr('href');	//href 속성을 가져와 pageLink 변수에 저장
        var category = setCategory(); 	// 현재 카테고리 가져오기
        if (category) {
            pageLink += "&b_category=" + category; // URL에 카테고리 추가
        }
        location.href = pageLink; // 페이지 이동
    });
});
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
    <!-- 현재 페이지가 1보다 큰 경우, "이전" 링크를 활성화 -->
    <c:if test="${page > 1}">
        <a href="boardMain?page=${page-1}" class="page-button">이전</a>&nbsp;
    </c:if>
    <!-- 현재 페이지가 1 이하인 경우, "이전" 링크를 비활성화(텍스트만 출력) -->
    <c:if test="${page <= 1}">
        <span class="page-button">이전</span>&nbsp;
    </c:if>

    <!-- 페이지 번호를 출력하는 섹션 -->
    <!-- startpage부터 endpage까지의 각 페이지 번호를 반복하여 출력합니다. -->
    <c:forEach var="number" begin="${startpage}" end="${endpage}" step="1">
        <!-- 현재 페이지 번호에는 강조 스타일을 적용합니다. -->
        <c:if test="${number == page}">
            <span class="page-button current-page">${number}</span>
        </c:if>
        <!-- 현재 페이지가 아닌 번호는 클릭 가능한 링크로 표시합니다. -->
        <c:if test="${number != page}">
            <a href="boardMain?page=${number}" class="page-button">${number}</a>
        </c:if>
    </c:forEach>

    <!-- "다음" 버튼 섹션 -->
    <!-- 현재 페이지가 maxpage 미만인 경우, "다음" 링크를 활성화합니다. -->
    <c:if test="${page < maxpage}">
        <a href="boardMain?page=${page+1}" class="page-button">다음</a>
    </c:if>
    <!-- 현재 페이지가 maxpage 이상인 경우, 비활성화된 "다음" 텍스트를 표시합니다. -->
    <c:if test="${page >= maxpage}">
        <span class="page-button">다음</span>
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