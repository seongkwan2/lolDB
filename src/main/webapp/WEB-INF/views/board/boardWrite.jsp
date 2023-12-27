<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글쓰기</title>
    <script src="/js/jquery.js"></script>
    <link href="/css/main.css" rel="stylesheet"/>
    <link href="/css/board/board.css" rel="stylesheet"/>
    <link href="/css/board/boardWrite.css" rel="stylesheet"/>
</head>
<body>
    <%@ include file="../include/header.jsp" %>
    <%@ include file="boardHeader.jsp"%>

    <div class="board_con">
        <h2 style="text-align: center;">게시판 글쓰기</h2><br> 
        
        <!-- 유효성검사 제작할것 여기서 부터 작업할것, 댓글유효성검사도 작성할것-->
		<form id="boardForm" method="post">
		    <select id="b_category" name="b_category">
		        <option value="자유게시판">자유게시판</option>
		        <option value="팁게시판">팁게시판</option>
		    </select><br><br>
		    <input type="hidden" name="b_id" value="${memberInfo.m_id}">
		    <input type="text" name="b_title" style="width: 100%" placeholder="글 제목" ><br>
		    <textarea name="b_cont"  placeholder="글 내용" rows="5"></textarea><br>
		    
		    <input type="submit" value="글쓰기">
		</form>

    </div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
