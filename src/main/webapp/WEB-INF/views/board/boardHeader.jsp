<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardHeader</title>
</head>
<body>

<%-- 질문 검색바 --%>
<div class="search-container">
    <form action="/board/search" method="get" onsubmit="return validateForm();">
        <div class="search_bar">
            <input type="search" name="b_title" id="b_title" class="search_box" placeholder="&nbsp; 검색" value="${b_title}">
            &nbsp;&nbsp;
            <!-- 페이지 번호 -->
            <input type="hidden" name="page" value="${page != null ? page : 1}"> 
            <input type="submit" class="box" value="검색">&nbsp;&nbsp;
            
            <!-- 카테고리 선택 -->
            <select name="b_category" id="b_category">
                <option value="" ${empty b_category ? "selected" : ""}>--게시판 선택--</option>
                <option value="자유게시판" ${"자유게시판".equals(b_category) ? "selected" : ""}>자유게시판</option>
                <option value="팁게시판" ${"팁게시판".equals(b_category) ? "selected" : ""}>팁게시판</option>
            </select>&nbsp;&nbsp;
        </div>
    </form>
</div>
<br><br>

<script>
function validateForm() {
    var category = document.getElementById("b_category").value;
    if (category === "") {
        alert("게시판을 지정하고 검색해주세요");
        return false; // 폼 제출 중단
    }
    return true; // 폼 제출 허용
}

// 페이지 로드 시 검색 조건을 저장
document.addEventListener("DOMContentLoaded", function() {
    var urlParams = new URLSearchParams(window.location.search);
    var b_title = urlParams.get("b_title") || "";
    var b_category = urlParams.get("b_category") || "";

    document.getElementById("b_title").value = b_title;
    document.getElementById("b_category").value = b_category;
});
</script>
</body>
</html>
