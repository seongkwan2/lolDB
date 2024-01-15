$(document).ready(function() {
    // 페이지 로드 시 현재 상태 확인 및 적용
    console.log("문서 준비 완료");
    checkViewMode();

    // 라디오 버튼 변경 이벤트
    $("input[type='radio'][name='viewMode']").change(function() {
        var viewMode = $(this).val();
        sessionStorage.setItem("viewMode", viewMode);
        sessionStorage.setItem("currentPage", 1); // 세션에 페이지값을 1로 초기화
        updateView();
    });

    // 카테고리 변경 시 이벤트
    $('#boardSelect').change(function() {
        var category = $(this).val();
        sessionStorage.setItem("selectedCategory", category);
        sessionStorage.setItem("currentPage", 1); // 페이지를 1로 초기화
        updateView();
    });

    // 검색 버튼 클릭 시 페이지 새로고침
    $('#searchButton').click(function() {
        sessionStorage.setItem("currentPage", 1); // 페이지를 1로 초기화
        location.reload(); // 페이지 새로고침
    });
});

// 페이지 업데이트 함수
function updateView() {
    var viewMode = sessionStorage.getItem("viewMode") || "all";
    var selectedCategory = sessionStorage.getItem("selectedCategory") || "자유게시판";
    var currentPage = sessionStorage.getItem("currentPage") || 1;

    $.ajax({
        url: '/board/boardMain',
        type: 'GET',
        data: {
            b_category: selectedCategory,
            page: currentPage,
            viewMode: viewMode
        },
        success: function(response) {
            $('#boardContent').html(response);
            addRowClickEvent();
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", status, error);
        }
    });
}

// 행 클릭 이벤트 처리 함수
function addRowClickEvent() {
    console.log("이벤트 핸들러 설정 시작");
    $('.big-container').on('click', '.board-container tr', function(event) {
        console.log("행 클릭 이벤트 발생:", this);
        if (event.target.tagName.toLowerCase() === 'a') {
            return;
        }

        var link = $(this).find("a[href*='boardCont']").attr('href');
        if (link) {
            console.log("링크로 이동:", link.href);
            window.location.href = link;
        }
    });
    console.log("이벤트 핸들러 설정 완료");
}
