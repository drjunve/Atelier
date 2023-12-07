// 다음 주소 찾기 api
function postOpen() {
	new daum.Postcode({
		oncomplete : function(data) {
			console.log(data);
			console.log(data.zonecode);
			console.log(data.address);

			let frm = document.myMotherform;
			frm.zip.value = data.zonecode;
			frm.addr1.value = data.address;
			frm.addr2.focus();
		}
	}).open();
}

// 회원가입 버튼 클릭
function formValidate(frm) {
	//이메일에 입력 확인 
	if (frm.id.value == '') {
		alert("이메일을 인증해주세요.");
		return false;
	}

	// 비밀번호 정규식 검증
	var newPassword = document.getElementById('newPassword').value;
	var pass = document.getElementById('pass').value;
	var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
	if (passwordRegex.test(newPassword)) {
		if (newPassword != pass) {
			alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
			//입력상자로 포커싱 한다. 
			document.getElementById('newPassword').focus();
			return false;
		}
	} else {
		alert("비밀번호는 최소 8자에서 16자까지, 영문자, 숫자 및 특수 문자를 포함해야 합니다.");
		//입력상자로 포커싱 한다. 
		document.getElementById('newPassword').focus();
		return false;
	}

	//이름 입력 확인
	if (document.myMotherform.name.value == '') {
		alert('이름을 입력해 주세요');
		return false;
	}

	// 휴대전화 입력 확인
	if (frm.phone.value == '') {
		alert("휴대전화를 인증해주세요.");
		return false;
	}

	// 주소 입력 확인
	if (frm.zip.value == '') {
		alert("주소를 입력해 주세요.");
		return false;
	}

	if (frm.addr1.value == '') {
		alert("주소를 입력해 주세요.");
		return false;
	}

	if (frm.addr2.value == '') {
		alert("상세주소를 입력해 주세요.");
		return false;
	}

	if (frm.agreeCheck.checked == false) {
		alert("이용약관과 개인정보취급방침에 동의해주세요.");
		return false;
	}

	
	return "regist";

}

//아이디 중복확인 
function idCheck(fn) {
	if (fn.id.value == '') {
		alert("아이디를 입력후 중복확인 해주세요.");
		fn.id.focus();
	} else {
		//아이디 중복확인 창을 띄울때 입력한 아이디를 쿼리스트링으로 
		//넘겨준다. 
		window.open('RegiIdOverlap?id=' + fn.id.value, 'idOver',
			'width=400,height=200');
		//입력한 아이디를 수정할 수 없도록 속성을 추가한다. 
		fn.id.readOnly = true;
	}
}

//이메일 인증
function emailCheck() {

	var popupWidth = 600;
	var popupHeight = 320;

	var popupX = Math.round(window.screenX + (window.outerWidth / 2) - (popupWidth / 2));
	var popupY = Math.round(window.screenY + (window.outerHeight / 2) - (popupHeight / 2));

	window.open('emailCheck', 'emailOver', 'width=' + popupWidth + ', height=' + popupHeight + ', left=' + popupX + ', top=' + popupY);
}

//휴대전화 인증
function smsCheck() {

	var popupWidth = 600;
	var popupHeight = 320;

	var popupX = Math.round(window.screenX + (window.outerWidth / 2) - (popupWidth / 2));
	var popupY = Math.round(window.screenY + (window.outerHeight / 2) - (popupHeight / 2));

	window.open('smsCheck', 'emailOver', 'width=' + popupWidth + ', height=' + popupHeight + ', left=' + popupX + ', top=' + popupY);
}

// 실시간 유효성 검증
$(function () {
	
	// 비밀번호 정규식 검증
	$("#newPassword").keyup(function() {
		var newPassword = document.getElementById('newPassword').value;
		var pass = document.getElementById('pass').value;
		var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,16}$/;
		if (passwordRegex.test(newPassword)) {
			$("#newPassword").attr("class", "form-control is-valid");
			$("#pass").attr("disabled", false);
		} else {
			$("#newPassword").attr("class", "form-control is-invalid");
			$("#pass").attr("disabled", true);
			$("#pass").attr("class", "form-control");
		}
	});
	
	//비밀번호 일치 검증
	$('input[id=pass]').keyup(function () {
        if ($("#pass").val()!=$("input[id=newPassword]").val()) {
			//$("#newPassword").attr("class", "form-control is-invalid");
			$("#pass").attr("class", "form-control is-invalid");
        }else {
			//$("#newPassword").attr("class", "form-control is-valid");
			$("#pass").attr("class", "form-control is-valid");
		}
    });
    
    // 이름 유효성 검사
    $('#m_name').keyup(function() {
    	var n_RegExp = /^[가-힣a-zA-Z]{2,15}$/;
    	var m_name = $('#m_name').val(); 
		if (n_RegExp.test(m_name)) {
			$("#m_name").attr("class", "form-control is-valid");
		} else {
			$("#m_name").attr("class", "form-control is-invalid");
		}
		
		/*
		이름을 모두 지울경우 vaildation 표시 제거
		else if ($("input[name='name']").value=="") {
			$("input[name='name']").attr("class", "form-control");
		} 
		 */
		
	})
	
	// 약관 동의 체크 확인
	$("#agreeCheck").click(function() {
		if ($("#agreeCheck").is(":checked")==true) {
			$("#agreeCheck").attr("class", "form-check-input is-valid");
		} else {
			$("#agreeCheck").attr("class", "form-check-input is-invalid");
		}
	})
	
	/*
	// 일반회원-작가회원 버튼 클릭시
	$("#loginBtn").click(function() {
		$("#registBtn").attr("class", "btn btn-outline-danger")
		$("#loginBtn").attr("class", "btn btn-outline-danger active")
	})
	$("#registBtn").click(function() {
		$("#loginBtn").attr("class", "btn btn-outline-danger")
		$("#registBtn").attr("class", "btn btn-outline-danger active")
	})
	*/
	
});












