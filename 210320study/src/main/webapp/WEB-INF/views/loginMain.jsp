<!-- 
* 모든 데이터는 db를 통해 접근하고 등록
1. id, pw 입력받고 로그인처리
2. 회원가입 버튼
-->
<!-- 모르는 부분 정리 
1. form의 형태...어떻게 보내지게 되는가, button은 어디에 위치하는 가
- method
- action 

---Form 태그, 아래 두 속성을 추가!
  method: HTTP 방식을 설정(GET/POST/...)
  action: 데이터를 보낼 url 주소지

2. jstl 사용법
3. button 사용법 ? button말고 input을 사용하는가..
4. db값과 어떻게 확인할 것인가..
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>loginMain.jsp</title>
</head>
<body>
	<table style="margin:100px auto; border:solid 1px gray; padding:40px;">
		<tr>
			<td>아이디</td>
			<td><input id="id" type="text"></td>
		</tr>	
		<tr>
			<td>패스워드</td>
			<td><input id="pw" type="password"></td>
		</tr>
		<tr>
			<td><button id="join" type="button">회원가입</button></td>
			<td><button type="button" onclick="fn_loginAction()">로그인</button></td>
		</tr>	
	</table>
<script>
function fn_loginAction() {
	var param = {
			"id" : $('#id').val(),
			"pw" : $('#pw').val()
	}
	
	$.post("loginTry", param, function(res) {
		console.log("res.result >>>" + res.result);
		fn_loginCallAction(res);
	});
}

function fn_loginCallAction(res) {
	console.log("res.result>>>>>" + res.result);
	switch (res.result) {
	case "error":
		alert("회원정보가 없습니다. 회원가입을 하고 로그인 하시기 바랍니다.");
		break;
	case "pwError":
		alert("아이디 또는 비밀번호가 다릅니다. 확인하시고 재로그인 하시기 바랍니다.");
		break;
	case "ok":
		location.href = "main";
		break;
	}
}

$('#join').on("click", function() {
	location.href = 'join';
});
</script>
</html>