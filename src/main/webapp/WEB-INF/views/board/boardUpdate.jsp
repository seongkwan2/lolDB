<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <script src="/js/jquery.js"></script>
    <link href="/css/main.css" rel="stylesheet"/>
    <link href="/css/board.css" rel="stylesheet"/>
    <link href="/css/boardWrite.css" rel="stylesheet"/>
</head>
<body>
    <%@ include file="../navbar.jsp"%>
    <%@ include file="boardHeader.jsp"%>

    <div class="board_con">
        <h2 style="text-align: center;">글 수정</h2><br>
        
        <form id="boardUpdateForm" method="post" onsubmit="return boardWriteCheck();">
           	<!-- 글 번호 -->
            글번호<input type="text" name="b_num" id="b_num" value="${boardInfo.b_num}" readOnly><br>
            
            조회수
            <!-- 글 조회수 -->
            <input type="text" name="b_hit" id="b_hit" value="${boardInfo.b_hits}" ><br>

        	<!-- 카테고리 -->
        	카테고리
        	<select id="b_category" name="b_category">
                <option value="자유게시판" ${boardInfo.b_category == '자유게시판' ? 'selected' : ''}>자유게시판</option>
                <option value="팁게시판" ${boardInfo.b_category == '팁게시판' ? 'selected' : ''}>팁게시판</option>
            </select><br><br>
            
            <!-- 글 작성자 -->
            작성자
            <input type="text" name="b_id" id="b_id" value="${boardInfo.b_id}" readOnly><br>
            
            <!-- 글 제목 -->
            제목
            <input type="text" name="b_title" id="b_title" value="${boardInfo.b_title}" ><br>
            
            <!-- 글 내용 -->
            내용
            <textarea name="b_cont" rows="5" id="b_cont">${boardInfo.b_cont}</textarea><br>
            
            <!-- 추천수-->
            추천수
            <input type="text" name="b_likes" id="b_likes" value="${boardInfo.b_likes}" ><br> 
            
            <input type="submit" id="editButton" value="수정완료">
            <input type="button" value="목록으로" onclick="goBoardMain();">
            
        </form>
    </div>

<script>

//@RequestBody와 JSON으로 전달되지 않는 문제 해결할것 자꾸 415에러가 나타남 
$("#editButton").click(function(event) {
    event.preventDefault(); // 폼 기본 제출 방지

    var data = {
    	b_num: $("#b_num").val(),
    	b_id: $("#b_id").val(),
        b_title: $("#b_title").val(),
        b_cont: $("#b_cont").val(),
        b_category: $("#b_category").val(),
        b_date: $("#b_date").val(),
        b_hits: $("#b_hits").val(),
        b_likes: $("#b_likes").val()
      
        
    };

    $.ajax({
        type: "POST",
        url: "/board/boardUpdate",
        contentType: "application/json", // JSON 형식으로 데이터 전송
        data: JSON.stringify(data), // 객체를 JSON 문자열로 변환
        success: function(response) {
            if (response.result === "success") {
                alert('게시글이 수정되었습니다!');
                window.location.href = '/board/boardMain'; // 성공 시 페이지 이동
            } else {
                alert('게시글 수정에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            alert('오류가 발생했습니다: ' + error);
        }
    });
});
</script>



</body>
</html>
