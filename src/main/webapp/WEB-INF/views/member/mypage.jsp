<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 	div {
		border: red solid 1px;
	}
	span {
		border: blue solid 1px;
	} */
	.userIE {
		width: 26%;
	}
	.beforeD,
	.readyD,
	.onD,
	.finishD,
	.orderI {
		width: 13%;
	}
</style>
</head>
<body>

<div class="container-fluid">
	<!-- 헤더 -->
	<div class="row">
		<%@include file="../includes/header.jsp"%>
	</div>
	<!-- 상단 -->
	<div class="row pb-3" style="background-color: lightgray;">
		<div class="row mx-auto align-middle" style="width: 85%">
			<div>
				<p class="fw-bolder text-center align-middle">마이페이지</p>
			</div>
		</div>
		<div class="row mx-auto mt-0" style="width: 85%">
			<div class="row mx-auto">
				<span class="userIE p-1 mx-0 my-3 me-auto bg-white">
<c:choose>
<c:when test="${sessionScope.memberDTO.profiles != null }">
					<img src="/images/member/${profiles }" style="float: left; width:30%; vertical-align: top; "/>
</c:when>
<c:when test="${sessionScope.memberDTO.profiles == null }">
					<img src="/images/member/noprofile.png" style="float: left; width:30%; vertical-align: top; "/>
</c:when>
</c:choose>
					<p>${sessionScope.memberDTO.m_name}님 <button type="button" class="btn btn-outline-dark">정보수정</button></p>
					<p>총주문 : 원 ( 회)</p>
					<p>총 포인트 : ${sessionScope.memberDTO.total_point}p</p>
				</span>
				<span class="beforeD p-1 mx-auto my-3 bg-white text-start">
						<p>입금전 &gt;</p>
						<p>0</p>
				</span>
				<span class="readyD p-1 mx-auto my-3 bg-white text-start">
						<p>배송준비중 &gt;</p>
						<p>0</p>
				</span>
				<span class="onD p-1 mx-auto my-3 bg-white text-start">
						<p>배송중 &gt;</p>
						<p>0</p>
				</span>
				<span class="finishD p-1 mx-auto my-3 bg-white text-start">
						<p>배송완료 &gt;</p>
						<p>0</p>
				</span>
				<span class="orderI p-1 ms-auto my-3 me-0 bg-white text-start">
						<p>취소 : </p>
						<p>반품 : </p>
						<p>가용포인트 : ${sessionScope.memberDTO.total_point}p</p>
				</span>
			</div>
		</div>
	</div>
	<!-- 상세페이지 -->
	<div class="row">
		<div class="row mx-auto" style="width: 85%;"> 
			<!-- 레프트메뉴 -->
			<div class="col-2 mt-4">
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">장바구니</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">주문내역</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">입찰내역</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">포인트</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">내공간에찜</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">작가신청</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">정보수정</a></div>
			</div>
			<!-- 내용 -->
			<div class="col-10">
				<%@include file="../includes/update_member.jsp"%>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
	<div class="row">
		푸터<br/><br/><br/><br/><br/>
	</div>
</div>
</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 	div {
		border: red solid 1px;
	}
	span {
		border: blue solid 1px;
	} */
	.userIE {
		width: 26%;
	}
	.beforeD,
	.readyD,
	.onD,
	.finishD,
	.orderI {
		width: 13%;
	}
</style>
</head>
<body>

<div class="container-fluid">
	<!-- 헤더 -->
	<div class="row">
		<%@include file="../includes/header.jsp"%>
	</div>
	<!-- 상단 -->
	<div class="row pb-3" style="background-color: lightgray;">
		<div class="row mx-auto align-middle" style="width: 85%">
			<div>
				<p class="fw-bolder text-center align-middle">마이페이지</p>
			</div>
		</div>
		<div class="row mx-auto mt-0" style="width: 85%">
			<div class="row mx-auto">
				<span class="userIE p-1 mx-0 my-3 me-auto bg-white">
<c:choose>
<c:when test="${sessionScope.memberDTO.profiles != null }">
					<img src="/images/member/${profiles }" style="float: left; width:30%; vertical-align: top; "/>
</c:when>
<c:when test="${sessionScope.memberDTO.profiles == null }">
					<img src="/images/member/noprofile.png" style="float: left; width:30%; vertical-align: top; "/>
</c:when>
</c:choose>
					<p>${sessionScope.memberDTO.m_name}님 <button type="button" class="btn btn-outline-dark">정보수정</button></p>
					<p>총주문 : 원 ( 회)</p>
					<p>총 포인트 : ${sessionScope.memberDTO.total_point}p</p>
				</span>
				<span class="beforeD p-1 mx-auto my-3 bg-white text-start">
						<p>입금전 &gt;</p>
						<p>0</p>
				</span>
				<span class="readyD p-1 mx-auto my-3 bg-white text-start">
						<p>배송준비중 &gt;</p>
						<p>0</p>
				</span>
				<span class="onD p-1 mx-auto my-3 bg-white text-start">
						<p>배송중 &gt;</p>
						<p>0</p>
				</span>
				<span class="finishD p-1 mx-auto my-3 bg-white text-start">
						<p>배송완료 &gt;</p>
						<p>0</p>
				</span>
				<span class="orderI p-1 ms-auto my-3 me-0 bg-white text-start">
						<p>취소 : </p>
						<p>반품 : </p>
						<p>가용포인트 : ${sessionScope.memberDTO.total_point}p</p>
				</span>
			</div>
		</div>
	</div>
	<!-- 상세페이지 -->
	<div class="row">
		<div class="row mx-auto" style="width: 85%;"> 
			<!-- 레프트메뉴 -->
			<div class="col-2 mt-4">
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">장바구니</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">주문내역</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">입찰내역</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">포인트</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">내공간에찜</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">작가신청</a></div>
				<div class="border p-1 mypageLB"><a class="text-dark text-decoration-none" href="#">정보수정</a></div>
			</div>
			<!-- 내용 -->
			<div class="col-10">
				<%@include file="../includes/update_member.jsp"%>
			</div>
		</div>
	</div>
	<!-- 푸터 -->
	<div class="row">
		푸터<br/><br/><br/><br/><br/>
	</div>
</div>
</body>
>>>>>>> branch 'main' of https://github.com/drjunve/Atelier.git
</html>