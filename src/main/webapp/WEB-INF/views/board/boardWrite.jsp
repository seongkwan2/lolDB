<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 글쓰기</title>
    <script src="/js/jquery.js"></script>
    <link href="/css/main.css" rel="stylesheet"/>
    <link href="/css/board.css" rel="stylesheet"/>
    <link href="/css/boardWrite.css" rel="stylesheet"/>
</head>
<body>
    <%@ include file="../navbar.jsp"%>
    <%@ include file="boardHeader.jsp"%>

    <div class="board_con">
        <h2 style="text-align: center;">게시판 글쓰기</h2><br>
        
        <form id="boardForm" method="post">
        
        	<select id="b_category" name="b_category">
                <option value="자유게시판">자유게시판</option>
                <option value="팁게시판">팁게시판</option>
            </select><br><br>
            
            <input type="text" name="b_id" placeholder="작성자 아이디" ><br> <%--나중엔 여기에 readonly로 로그인정보를 삽입 --%>
            <input type="text" name="b_title" placeholder="글 제목" ><br>
            <textarea name="b_cont" placeholder="글 내용" rows="5" ></textarea><br>
            
            <input type="submit" value="글쓰기">
        </form>
    </div>


</body>
</html>