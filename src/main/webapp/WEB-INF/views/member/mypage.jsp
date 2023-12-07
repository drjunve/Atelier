<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div class="container-fluid">
	<!-- 헤더 -->
	<div class="row">
		<%@include file="../includes/header.jsp"%>
	</div>
	<!-- 상단 -->
	<div class="row mainPT">
		<%@include file="../includes/mypage_top.jsp"%>
	</div>
	<!-- 상세페이지 -->
	<div>
		<!-- 레프트메뉴 -->
		<div class="mainpage">
			<%@include file="../includes/mypage_leftmenu.jsp"%><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		</div>
		<!-- 내용 -->
		<div class="col-9">
			내용<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
		</div>
	</div>
	<!-- 푸터 -->
	<div class="row">
		푸터<br/><br/><br/><br/><br/>
	</div>
</div>
</body>
</html>