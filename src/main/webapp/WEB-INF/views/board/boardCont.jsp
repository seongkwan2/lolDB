<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%--날짜를 형식에 맞게 표현하기 위한 태그라이브러리--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 확인</title>
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
            </form>
            <!-- 추천버튼 -->
            <input type = "button" value="추천하기"> <br><br><br><br>
            
            <!-- 댓글 -->
            <form action="writeReply" method="post">
	            <table border="1">
	           		 <tr>
		            	<td colspan="2">
		            		<label>댓글</label><textarea rows="2" cols="50" name="r_cont"></textarea><br>
		            		<label>작성자</label><input type="text" name="r_id" value=""><br>
		            		<input type="submit" value="댓글달기">
		            	</td>
	            	</tr>
	            </table>
            </form>
            
            <table border="1">
	            <tr>
			        <th>아이디</th>
			        <th>내용<th>
			        <th>날짜</th>
			        <th>삭제</th>
			        </tr>
			        
				 <c:forEach var="replyInfo" items="${replyList}">    
	            <tr>
	            	<td>${replyInfo.r_id}</td>
	            	<td>${replyInfo.r_cont}</td>
	            	<td><fmt:formatDate value="${replyInfo.r_date}" pattern="MM-dd HH:mm" /></td>
	            	<td><a href="deleteReply?r_num=${reply_vo.r_num}"><button>삭제</button></a></td>
	           	</tr>
	           	</c:forEach>
            </table>
            
            
            
            
            
            
            
            
            <!-- 글 수정 버튼 (글 작성자만 보이게함) -->
            <c:if test="${memberInfo.m_id == boardInfo.b_id}">
			    <input type="submit" id="Editbutton" value="글수정">
			</c:if>
			
            <input type="button" value="목록으로" onclick="goBoardMain();">
            
            <!-- 글삭제 -->
            <form action="boardDel?b_num=${boardInfo.b_num}" method="post">
			<input type="submit" value="글삭제">
			</form>
            
        	<script>
            function goBoardMain(){
            	location = '/board/boardMain';
            }
            
         	</script>
    </div>

</body>
</html>
