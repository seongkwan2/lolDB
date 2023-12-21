//전역 변수로 아이디 중복 체크 상태 저장, 작성한 아이디가 사용가능이면 true로 변환
let isIdChecked = false;
//아이디 정규식 체크 (아이디가 4글자 이상 16이하, 영문,숫자 포함이면 OK)
let idType = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,16}$/;
//비밀번호 정규식 체크
let pwdType = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;


//모든 폼을 입력했는지 체크하는 함수 joinCheck()
function joinCheck(){
	  if($.trim($("#m_id").val())== ""){
		  alert("아이디를 입력하세요!");
		  $("#m_id").val("").focus();
		  return false;
	  }
	  
	  if(!idType.test(m_id.value)){ //아이디 값이 정규식 패턴과 일치하지 않으면
		  alert("아이디는 영문자+숫자 조합 \n 4이상~16자리 이하로만 사용해야합니다. ");
		  $("#m_id").val("").focus();
		  return false;
	  }
	  
	  if($.trim($("#m_pwd").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#m_pwd").val("").focus();
		  return false;
	  }
	  if($.trim($("#m_pwd2").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#m_pwd2").val("").focus();
		  return false;
	  }
	  
	  //비밀번호 검증
	  if(!pwdType.test(m_pwd2.value)){
		  alert("비밀번호는 영문자+숫자+특수문자 조합 \n 8이상~12자리 이하로만 사용해야합니다. ");
		  $("#m_pwd2").val("").focus();
		  return false;
	  }
	  
	  //비밀번호 일치 테스트
	 if(m_pwd.value !== m_pwd2.value ){
		 alert("비밀번호가 일치하지 않습니다!");
		  $("#m_pwd2").val("").focus();
		  return false;
	 }
	  
	  // 이름 검증
	  if($.trim($("#m_name").val())== ""){
		  alert("이름을 입력하세요!");
		  $("#m_name").val("").focus();
		  return false;
	  }
	  
	 // 생년월일 검증
	    let birthValue = $.trim($("#m_birth").val());
	    if(!/^[0-9]{8}$/.test(birthValue)){
	        alert("생년월일은 8자리의 숫자만 입력해야 합니다.");
	        $("#m_birth").val("").focus();
	        return false;
	    }

   	// 전화번호 검증
	    let phoneValue = $.trim($("#m_phone").val());
	    if(!/^[0-9]+$/.test(phoneValue)){
	        alert("전화번호는 숫자만 입력해야 합니다.");
	        $("#m_phone").val("").focus();
	        return false;
    	}
    
    	//이메일 검증
	  if($.trim($("#m_email").val())== ""){
		  alert("이메일을 입력하세요!");
		  $("#m_email").val("").focus();
		  return false;
	  }

      // 모든 조건을 통과한 후 아이디 중복 체크를 했는지 확인
      if (!isIdChecked) {
          alert("아이디 중복 확인을 해주세요.");
          return false;
      }
      
      // 모든 조건을 통과하면 form 제출
      sendForm();
}

// 아이디 중복 확인
function checkid() {
    // 아이디 영역을 숨김
    $m_id = $.trim($("#m_id").val());

    // 입력 글자 길이 체크
    if ($m_id.length < 4) {
        $newtext = '<font color="red" size="3"><b>아이디는 4자 이상이어야 합니다.</b></font>';
        $("#idcheck").text('');
        $("#idcheck").show();
        $("#idcheck").append($newtext);
        $("#m_id").val('').focus();
        return false;
    };

    if ($m_id.length > 16) {
        $newtext = '<font color="red" size="3"><b>아이디는 16자 이하이어야 합니다.</b></font>';
        $("#idcheck").text('');
        $("#idcheck").show();
        $("#idcheck").append($newtext);
        $("#m_id").val('').focus();
        return false;
    };

    // 영문 숫자 조합
    if (!idType.test($m_id)) {
        $newtext = '<font color="red" size="3"><b>아이디는 영문 소문자 + 숫자 조합으로 만들어주세요.</b></font>';
        $("#idcheck").text('');
        $("#idcheck").show();
        $("#idcheck").append($newtext);
        $("#m_id").val('').focus();
        return false;
    };

    // 아이디 중복 확인
    $.ajax({
        type: "POST",
        url: "/member/member_idcheck",
        data: { "m_id": $m_id },
        dataType: "json", // JSON 형식의 데이터를 기대
        success: function (data) {
            if (data == "1") {
                $newtext = '<font color="#EB0000" size="3"><b>중복 아이디입니다.</b></font>';
                $("#idcheck").text('');
                $("#idcheck").show();
                $("#idcheck").append($newtext);
                $("#m_id").val('').focus();
                return false;
            } else {
                $newtext = '<font color="#1E90FF" size="3"><b>사용가능한 아이디입니다.</b></font>';
                $("#idcheck").text('');
                $("#idcheck").show();
                $("#idcheck").append($newtext);
                $("#m_pwd").focus();
                isIdChecked = true; // 사용 가능한 아이디일 경우 true로 변경
            }
        },
        error: function () {
            alert("서버 오류");
        }
    });
}



//우편검색 창
function post_check(){
	$url="/member/zip_find";//매핑주소
	window.open($url,"우편검색","width=415px,height=190px,"
			+"scrollbars=yes");
	//폭이 415 픽셀이고,높이가 190 픽셀,스크롤바가 생성되는
	//우편번호 검색 공지창을 띄운다.
} 
      
 

//클라이언트가 작성한 내용들로 회원가입
function sendForm(){
	var formData = {
			"m_id": $("#m_id").val(),
	        "m_pwd": $("#m_pwd").val(),
	        "m_name": $("#m_name").val(),
	        "m_birth": $("#m_birth").val(),
	        "m_email": $("#m_email").val(),
	        "m_phone": $("#m_phone").val(),
	}; //formData
	
	$.ajax({
	    url:"/member/sign",
	    method:"POST",
	    data:JSON.stringify(formData),
	    contentType: "application/json",
		success: function(map) {
		    console.log("Response from server:", map);
		    if(map.status === "success") {
		        Swal.fire({
		            title: '가입성공 입니다.',
		            text: map.message,  // 서버로부터 받은 메시지 사용
		            icon: 'success',
		            confirmButtonText: '확인',
		            customClass: {
		                title: 'my-title-class',
		                content: 'my-content-class'
		            }
		        }).then((result) => {
		            if (result.isConfirmed) {
		                // 사용자가 확인 버튼을 클릭한 경우
		                window.location.href = "/member/login";  // 페이지를 /member/login으로 리다이렉트
		            }
		        });
		    } else {
		        Swal.fire({
		            title: '가입실패 입니다.',
		            text: map.message,  // 서버로부터 받은 메시지 사용
		            icon: 'error',
		            confirmButtonText: '확인',
		            customClass: {
		                title: 'my-title-class',
		                content: 'my-content-class'
	                }
	            });
	        }
	    },
	    error: function(jqXHR, textStatus, errorThrown) {
	        console.error('Error Details:', textStatus, errorThrown);
	        alert('서버와의 통신 중 오류가 발생했습니다.');
	    }
	});//ajax

}//sendForm()
