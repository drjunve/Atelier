<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
function uploadProfile() {
	var popupWidth = 600;
	var popupHeight = 320;

	var popupX = Math.round(window.screenX + (window.outerWidth / 2) - (popupWidth / 2));
	var popupY = Math.round(window.screenY + (window.outerHeight / 2) - (popupHeight / 2));

	window.open('uploadProfile', 'upload', 'width=' + popupWidth + ', height=' + popupHeight + ', left=' + popupX + ', top=' + popupY);
}
</script>

<p> 정보수정</p>
<div class="col" style="width: 80%;">
<c:choose>
<c:when test="${sessionScope.memberDTO.profiles != null }">
					<img src="/images/member/${profiles }" class="me-4" style="float: left; width:20%; vertical-align: top; "/>
</c:when>
<c:when test="${sessionScope.memberDTO.profiles == null }">
					<img src="/images/member/noprofile.png" class="me-4" style="float: left; width:20%; vertical-align: top; "/>
</c:when>
</c:choose>
	<p>id: ${sessionScope.memberDTO.id}</p>
	<button type="button" class="btn btn-outline-secondary" onClick="uploadProfile()">이미지 변경</button>
	<button type="button" class="btn btn-outline-secondary">삭제</button>
	<p>가입일: ${sessionScope.memberDTO.regidate}
</div>
<form name="updateForm" action="updateMember" method="post" novalidate>
	<table class="table table-borderless" style="width: 80%;">
		<colgroup>
			<col width=25%>
			<col width=65%>
			<col width=10%>
		</colgroup>
		<tr>
			<td>비밀번호(6자 이상)</td>
			<td colspan="2"><input type="password" class="form-control" name="pass" id="pass"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인(6자 이상)</td>
			<td colspan="2"><input type="password" class="form-control" name="passCheck" id="passCheck"/></td>
		</tr>
		<tr>
			<td>회원명</td>
			<td colspan="2"><input type="text" class="form-control" name="m_name" id="m_name" value="${sessionScope.memberDTO.m_name }"/></td>
		</tr>
		<tr>
			<td>PHONE</td>
			<td colspan="2"><input type="text" class="form-control" name="phone" id="phone" value="${sessionScope.memberDTO.phone }"/></td>
		</tr>
		<tr>
			<td>기본배송지</td>
			<td>
				<input type="text" class="form-control" name="m_name" id="m_name" value="${sessionScope.memberDTO.zip }"/>
				<input type="text" class="form-control" name="m_name" id="m_name" value="${sessionScope.memberDTO.addr1 }"/>
				<input type="text" class="form-control" name="m_name" id="m_name" value="${sessionScope.memberDTO.addr2 }"/>
			</td>
			<td><button type="button" class="btn btn-outline-danger">검색</button></td>
		</tr>
		<tr>
			<td colspan="3" class="text-center">
				<button type="button" class="btn btn-dark mx-auto" style="width: 45%;">회원탈퇴</button>
				<button type="submit" class="btn btn-danger mx-auto" style="width: 45%;">회원정보 변경</button>
			</td>
		</tr>
	</table>
</form>