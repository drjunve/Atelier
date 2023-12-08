<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- main css -->
<link href="/css/main.css?v=1.0" rel="stylesheet" type="text/css" />

<script>
//로그인 성공(로그인 실패시 메인페이지로 오지 않고 로그인 페이지에 머물게됨. 로그인 후 첫번째 메인페이지 방문시에만 출력됨.)
<c:if test="${logSucAlert == '1'}">
	window.onload = function() {
			alert("${sessionScope.memberDTO.m_name}님, 로그인에 성공했습니다. 환영합니다.");
	}
</c:if>
</script>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@include file="./includes/header.jsp"%>
		</div>
		<div class="row">
			<div class="col text-center p-3">
				<p class="fs-1">메인내용</p>
				<!-- 로그인 후 session에 memberDTO 저장 여부 확인용 -->
<c:if test="${logSuc == '1'}">
				<p class="lead text-warning">${sessionScope.memberDTO.m_name} 로그인됨<p>
</c:if>
			</div>
		</div>
	</div>

</body>

</html>