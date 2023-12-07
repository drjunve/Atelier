<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
/* 	div {
		border: 1px black solid;
	} */
	td,tr,table {
		border: 1px solid black;
	}
	.mainPT {
		height: 100%;
		background-color: lightpink;
	}
	.mainPTC {
		width: 90%;
	}
	.topD {
		height: 100%;
	}
	.userI {
		width: 26%;
		height: 100%;
		vertical-align: top;
		display: inline-block;
	}
	.userIE {
		width: 35%;
		vertical-align: top;
		display: inline-block;
	}
	.userIT {
		width: 60%;
		display: inline-block;
	}
	.beforeD,
	.readyD,
	.onD,
	.finishD,
	.orderI {
		width: 13%;
		vertical-align: top;
		display: inline-block;
	}
</style>

<body>
	<div class="col mainPT">
		<div class="col mainPTC d-grid mx-auto">
		<div class="row">
			<p class="fw-bolder p-3 text-center">마이페이지</p>
		</div>
		<div class="text-center topD">
			<div class="userI">
				<div class="p-1 bg-white">
					<div class="userIE">
						이미지
					</div>
					<div class="userIT text-start">
						<p>${sessionScope.memberDTO.m_name}님 <button type="button" class="btn btn-outline-dark">정보수정</button></p>
						<p>총주문 : 원 ( 회)</p>
						<p>총 포인트 : p</p>
					</div>
				</div>
			</div>
			<div class="beforeD">
				<div class="p-1 bg-white text-start">
					<p>입금전 &gt;</p>
					<p>0</p>
				</div>
			</div>
			<div class="readyD">
				<div class="p-1 bg-white text-start">
					<p>배송준비중 &gt;</p>
					<p>0</p>
				</div>
			</div>
			<div class="onD">
				<div class="p-1 bg-white text-start">
					<p>배송중 &gt;</p>
					<p>0</p>
				</div>
			</div>
			<div class="finishD">
				<div class="p-1 bg-white text-start">
					<p>배송완료 &gt;</p>
					<p>0</p>
				</div>
			</div>
			<div class="orderI">
				<div class="p-1 bg-white text-start">
					<p>취소 : </p>
					<p>반품 : </p>
					<p>가용포인트 : p</p>
				</div>
			</div>
			<%-- <div class="d-grid col-11 mx-5">
				<table>
					<colgroup>
						<col width=28%>
						<col width=14%>
						<col width=14%>
						<col width=14%>
						<col width=14%>
						<col width=14%>
					</colgroup>
					<tr>
						<td>
							<div class="row">
								<div class="col-3">
									이미지
								</div>
								<div class="col-7">
									${sessionScope.memberDTO.m_name}님<button type="button" class="btn btn-outline-dark">정보수정</button><br/>
									총 주문 : 원 ( 회)<br/>
									총 포인트 : p
								</div>
							</div>
						</td>
						<td>입금전</td>
						<td>배송준비중</td>
						<td>배송중</td>
						<td>배송완료</td>
						<td>취소 : <br/>반품 : <br>가용포인트 : </td>
					</tr>
				</table>
			</div> --%>		
		</div>
		</div>
	</div>
</body>
</html>