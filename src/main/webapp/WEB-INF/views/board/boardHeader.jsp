<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>boardHeader</title>
</head>
<body>

    <!-- 질문 검색바 -->
    <div class="search-container">
        <form action="/board/boardMain" method="get" onsubmit="return validateForm();">
            <div class="search_bar">
                <!-- 검색 필드 -->
                <input type="search" name="b_title" id="b_title" class="search_box" placeholder="&nbsp; 검색" value="${b_title}">
                
                <!-- 페이지 번호 -->
                <input type="hidden" name="page" value="${page != null ? page : 1}">

                <!-- 검색 버튼 -->
                <input type="submit" class="box" style="margin-left: 10px;" value="검색">

                <!-- 카테고리 선택 -->
                <select name="b_category" id="b_category" style="margin: 0px 10px 0px 10px;">
                    <option value="" ${empty b_category ? "selected" : ""}>--게시판 선택--</option>
                    <option value="자유게시판" ${"자유게시판".equals(b_category) ? "selected" : ""}>자유게시판</option>
                    <option value="팁게시판" ${"팁게시판".equals(b_category) ? "selected" : ""}>팁게시판</option>
                </select>
            </div>
        </form>
    </div>

    <script>
    function validateForm() {
        var b_title = document.getElementById("b_title").value;
        var b_category = document.getElementById("b_category").value;

        // 검색 조건을 sessionStorage에 저장
        sessionStorage.setItem("b_title", b_title);
        sessionStorage.setItem("b_category", b_category);

        if (b_category === "") {
            alert("게시판을 지정하고 검색해주세요");
            return false; // 폼 제출 중단
        }
        return true; // 폼 제출
}

// 페이지 로드 시 검색 조건을 복원
document.addEventListener("DOMContentLoaded", function() {
    var storedBTitle = sessionStorage.getItem("b_title");
    var storedBCategory = sessionStorage.getItem("b_category");

    if (storedBTitle !== null) {
        document.getElementById("b_title").value = storedBTitle;
    }
    if (storedBCategory !== null) {
        document.getElementById("b_category").value = storedBCategory;
    }
});
</script>

<br>
</body>
</html>