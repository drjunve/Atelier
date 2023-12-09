<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/global_head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function validateForm(form) {  
		if (form.profileo.value == "") {
			alert("프로필 사진을 선택해 주세요.");
			return false;
		}
	}
	
	function profileUse() {
	    self.close();
	    opener.window.location.reload();
	}
</script>
</head>
<body>
	
	<form name="fileForm" method="post" enctype="multipart/form-data" action="uploadProfile.do" onsubmit="return validateForm(this);">
		<img src="/uploads/${savedFileName }"/>
		<input type="file" name="profileo" accept="image/jpeg,image/png" value="${savedFileName }"/>
		<input type="submit" value="전송하기" />
	</form>
	<p>업로드 성공시</p>
	<p>저장된 파일명 : ${savedFileName }</p>>
	<p>저장된 파일<img src="/uploads/${savedFileName }"/></p>
	<button type="button" onClick="profileUse();">닫기</button>
	

</body>
</html>