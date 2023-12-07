<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>

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
	//아이디 사용하기
	function idUse(){
	    opener.document.myMotherform.id.value = document.overlapFrm.id.value;
	    $(opener.document).find("#id").attr("class", "form-control is-valid");
	    self.close();
	}
	// 실시간 id 중복검사
	$(function() {
		$("#id").keyup(function(){
			$("#idButton").attr("disabled", true);
			console.log("입력받음"+$("#id").val());
			var id = $("#id").val()
			var email_RegExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
			if (email_RegExp.test(id)==false) {
				$('#id').attr("class","form-control is-invalid");
				$('#emailRegIn').text("이메일 형식에 맞지 않습니다.");
			}
			$.ajax({
				type: "POST",
				url: "emailOverlap",
				data: {
					id : id
				},
				dataType: 'json',
				success: function (data) {
					console.log("성공 data : "+data);
					$("#idButton").attr("disabled", false);
					if(data == 1) {
						$('#id').attr("class","form-control is-invalid");
						$("#idButton").attr("disabled", true);
						$('#emailRegIn').text("이미 존재하는 아이디입니다.");
					}
					else if (data != 1 && email_RegExp.test(id) == true){
						$('#id').attr("class","form-control is-valid");
						$("#idButton").attr("disabled", false);
					}
				}
			})
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col" style="padding: 30px; text-align: center;">
				<form name="overlapFrm" action="emailSendProcess.do" method="post" novalidate>
				<table class="table table-borderless">
					<tr>
						<td class="userVal">
							<!-- 인증메일 보내는 사람 -->
							<input type="hidden" name="from" />
							<!-- 인증메일 제목 -->
							<input type="hidden" name="subject" value="atelier 회원가입 인증번호 입니다." />
							<!-- 인증메일의 형식 -->
							<input type="hidden" name="format" value="Text" />
							<!-- 인증메일의 내용 -->
							<input type="hidden" name="content" value="">
							<!-- 인증메일 받는 사람 -->
							<input type="text" name="id" id="id" value="${id}" maxlength="30" class="form-control" placeholder="EMAIL" />
							<div class="valid-feedback">사용 가능한 아이디 입니다.</div>
							<div class="invalid-feedback" id="emailRegIn">이미 존재하는 아이디입니다.</div>
						</td>
						<td>
							<button id="idButton" type="submit" class="btn btn-outline-secondary" disabled>인증번호발송</button>
						</td>
					</tr>
				</table>
				</form>

				<form action="check.do" method="post" novalidate>
					<table class="table table-borderless">
					<tr>
						<td>
							<input type="hidden" name="id" value="${id}"/>
							<input type="hidden" name="content" value="${content}"/>
							<input type="text" class="form-control" name="userContent" value="${userContent}" placeholder="인증번호" />
							
						</td>
						<td><input type="submit" class="btn btn-outline-secondary" value="확인" /></td>
					</tr>
					</table>
					<c:choose>
						<c:when test="${authsuccess == '1' }">
							<div style="text-align:center;">
							<table class="table table-borderless">
							<tr>
								<td>
									<h6 style="color:blue;">인증완료</h6>
								</td>
							</tr>
							<tr>
								<td>
									<input type="button" onClick="idUse();" value="이메일 사용하기" class="btn btn-outline-secondary" />
								</td>
							</tr>
							</table>
							</div>
						</c:when>
						<c:when test="${authsuccess == '-1' }">
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
						<c:when test="${authsuccess == '-2' }">
							<div style="text-align:center;">
							<table class="table table-borderless">
							<tr>
								<td style="color:red";>
									<h6>인증번호를 입력해 주세요.</h6>
								</td>
							</tr>
							</table>
							</div>
						</c:when>
						<c:when test="${authsuccess == '0' }">
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
					</c:choose>

				</form>
			</div>
		</div>
	</div>
</body>
</html>