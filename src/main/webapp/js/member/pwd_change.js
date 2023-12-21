
function pwd_ck(){
	  if($.trim($("#m_pwd").val())== ""){
		  alert("변경 할 비밀번호를 입력하세요!");
		  $("#m_pwd").val("").focus();
		  return false;
	  }
	  if($.trim($("#ck_pwd").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#ck_pwd").val("").focus();
		  return false;
	  }
	  var pwd = document.getElementById("m_pwd").value;
	  var ck_pwd = document.getElementById("ck_pwd").value;
	  
	  if(pwd != ck_pwd ){
		  alert("비밀번호가 다릅니다!");
		  $("#ck_pwd").val("").focus();
		  return false;
		  
	  }
	  
	 
}

