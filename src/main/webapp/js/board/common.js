// 모듈 1: 검색 기능 관련 함수
function executeSearch() {
    var b_title = $('#b_title').val();
    var b_category = $('select[name="b_category"]').val();
    var page = $('#searchPage').val() || 1;

    console.log("검색 요청 데이터: ", { b_title, b_category, page });

    $.ajax({
        url: '/board/search',
        type: 'GET',
        data: { b_title, b_category, page },
        success: function(response) {
            console.log("검색 결과: ", response);

            // 스크롤을 페이지 상단으로 이동
            $('html, body').animate({ scrollTop: 0 }, 'fast');

            // 기존 이벤트 핸들러를 해제하고 새로운 핸들러를 추가
            $('.big-container').off('click', '.board-container tr');
            addRowClickEvent();

            // 검색 결과를 화면에 표시
            $('#boardContent').html(response);
        },
        error: function(error) {
            console.error("검색 에러: ", error);
        }
    });
}

// 모듈 2: 클릭 이벤트 핸들러 추가
function addRowClickEvent() {
    console.log("이벤트 핸들러 설정 시작");
    $('.big-container .board-container tr').off('click').on('click', function(event) {
        if (event.target.tagName.toLowerCase() === 'a') {
            return;
        }
        var link = $(this).find("a[href*='boardCont']").attr('href');
        if (link) {
            window.location.href = link;
        }
    });
    console.log("이벤트 핸들러 설정 완료");
}

// 모듈 3: 페이지 업데이트 함수
function updatePageByCategory(category, page, url) {
    $.ajax({
        url: url,
        type: 'GET',
        data: { b_category: category, page: page },
        success: function(response) {
            $('#boardContent').html(response);
            $('.big-container').off('click', '.board-container tr');
            addRowClickEvent();
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}
