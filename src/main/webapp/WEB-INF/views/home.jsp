<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery.js"></script>
<script type="text/javascript" src="https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/%EC%A1%B0%EC%84%B1%EA%B4%80"></script>
<link href="/css/main.css" rel="stylesheet" />
</head>
<body>
메인페이지 입니다.

<script>
var globalBuyDate; // 전역 변수로 buy_date 선언
function payMent(paymentType, rental_cr_mid, mem_m_phone, mem_m_name, car_c_name, car_c_color, car_c_year, total_price) {

	IMP.init('imp87360186');

	 var showName = car_c_year+'년식 ' + car_c_color + ' ' + car_c_name;
	 var pgValue;
	 globalBuyDate = new Date().getTime();	// 날짜 값을 전역 변수에 저장

	    if (paymentType === "card") {
	        pgValue = "html5_inicis";
	    } else if (paymentType === "kakao") {
	        pgValue = "kakaopay";
	    }
	 //IMP.request_pay() 함수는 내부적으로 정의된 파라미터만 처리하므로, buy_date와 같은 '사용자 정의 파라미터는 무시'된다.
	 //그렇기 때문에 결제 후 콜백 함수 내부에서 rsp.buy_date를 참조하려고 하면 값이 없어서 null이 된다.
	 //buy_date를 '전역 변수로 설정'하여 payMent 함수에서 값을 할당하고, 콜백 함수 내에서 이 값을 사용하는 방식으로 수정
	 
	IMP.request_pay({
	    pg : pgValue,
	    pay_method : 'card', //카드결제
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : showName,
	    amount : total_price, //판매가격
	    buyer_name : rental_cr_mid,
	    buyer_tel : mem_m_phone,
	}, function(rsp) {
	    if ( rsp.success ) {
		var msg = '결제가 완료되었습니다.';
		msg += '고유ID : ' + rsp.imp_uid;
		msg += '상점 거래ID : ' + rsp.merchant_uid;
		msg += '결제 금액 : ' + rsp.paid_amount;
		msg += '카드 승인번호 : ' + rsp.apply_num;
		   
		pay_info(rsp);
		
	    } else {
	        var errorMsg = '결제가 취소되었습니다.';
	        alert(errorMsg);
	        history.back();	//이전 페이지로 돌아가기
	    }
	});
}
//데이터 담아서 비동기식으로 JSON타입으로 데이터 전송
	function pay_info(rsp) {
    var orderData = {
        buyer_name: rsp.buyer_name,
        buyer_phone: rsp.buyer_tel,
        member_email: rsp.buyer_email,
        buy_product_name: rsp.name,
        buyer_buyid: rsp.imp_uid,
        amount: rsp.paid_amount,
        buyer_card_num: rsp.apply_num,
        buyer_pay_ok: rsp.success,
        buyer_postcode: rsp.buyer_postcode,
        merchantId: rsp.merchant_uid,
        paid_at: globalBuyDate,		//결제일자를 paid_at 변수로 받음 paid_at를 컨트롤러로 가공해서 buy_date로 만들것임
    };

 // AJAX 요청
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: "/rent/rent_Check",
        data: JSON.stringify(orderData),
        dataType: "json",
        success: function(map) {
            console.log(map); 
            console.log("Success value:", map.success);
            
            if(map.success) {
            	const orderInfo = map.orderInfo;
                const rental = map.rental;
                location.href = map.redirectUrl	 // 서버에서 지정한 URL로 리디렉트

        }else {
                alert("결제 정보 처리 중 오류 발생 다시 시도해주세요");
                history.back(); //이전 페이지로 이동
        }
    },
        error: function(error) {
        console.error("Error:", error); //콘솔에 에러 로그 출력
            alert("오류로 인해서 결제가 취소되었습니다. 다시 시도해주세요");
            location.href = "/rent/rent";
        }
	});
}

</script>
</body>
</html>