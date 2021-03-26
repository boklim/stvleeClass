<!-- 
* 모든 데이터는 db를 통해 접근하고 등록
1. 로그인 성공 문구

-->
<!-- 모르는 부분 정리 
1. 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>S
<html>
<head>
<meta charset="UTF-8">
<title>main.jsp</title>
</head>
<body>
기존 세션 값 : <%=session.getId() %>
세션 아이디 값 : <%=session.getAttribute("loginSession") %>
<%  
	if(session.getAttribute("loginSession") == null) {
		response.sendRedirect("loginMain");
	}
%>
안녕하세요. 스티브리자바 게시판에 오신걸 환영합니다.
</body>
</html>