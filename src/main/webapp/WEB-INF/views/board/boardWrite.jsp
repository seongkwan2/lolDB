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
        
		<form id="boardForm" method="post" onsubmit="return boardWriteCheck();">
		    <select id="b_category" name="b_category">
		        <option value="자유게시판">자유게시판</option>
		        <option value="팁게시판">팁게시판</option>
		    </select><br><br>
		    <input type="hidden" name="b_id" id="b_id" value="${memberInfo.m_id}">
		    <input type="text" name="b_title" id="b_title" style="width: 100%" placeholder="글 제목" ><br>
		    <textarea name="b_cont" id="b_cont" placeholder="글 내용" rows="5"></textarea><br>
		    
		    <input type="submit" value="글쓰기">
		</form>
		
		<%--유효성 검사--%>
		<script>
			function boardWriteCheck(){
				var title = $("#b_title").val();
				var cont = $("#b_cont").val();
				
				if (title == ""){
					alert("제목을 입력하세요!");
					$("#b_title").val("").focus();
					return false;
				}
				if(title.length > 20){
		            alert("제목은 20자 이내로 작성해주세요!");
		            $("#b_title").val(title.slice(0, 20)); // 20자를 초과하는 부분을 잘라냄
		            $("#b_title").focus();
		            return false;
		        }
				if (cont == ""){
					alert("내용을 입력하세요!");
					$("#b_cont").val("").focus();
					return false;
				}
				if(cont.length > 3000){
		            alert("내용은 3000자 이내로 작성해주세요!");
		            $("#b_cont").val(cont.slice(0, 3000));
		            $("#b_cont").focus();
		            return false;
		        }
				return true;
			}
		</script>
    </div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
