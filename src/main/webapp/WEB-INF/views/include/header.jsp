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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
    <meta charset="UTF-8">
    <title>header</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary navbar-custom" style="background-color: #e3f2fd !important;">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="/home" class="nav-link active" aria-current="page">Home</a>
                    </li>
                    <li class="nav-item">
                        <a href="/searchUser" class="nav-link active" aria-current="page">Search</a>
                    </li>
                    <li class="nav-item">
                        <a href="/championImages" class="nav-link">Champ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/board/boardMain">Board</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                    </li>
                </ul>
                
                <div class="header_menu ms-auto">
				    <c:choose>
				        <c:when test="${not empty memberInfo}"> <!-- 로그인 상태일 때 -->
				            <a href="#"><button>마이페이지</button></a>
				            <a href="/member/logout"><button>로그아웃</button></a>
				        </c:when>
				        <c:otherwise> <!-- 로그인 상태가 아닐 때 -->
				            <a href="/member/sign"><button>회원가입</button></a>
				            <a href="/member/login"><button>로그인</button></a>
				        </c:otherwise>
				    </c:choose>
				</div>
            </div>
        </div>
    </nav>
</body>
</html>