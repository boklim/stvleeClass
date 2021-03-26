<!-- 
등록 화면
1. 입력 : 제목 / 내용
2. 버튼 : 취소 / 등록
3. 스타일 : 가운데 정렬
4. input / textarea

5. 저장내용 : 제목 / 내용 / 등록자 / 등록시간 / 세션아이디
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>writeBoardList.jsp</title>
</head>
<style>
table, td, tr, th {border:1px solid black;}
table {width:100%;}
th {width:30%;}
</style>
<body>
기존 세션 값 : <%=session.getId() %>
세션 아이디 값 : <%=session.getAttribute("loginSession") %>
<%  
	if(session.getAttribute("loginSession") == null) {
		//alert("해당 페이지의 접근 권한이 없습니다. 로그인 페이지로 이동합니다.");
		response.sendRedirect("loginMain.jsp");
	}
%>
	<table>
		<tr>
			<th>제목</th>
			<td><input id="title" type="text" style="width:98%; text-align:center;"></input></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea id="content" style="width:98%; height:100%; text-align:center;"></textarea></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="취소" onclick="cancel()">
				<input type="button" value="등록" onclick="submit()">
			</td>
		</tr>
	</table>
</body>

<script>
function cancel() {
	alert("cancel 실행");
	$("#title").val('');
	$("#content").val('');
}

function submit() {
	//저장내용 : 제목 / 내용 / 등록자 / 등록시간 / 세션아이디
	//! 여기서 또 뭘 보내야 하나 ?
	
	if(!$("#title").val()=='') {	
		alert("submit 실행");
		
		var param = {
			"title" : $("#title").val(),
			"content" :$("#content").val()
		}
		
		$.post("registBoard", param, function(res) {
			if(res.result == "ok") {
				alert("게시글 등록이 완료되었습니다.");
				location.href="boardList";
			}
		});
	}
}



</script>
</html>