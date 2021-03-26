<!-- 
* 모든 데이터는 db를 통해 접근하고 등록
1. 입력값 : 이름, 생년월일, 이메일(아이디용), 비밀번호, 비밀번호 확인
2. 이메일로 인증 확인 메일 보내고 인증
3. 모든 입력값은 유효성 체크
	이름 : 한글만 입력
	생년월일 : 숫자만 + 6자리
	이메일 : 이메일 형식 체크
	비밀번호 : 숫자 + 영문 + 특수문자 조합 8자리 이상
-->
<!-- 모르는 부분 정리 
1. onKeyup : 사용자가 키보드의 키를 눌렀다가 뗐을 때
2. required : 폼 데이터(form data)가 서버로 제출되기 전 반드시 채워져 있어야 하는 입력 필드를 명시
3. maxlength : <input> 요소에 입력할 수 있는 최대 문자수를 명시
4. disabled : 속성이 명시된 <input> 요소는 사용할 수 없으며, 사용자가 클릭할 수도 없습니다.
	또한, 폼 데이터가 제출될 때도 disabled 속성이 명시된 <input> 요소의 데이터는 제출되지 않습니다.
	따라서 이 속성을 사용하면 특정 조건이 충족될 때까지 사용자가 입력 필드를 클릭할 수 없도록 설정하고, 
	특정 조건이 충족되면 자바스크립트 등으로 disabled 속성값을 삭제하여 사용자가 입력 필드를 다시 사용할 수 있도록 조절할 수 있다.
5. 정규표현식 jquery - $.test() 메서드
6. onblur : 작성 중인 input칸에서 이동할 경우
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join.jsp</title>
<style>
.pass {font-size:0.6em; color:blue;}
.fail {font-size:0.6em; color:red;}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<form onsubmit="return formChk()">
		이름<input id="name" name="name" type="text" required/><br/>
		
		생년월일<input id="birth" name="birth" type="number" maxlength="6" required/><br/>
		
		이메일<input id="email" name="email" type="email" required/><br/>
		<input type="button" value="인증메일 발송" onclick="sendAuthEmail()"/><br/>
		<input type="text" id="emailCode" name="emailCode" required disabled onblur="chkCode()"/><br/>
		<p id="chkResult"></p>
		비밀번호<input id="password" name="password" type="text" required/><br/>
		
		<input type="submit" value="제출">
	</form>
</body>
<script>
var code = '';

function formChk() {
	// 통합 유효성 검사 
	var nameChk = /^[가-힣]+$/;
	var birthChk = /^[0-9]/g;
	var emailChk = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
	var pwChk = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

	if($('#name').val() == "" || !nameChk.test($('#name').val())) {
		alert("한글만 입력 가능합니다.");
		$('#name').val('');
		$('#name').focus();
		return false;
	}
	
	if($('#birth').val() == "" || !birthChk.test($('#birth').val()) || $('#birth').val().length != 6) {
		alert("6자리 숫자만 입력 가능합니다.");
		$('#birth').val('');
		$('#birth').focus();
		return false;
	}
	
	if($('#email').val() == "" || !emailChk.test($('#email').val())) {
		alert("이메일 형식을 확인해주세요.");
		$('#email').val('');
		$('#email').focus();
		return false;
	}
	
	if($('#password').val() == "" || !pwChk.test($('#password').val() || $('#password').val().length < 8)) {
		alert("숫자, 영문, 특수문자 포함 8자리 이상 가능합니다.");
		$('#password').val('');
		$('#password').focus();
		return false;
	}
	
	if(!$('#chkResult').hasClass('pass')) {
		alert("인증번호를 확인해주세요.");
		return false;
	};
	
	var param = {
			"id" : $('#email').val()
		,	"pw" : $('#password').val()
		,	"name" : $('#name').val()
		,	"birth": $('#birth').val()
	}
	
	$.post("joinRegister", param, function(res) {
		console.log("res.result >>>" + res.result);
		if(res.result == "ok")	{
			alert("정상적으로 회원가입이 완료되었습니다. 로그인 화면으로 이동합니다.");
			location.href = "loginMain";
		}
	});

}

function sendAuthEmail() {
	if($('#email').val() != '') {
		var param = { 
			"email" : $('#email').val()
		}
		
		$.post("sendEmail", param, function(res) {
			$('#emailCode').removeAttr('disabled'); 
			code = res;
		});
	}
}

function chkCode() {
	var inpCode = $('#emailCode').val();
	
	if(inpCode == code) {
		$('#chkResult').attr('class','pass');
		$('#chkResult').html("인증번호가 일치합니다.");
	} else {
		$('#chkResult').attr('class','fail');
		$('#chkResult').html("인증번호를 다시 확인해주세요.");
	}
}

</script>

</html>