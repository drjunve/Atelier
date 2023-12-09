<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="col border-bottom mt-3">
		<ul class="nav justify-content-center">
			<li class="nav-item"><a class="nav-link text-dark fw-bolder" href="/">ATELIER</a></li>
  			<li class="nav-item"><a class="nav-link text-dark" href="#">SHOP</a></li>
  			<li class="nav-item"><a class="nav-link text-dark" href="#">AUCTION</a></li>
  			<li class="nav-item"><a class="nav-link text-dark" href="#">FAQ</a></li>
  			<li class="nav-item"><a class="nav-link text-dark" href="#">COMPANY</a></li>
			
  			<li class="nav-item"><a class="nav-link text-dark" href="mypage">MYPAGE</a></li>

  			<li class="nav-item">
  				<a class="nav-link" href="#">
  				<img class="img-fluid header-cart nav-cart" src="/images/header/cart.png"></img>
  				</a>
  			</li>
  			<c:choose>
	 			<c:when test="${logSuc == '1'}">
	 				<li class="nav-item"><a class="nav-link text-danger fw-bolder" href="logout.do">LOGOUT</a></li>
	 			</c:when>
  				<c:otherwise>
  					<li class="nav-item"><a class="nav-link text-success fw-bolder" href="login">LOGIN</a></li>
  				</c:otherwise>
  			</c:choose>
		</ul>
	</div>
</body>
</html>