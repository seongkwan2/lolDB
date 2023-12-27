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
	<form>
	
	<div class="search_bar">
	      <input type="search" name="find_name" id="find_name" 
	      class="search_box" placeholder="&nbsp; 검색" value="${find_name}">
	      
	      <input type="submit" class="box" value="찾기">                                                                                                                                                                                
	      <input type="button" class="box" value="설정">                                                                                                                                                                                
	</div>
	</form>
</div>

<br><br>
</body>
</html>