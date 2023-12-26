<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <script src="/js/jquery.js"></script>
    <link href="/css/main.css" rel="stylesheet"/>
    <link href="/css/board/board.css" rel="stylesheet"/>
    <link href="/css/board/boardWrite.css" rel="stylesheet"/>
</head>
<body>
    <%@ include file="../include/header.jsp" %>
    <%@ include file="boardHeader.jsp"%>

    <div class="board_con">
        <h2 style="text-align: center;">글 확인</h2><br>
        
        <form action="/board/boardUpdate?b_num=${boardInfo.b_num}">
           	<!-- 글 번호 -->
            글번호 : ${boardInfo.b_num}
            <input type="hidden" name="b_num" id="b_num" value="${boardInfo.b_num}" readOnly><br>
            
            <!-- 글 조회수 -->
            조회수 : ${boardInfo.b_hits}
            <input type="hidden" name="b_hit" id="b_hit" value="${boardInfo.b_hits}" ><br>

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
            <input type="text" name="b_title" id="b_title" value="${boardInfo.b_title}" readOnly><br>
            
            <!-- 글 내용 -->
            내용
            <textarea name="b_cont" rows="5" id="b_cont" readOnly>${boardInfo.b_cont}</textarea><br>
            
            <!-- 추천수-->
            추천수 : ${boardInfo.b_likes}
            <input type="hidden" name="b_likes" id="b_likes" value="${boardInfo.b_likes}" readOnly><br> 
            
            <!-- 추천버튼 -->
            <input type = "button" value="추천하기"> <br><br><br><br>
            
            <input type="submit" value="글수정"> <%--글수정 버튼을 세션의 아이디값과 작성자의 아이디값을 비교해서 버튼을 보이게 만듬 --%>
            <input type="button" value="목록으로" onclick="goBoardMain();">
            
            <a href="boardDel?b_num=${boardInfo.b_num}"> <%-- boardDel메서드에 b_num값을 전달해서 동작시킴 --%>
			<input type="button" value="글삭제">
			</a>
            
            <script>
            function goBoardMain(){
            	location = '/board/boardMain';
            }
            
            </script>
            
        </form>
    </div>

</body>
</html>
