/**
 * 
 */
 
 function serch_email(){
	  if($.trim($("#m_name").val())== ""){
		  alert("이름을 입력하세요!");
		  $("#m_name").val("").focus();
		  return false;
	  }
	  if($.trim($("#m_email").val())== ""){
		  alert("이메일을 입력하세요!");
		  $("#m_email").val("").focus();
		  return false;
	  }
	 
}
function last_ck(){
	  if($.trim($("#m_name").val())== ""){
		  alert("이름을 입력하세요!");
		  $("#m_name").val("").focus();
		  return false;
	  }
	  if($.trim($("#m_email").val())== ""){
		  alert("이메일을 입력하세요!");
		  $("#m_email").val("").focus();
		  return false;
	  }
	  if($.trim($("#ck_email").val())== ""){
		  alert("인증번호를 입력하세요!");
		  $("#ck_email").val("").focus();
		  return false;
	  }
}