<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
	<header>
		<div class ="header_menu">
			<a href="/member/login"><button>로그인</button></a>
			<a href="/member/sign"><button>회원가입</button></a>
		</div>
		<nav class="navbar navbar-expand-lg bg-body-tertiary"
			style="background-color: #e3f2fd !important;">
			<div class="container-fluid">
				<a class="navbar-brand" href="#">LoL Search</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item">
							<form action="/searchUser" method="get">
								<a href="/searchUser" class="nav-link active"
									aria-current="page">Home</a>
							</form>
						</li>
						<li class="nav-item">
							<form action="/championImages" method="get">
								<a href="/championImages" class="nav-link">Champ</a>
							</form>
						</li>
						<li class="nav-item"><a class="nav-link"
							href="/board/boardMain">Board</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true">Disabled</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
</body>
</html>