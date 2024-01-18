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

    <div class="big-container">
        <div class="board_con">
            <h2 style="text-align: center;">글 수정</h2><br>
            
            <form id="boardUpdateForm" method="post" enctype="multipart/form-data" onsubmit="return boardWriteCheck();">
                <!-- 글 번호 -->
                <input type="hidden" name="b_num" id="b_num" value="${boardInfo.boardInfo.b_num}" >
                <!-- 글 조회수 -->
                <input type="hidden" name="b_hit" id="b_hit" value="${boardInfo.boardInfo.b_hits}">
                <!-- 카테고리 -->
                <input type="hidden" name="b_category" id="b_category" value="${boardInfo.boardInfo.b_category}">
                <!-- 글 작성자 -->
                <input type="hidden" name="b_id" id="b_id" value="${boardInfo.boardInfo.b_id}">
                <!-- 추천수 -->
                <input type="hidden" name="b_likes" id="b_likes" value="${boardInfo.boardInfo.b_likes}">
                
                <h2>${boardInfo.boardInfo.b_category}</h2><hr>
                
                <!-- 글 상단 제목 박스 -->
                <div class="cont_title_box">
                    <div class="cont_title">
                        <h4>글제목 : <b>
                            <input type="text" name="b_title" id="b_title" value="${boardInfo.boardInfo.b_title}">
                        </b></h4>
                        작성자 : ${boardInfo.boardInfo.b_id}
                    </div>
                    
                    <div class="cont_etc">
                        조회 ${boardInfo.boardInfo.b_hits} | 추천 ${boardInfo.boardInfo.b_likes} | <span style="text-align: right;">
                            <fmt:formatDate value="${boardInfo.boardInfo.b_date}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </div>
                </div><br>
                
                <!-- 글 내용 박스 -->
                <div class="cont_box">
                    <div class="cont">
                        <!-- 이미지 파일이 존재하는 경우에만 이미지 태그를 표시 -->
                        <div class="img_box">
                            <c:if test="${boardInfo.fileInfo != null}">
                                <img src="/upload/image/${boardInfo.fileInfo.f_upload_name}" alt="게시글 이미지">
                            </c:if>
                        </div>
                        <br><br>
                        <!-- 글 내용 -->
                        내용
                        <textarea name="b_cont" rows="5" id="b_cont">${boardInfo.boardInfo.b_cont}</textarea><br>
                        <%--이미지 파일 --%>
                        <input type="file" name="file" id="file" accept=".jpg, .png">
                    </div>
                </div>
                <br><br>
                <div class="button-con">
                    <input type="submit" class="button" id="editButton" value="수정완료">
                    <input type="button" class="button" value="이전으로" onclick="goBack();">
                    <input type="button" class="button" value="목록으로" onclick="goBoardMain();">
                </div>
            </form>
        </div>
    </div>

    <script>
    // 유효성 검사 함수
    function boardWriteCheck() {
        var form = $("#boardUpdateForm");
        var title = form.find("#b_title").val();
        var cont = form.find("#b_cont").val();
        
        if (title == "") {
            alert("제목을 입력하세요!");
            form.find("#b_title").val("").focus();
            return false;
        }
        if (title.length > 20) {
            alert("제목은 20자 이내로 작성해주세요!");
            form.find("#b_title").val(title.slice(0, 20)); // 20자를 초과하는 부분을 잘라냄
            form.find("#b_title").focus();
            return false;
        }
        if (cont == "") {
            alert("내용을 입력하세요!");
            form.find("#b_cont").val("").focus();
            return false;
        }
        if (cont.length > 3000) {
            alert("내용은 3000자 이내로 작성해주세요!");
            form.find("#b_cont").val(cont.slice(0, 3000));
            form.find("#b_cont").focus();
            return false;
        }
        return true;
    }

    // 뒤로 가기 함수
    function goBack() {
        window.history.back();
    }
    // 목록으로 이동 함수
    function goBoardMain() {
        location.href = "/board/boardMain";
    }
    </script>

    <%@ include file="../include/footer.jsp" %>
</body>
</html>
                