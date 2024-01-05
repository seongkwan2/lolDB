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
    <form action="/board/search" method="get">
    
    <div class="search_bar">
          <input type="search" name="b_title" id="b_title" 
          class="search_box" placeholder="&nbsp; 검색" value="${b_title}">
           <!-- 페이지 번호 입력 필드 추가 -->
    		<input type="hidden" name="page" id="searchPage" value="${page != null ? page : 1}">	
         &nbsp;&nbsp;
          <input type="submit" class="box" value="찾기" onclick="executeSearch();">&nbsp;&nbsp;
          	<select name="b_category">
			    <option value="자유게시판" ${b_category == '자유게시판' ? 'selected' : ''}>자유게시판 검색</option>
			    <option value="팁게시판" ${b_category == '팁게시판' ? 'selected' : ''}>팁게시판 검색</option>
    		</select>&nbsp;&nbsp;                                                                                                                                                                                
    </div>
    <script>
    function executeSearch() {
        var b_title = $('#b_title').val();
        var b_category = $('select[name="b_category"]').val();
        var page = 1;

        console.log("검색 요청 데이터: ", { b_title, b_category, page }); // 요청 데이터 로그

        $.ajax({
            url: '/board/search',
            type: 'GET',
            data: { b_title, b_category, page },
            success: function(response) {
                console.log("검색 결과: ", response); // 응답 로그
                $('#boardContent').html(response);
                addRowClickEvent(); // 새로운 내용에 대한 이벤트 핸들러 추가
            },
            error: function(error) {
                console.error("검색 에러: ", error); // 에러 로그
            }
        });
    }

    $(document).ready(function() {
        // 폼 제출 시 검색 실행
        $('form').on('submit', function(event) {
            event.preventDefault();
            var selectedCategory = $('select[name="b_category"]').val();
            sessionStorage.setItem('selectedCategory', selectedCategory);
            executeSearch(); // 검색 실행 함수 호출
        });

        // 저장된 카테고리 값을 설정
        var savedCategory = sessionStorage.getItem('selectedCategory');
        if (savedCategory) {
            $('select[name="b_category"]').val(savedCategory);
        }
    });

    </script>
    </form>
</div>



<br><br>
</body>
</html>