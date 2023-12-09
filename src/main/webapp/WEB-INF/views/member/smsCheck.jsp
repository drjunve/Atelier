<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- bootstrap5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 에이잭스 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
	//휴대전화 번호 사용하기
	function smsUse() {
		opener.document.myMotherform.phone.value = document.smsOverlapFrm.phone.value;
		$(opener.document).find("#phone").attr("class", "form-control is-valid");
		self.close();
	}
</script>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col" style="padding: 20px; text-align: center;">
				<form name="smsOverlapFrm" action="smsauth" method="post">
					<table class="table table-borderless">
						<td class="userVal">
							<!-- 인증문자 받는 사람 -->
							<input type="text" name="phone" value="${phone}" maxlength="30" class="form-control" placeholder="PHONE(숫자만입력 : 01012345678)" />
						</td>
						<td>
							<button type="submit" class="btn btn-outline-secondary">인증번호발송</button>
						</td>
					</table>
				</form>

				<form action="smscheck.do" method="post">
					<table class="table table-borderless">
						<tr>
							<td>
							<input type="hidden" name="phone" value="${phone}"/>
							<input type="hidden" name="smsContent" value="${smsContent}"/>
							<input type="text" class="form-control" name="userSmsContent" value="${userSmsContent}" placeholder="인증번호" />
							</td>
							<td><input type="submit" class="btn btn-outline-secondary" value="확인" /></td>
						</tr>
					</table>
					<c:choose>
					<c:when test="${smsAuthsuccess == '1' }">
					<div style="text-align:center;">
					<table class="table table-borderless">
					<tr>
						<td>
							<h6 style="color:blue;">인증완료</h6>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" onClick="smsUse();" value="휴대전화 사용하기" class="btn btn-outline-secondary" />
						</td>
					</tr>
					</table>
					</div>
					</c:when>
					<c:when test="${smsAuthsuccess == '-1' }">
					<div style="text-align:center;">
					<table class="table table-borderless">
					<tr>
						<td style="color:red";>
							<h6>인증번호를 발송해 주세요.</h6>
						</td>
					</tr>
					</table>
					</div>
					</c:when>
					<c:when test="${smsAuthsuccess == '0' }">
					<div style="text-align:center;">
					<table class="table table-borderless">
					<tr>
						<td style="color:red;">
							<h6>인증번호가 일치하지 않습니다.</h6>
						</td>
					</tr>
					</table>
					</div>
					</c:when>
					<c:when test="${smsAuthsuccess == '-2' }">
					<div style="text-align:center;">
					<table class="table table-borderless">
					<tr>
						<td style="color:red;">
							<h6>인증번호를 입력해 주세요.</h6>
						</td>
					</tr>
					</table>
					</div>
					</c:when>
					</c:choose>
				</form>
			</div>
		</div>
	</div>
</body>
</html>