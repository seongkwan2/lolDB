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

<!-- 라디오 버튼 그룹 -->
    <input type="radio" id="showAllPosts" name="viewMode" value="all" checked>
    <label for="showAllPosts">전체글</label>

    <input type="radio" id="showPopularPosts" name="viewMode" value="popular">
    <label for="showPopularPosts">추천글</label>

<!-- 카테고리 선택 요소 -->
<select id="boardSelect" style="width: 150px;">
    <option value="자유게시판" ${bCategory == '자유게시판' ? 'selected' : ''}>자유게시판</option>
    <option value="팁게시판" ${bCategory == '팁게시판' ? 'selected' : ''}>팁게시판</option>
</select>

<script>
$(document).ready(function() {
    // 페이지 로드 시 현재 상태 확인 및 적용
    console.log("문서 준비 완료");
    checkViewMode();

    // 라디오 버튼 변경 이벤트
    $("input[type='radio'][name='viewMode']").change(function() {
        var viewMode = $(this).val();
        sessionStorage.setItem("viewMode", viewMode);
        updateView();
    });

    // 카테고리 변경 시 이벤트
    $('#boardSelect').change(function() {
        var category = $(this).val();
        sessionStorage.setItem("selectedCategory", category);
        sessionStorage.setItem("currentPage", 1); // 페이지를 1로 초기화
        updateView();
    });
});

function checkViewMode() {
    var viewMode = sessionStorage.getItem("viewMode") || "all";
    console.log("현재 뷰 모드:", viewMode);
    // 라디오 버튼 상태 갱신
    $("input[type='radio'][name='viewMode'][value='" + viewMode + "']").prop("checked", true);
    
    var selectedCategory = sessionStorage.getItem("selectedCategory") || "자유게시판";
    var currentPage = getCurrentPageFromUrl() || 1;

    // 페이지 초기 로드 시에는 AJAX 요청을 하지 않음
    // 예를 들어, 특정 플래그를 사용하여 초기 로드와 AJAX 요청을 구분
}

function updatePageByCategory(category, page, url) {
    console.log("AJAX 요청 시작: 카테고리:", category, ", 페이지:", page, ", URL:", url);
    $.ajax({
        url: url,
        type: 'GET',
        data: {
            b_category: category,
            page: page
        },
        success: function(response) {
            console.log("AJAX 응답 수신");
            $('#boardContent').html(response);
            console.log("DOM 업데이트 완료");
            addRowClickEvent();
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}


function getCurrentPageFromUrl() {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('page');
}


function updateView() {
    var viewMode = sessionStorage.getItem("viewMode") || "all";
    var selectedCategory = sessionStorage.getItem("selectedCategory") || "자유게시판";
    var currentPage = getCurrentPageFromUrl() || 1;
    var url = '/board/search'; // 검색 URL로 변경

    if (window.location.search) {
        $.ajax({
            url: url,
            type: 'GET',
            data: {
                b_category: selectedCategory,
                page: currentPage,
                viewMode: viewMode // 뷰 모드 추가
            },
            success: function(response) {
                // ...
            },
            error: function(xhr, status, error) {
                // ...
            }
        });
    }
}




</script>

<button style="float:right; margin-right: 200px" onclick = "goWrite();">글쓰기</button>
<script>
	function goWrite(){
		location = '/board/boardWrite';
	}
</script>
</div>

<%--boardList를 include하여 출력 --%>
<div id="boardContent">
	<%@ include file="boardList.jsp" %>
</div>

<%--행의 아무곳이나 선택해도 해당 글의 링크에 들어가는 코드 --%>
<script>
function addRowClickEvent() {
    console.log("이벤트 핸들러 설정 시작");
    $('.big-container').on('click', '.board-container tr', function(event) {
        console.log("행 클릭 이벤트 발생:", this);
        if (event.target.tagName.toLowerCase() === 'a') {
            return;
        }

        var link = $(this).find("a[href*='boardCont']").attr('href');
        if (link) {
            console.log("링크로 이동:", link.href);
            window.location.href = link;
        }
    });
    console.log("이벤트 핸들러 설정 완료");
}




// 페이지가 완전히 로드된 후 addRowClickEvent 함수를 호출
$(document).ready(function() {
    addRowClickEvent();
});
</script>

<%--alert 메시지에 반응하는 코드 --%>
<c:if test="${not empty message}">
    <script>
        alert('${message}'); //addFlashAttribute로 생성한 것은 1회 사용 후 사라지기에 삭제 코드가 필요 없음
    </script>
</c:if>


</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
