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

<!-- 카테고리 선택 요소 -->
<select id="boardSelect" style="width: 150px;">
    <option value="자유게시판" ${bCategory == '자유게시판' ? 'selected' : ''}>자유게시판</option>
    <option value="팁게시판" ${bCategory == '팁게시판' ? 'selected' : ''}>팁게시판</option>
</select>
<!-- bCategory 변수가 '자유게시판'과 동일한 경우에는 'selected' 문자열을 반환하여 해당 옵션을 선택한 것처럼 만들고
	그렇지 않으면 빈 문자열을 반환하여 선택되지 않은 상태로 지정 -->
	
<%--카테고리 선택시 발동되는 Javascript--%>
<script>
// 카테고리 변경 시 호출되는 함수
$('#boardSelect').change(function(){
    var category = $(this).val();
    var page = 1; // 페이지 초기화

    // 선택한 카테고리를 세션 스토리지에 저장
    sessionStorage.setItem("selectedCategory", category);

    // 페이지 업데이트 요청을 보냄(아래의 코드 실행)
    updatePageByCategory(category, page);
});

//카테고리별 글을 가져오는 코드 ajax구현
function updatePageByCategory(category, page) {
	// 세션에 선택한 카테고리 저장
    sessionStorage.setItem("selectedCategory", category);
    // AJAX 요청을 보냅니다.
    $.ajax({
        url: '/board/boardMain',
        type: 'GET',
        data: { 
            b_category: category,
            page: page // 페이지를 파라미터로 전달
        },
        success: function(response){
            $('#boardContent').html(response); // 받은 데이터로 게시판 내용을 업데이트
        }
    });
}
</script>


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

<%--행의 아무곳이나 선택해도 해당 글의 링크에 들어가는 코드 --%>
<script>
function addRowClickEvent() {
    // ".board-container tr" 선택자를 사용하여 모든 게시판 행을 선택합니다.
    var rows = document.querySelectorAll(".board-container tr");
    rows.forEach(function(row) {
        // 각 행에 클릭 이벤트 리스너를 추가
        row.addEventListener("click", function(event) {
            // 클릭된 요소가 a 태그인 경우 페이지 이동 (이 코드가 없으면 조회수가 서버에서 두번호출되서 조회수가 2가 오름)
            if (event.target.tagName.toLowerCase() === 'a') {//동작을 한번만 하도록 하기 위한 코드
                return;
            }

            // 현재 행에서 'boardCont'를 포함하는 href 속성을 가진 a 태그를 찾음
            var link = this.querySelector("a[href*='boardCont']");
            // 링크가 존재하고 href 속성이 있는 경우 해당 링크로 페이지를 이동
            if (link && link.href) {
                window.location.href = link.href;
            }
        });
    });
}

// 페이지가 완전히 로드된 후 addRowClickEvent 함수를 호출
$(document).ready(function() {
    addRowClickEvent();
});
</script>


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