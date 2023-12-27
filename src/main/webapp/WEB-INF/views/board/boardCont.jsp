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
<div class="big-container">
    <div class="board_con">
        
        <form action="/board/boardUpdate?b_num=${boardInfo.b_num}">
           	<!-- 글 번호 -->
            <input type="hidden" name="b_num" id="b_num" value="${boardInfo.b_num}" >
            <!-- 글 조회수 -->
            <input type="hidden" name="b_hit" id="b_hit" value="${boardInfo.b_hits}">
        	<!-- 카테고리 -->
        	<input type="hidden" name="b_category" id="b_category" value="${boardInfo.b_category}">
        	<!-- 글 제목 -->
            <input type="hidden" name="b_title" id="b_title" value="${boardInfo.b_title}">
            <!-- 글 작성자 -->
            <input type="hidden" name="b_id" id="b_id" value="${boardInfo.b_id}">
            
            
            
            <h2>자유게시판</h2><hr>
            
            <%--글 상단 제목 박스 --%>
            <div class="title_box">
            	<div class="title">
		           <h4>글제목 : <b>${boardInfo.b_title}</b></h4>
		            작성자 : ${boardInfo.b_id}
            	</div>
            	
            	<div class="etc">
            		조회 ${boardInfo.b_hits} | 추천 ${boardInfo.b_likes} | <span style="text-align: right;">
		            					<fmt:formatDate value="${boardInfo.b_date}" pattern="yyyy-MM-dd HH:mm"/></span>
            	</div>
            </div><br>
            
            <%--글 내용 박스 --%>
            <div class="cont_box">
            	<div class="cont">
            		${boardInfo.b_cont}
            	</div>
            </div>
            
            <!-- 글 내용 -->
            <input type="hidden" name="b_cont" id="b_cont" value="${boardInfo.b_cont}">
            
            <!-- 추천수-->
            <input type="hidden" name="b_likes" id="b_likes" value="${boardInfo.b_likes}" readOnly><br> 
            </form>
            
            
            <!-- 추천버튼 --> 기능구현 할것
            <div class="likes_button">
            <input type = "button" value="추천하기👍 ${boardInfo.b_likes}">
            </div>
            
          </div>
          
          <%--댓글 영역 --%>
          <%-- 댓글 목록 출력 --%> 댓글에 대한 유효성 검사도 만들어야함 값이 너무크면 안들어감
          <p>* 댓글</p>
			<c:choose>
			    <c:when test="${not empty replyList}">
			        <div class="reply_list">
			            <table border="1">
			                <tr>
			                    <th>아이디</th>
			                    <th>내용</th>
			                    <th>날짜</th>
			                    <th>삭제</th>
			                </tr>
			                <c:forEach var="replyInfo" items="${replyList}">
			                    <tr>
			                        <td>${replyInfo.r_id}</td>
			                        <td>${replyInfo.r_cont}</td>
			                        <td><fmt:formatDate value="${replyInfo.r_date}" pattern="yyyy-MM-dd HH:mm"/></td>
			                        <td><a href="deleteReply?r_num=${replyInfo.r_num}"><button>삭제</button></a></td>
			                    </tr>
			                </c:forEach>
			            </table>
			        </div>
			    </c:when>

			    <c:otherwise>
			        <p>댓글이 없습니다. 첫 번째 댓글을 달아보세요!</p>
			    </c:otherwise>
			</c:choose>
            <br>
            
            <%-- 댓글 작성 영역 --%>
           <div class="reply_write">
            <form action="/board/writeReply" method="post">
		            		<input type="hidden" name="r_board_num" value="${boardInfo.b_num}">	<%--해당 게시글의 번호--%>
		            		<label>댓글작성</label><textarea rows="2" cols="50" name="r_cont"></textarea><br>
		            		<input type="hidden" name="r_id" value="${memberInfo.m_id}"><br>
		            		<div class="reply-button-container">
							    <input type="submit" value="댓글달기">
							</div>
            </form>
           </div>
  		
  		<hr>
  		
  		<br>
  		<div class="button-con">
  		 <!-- 목록으로 -->
            <input type="button" value="목록으로" onclick="goBoardMain();">        	
            <script>
            function goBoardMain(){
            	location = '/board/boardMain';
            }
         	</script>

            <!-- 글 수정 버튼 (글 작성자만 보이게함) -->
            <c:if test="${memberInfo.m_id == boardInfo.b_id}">
			    <form action="/board/boardUpdate?b_num=${boardInfo.b_num}" method="get">
			    <input type="hidden" name="b_num" value="${boardInfo.b_num}">
				<input type="submit" value="글수정">
				</form>
            
            <!-- 글삭제 -->
            <form action="boardDel?b_num=${boardInfo.b_num}" method="post">
			<input type="submit" value="글삭제">
			</form>
			</c:if>
		</div>
            

    
    
<%--alert 메시지에 반응하는 코드 --%>
<c:if test="${not empty message}">
    <script>
        alert('${message}');	//addFlashAttribute로 생성한것은 1회사용후 사라지기에 삭제코드가 필요없음
    </script>
</c:if>
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
