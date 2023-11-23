<%@ page contentType="text/html; charset=UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.btn {
  float: right;
  width: 200px;
  height: 50px;
  border-radius: 50px;
  font-size: 15px;
  text-align: center;
  background-color: black;
  color: white;
  margin-top: 20px;
  border: 1px solid gray;
}
</style>
</head>
<body>
<script>
function setDisplayAppreance(self) {
	var body = document.querySelector('body');
	var btn = document.getElementById('btnDisplayMode');
	if(self.value === 'DarkMode'){
		body.style.backgroundColor = 'black';
		body.style.color = 'white';
		btn.style.backgroundColor = 'yellow';
		btn.style.color = 'black';
		self.value = 'LightMode';
	} else {
	    body.style.backgroundColor = 'white';
	    body.style.color = 'black';
	    btn.style.backgroundColor = 'black';
	    btn.style.color = 'white';
	    self.value = 'DarkMode';
	}
}
</script>
  <input id="btnDisplayMode" class="btn" type="button" value="DarkMode" onclick="setDisplayAppreance(this);">
  
</body>
</html>