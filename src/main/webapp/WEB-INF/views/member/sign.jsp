<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<script type="text/javascript" src="/js/member/sign.js"></script>
<script>

</script>
<h1>회원가입</h1>

<form id=frm method="post">
<table border="1">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="m_id" id="m_id" placeholder="아이디를 입력하세요">
	</tr>
	
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="m_pwd" id="m_pwd" placeholder="비밀번호를 입력하세요">
	</tr>
	
	<tr>
		<td colspan="2">
		<input type="submit" value="가입" onclick="return signCheck()"></td>
	</tr>

</table>
</form>

</body>
</html>