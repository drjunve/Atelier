<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
$(function () {
	//인증번호 발송 버튼 클릭시
	$("#findPassNumBtn").click(function(){
		$.ajax({
			type: "POST",
			url: "findPassEmailSendProcess",
			data: {
				id : $("#findPassId").val(),
				findPassSubject : $("#findPassSubject").val(),
			},
			dataType: 'json',
			
			success: function(findPassMap) {
				if(findPassMap.findPassIdSuc == "0") {
					$("#findPassId").attr("class", "form-control is-invalid");
				} else if(findPassMap.findPassIdSuc == "1") {
					console.log("아이디 조회 성공 data : "+findPassMap);
					$("#findPassId").attr("class", "form-control is-valid");
					$("#findPassId").attr("readonly", true);
				}
			}
		})
	})
	//확인 버튼 클릭시
	$("#infdPassCheckBtn").click(function(){
		$.ajax({
			type: "POST",
			url: "findPassCheck",
			data: {
				id : $("#findPassId").val(),
				FindPassNum : $("#userFindPassNum").val(),
			},
			dataType: 'json',
			success: function(findPassCheckMap) {
				console.log("비교성공. checkSuc : "+findPassCheckMap.findPassCheckSuc);
				if(findPassCheckMap.findPassCheckSuc == "0") {
					$("#passNumInvalidFeedback").text("인증번호가 일치하지 않습니다.");
					$("#userFindPassNum").attr("class", "form-control is-invalid");
				} else if(findPassCheckMap.findPassCheckSuc == "1") {
					console.log("인증 data : "+findPassCheckMap);
					$("#findPassPass").attr("class", "text-center");
					$("#findPassLogBtn").attr("class", "text-center");
					$("#userFindPassNum").attr("readonly", true);
					$("#userFindPassNum").attr("class", "form-control is-valid");
					$('#suc1').attr('class', 'text-center text-primary');
					$('#idAndPass').html(
								findPassCheckMap.m_name+"님의 비밀번호는 <br/>"+findPassCheckMap.pass+"<br/>입니다."
							);
				} else if(findPassCheckMap.findPassCheckSuc == "-1"){
					$("#userFindPassNum").attr("class", "form-control is-invalid");
					$("#passNumInvalidFeedback").text("인증번호를 발송해주세요.");
				} else if(findPassCheckMap.findPassCheckSuc == "-2"){
					$("#userFindPassNum").attr("class", "form-control is-invalid");
					$("#passNumInvalidFeedback").text("인증번호를 입력해주세요.");
				} else if(findPassCheckMap.findPassCheckSuc == "-3"){
					$("#userFindPassNum").attr("class", "form-control is-invalid");
					$("#passNumInvalidFeedback").text("인증번호가 일치하지 않습니다.");
				}
			}
		})
	})
	
})
/* 참고용
<tr id="suc1" class="text-center text-primary d-none"> */
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<%@include file="../includes/header.jsp"%>
		</div>
		<div class="row">
				<div class="d-grid col-10 mt-4 p-1 mx-auto">
					<p class="fw-bolder p-2 mx-auto" id="findPassTitle">비밀번호 찾기</p>
					<p class="mx-auto">가입시 등록하신 이메일을 입력해 주세요.</p>
					<!-- <p class="mx-auto">이메일로 비밀번호 재설정 링크가 발송됩니다.</p> -->
				</div>
				<!-- form태그 필요 없을 듯. 최종 작성후 끝까지 필요 없으면 삭제할 것 -->
				<div class="d-grid col-10 gap-2 mx-auto">
				<form action="" type="POST">
					<table class="table table-borderless" novalidate>
						<colgroup>
							<col width=70%>
							<col width=30%>
						</colgroup>
						<tr>
							<td class="d-none"><input type="hidden" id="findPassSubject" value="atelier 비밀번호 찾기 인증번호 입니다." /></td>
							<td><input type="email" class="form-control" name="findPassId" id="findPassId" placeholder="EMAIL">
							<div class="valid-feedback">인증번호가 발송되었습니다.</div><div class="invalid-feedback">가입된 아이디가 없습니다.</div></td>
							<td><button type="button" id="findPassNumBtn" class="btn btn-outline-danger">인증번호 발송</button></td>
						</tr>
						<tr>
							<td><input type="text" id="userFindPassNum" class="form-control" placeholder="수신이메일 내 인증번호를 입력하세요.">
							<div id="passNumInvalidFeedback" class="invalid-feedback">인증번호가 일치하지 않습니다.</div></td>
							<td><button type="button" id="infdPassCheckBtn" class="btn btn-outline-danger">인증번호 확인</button></td>
						</tr>
						<tr id="findPassPass" class="d-none text-center">
							<td colspan="2" id="idAndPass"></td>
						</tr>
						<tr id="findPassLogBtn" class="d-none text-center">
							<td colspan="2"><button type="button" id="findPassLogBtn" class="btn btn-outline-danger" onClick="location.href='login'">로그인 하기</button></td>
						</tr>
					</table>
				</form>
				</div>
			</div>
		</div>
</body>
</html>