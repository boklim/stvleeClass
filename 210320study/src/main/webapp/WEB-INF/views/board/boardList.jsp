<!-- 
리스트 화면
1. 화면노출값 : 게시글번호 / 제목 / 작성자 / 등록시간
2. 버튼 : 게시글 등록 (화면 오른쪽 위 / 로그인시에만 노출)
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>boardList.jsp</title>
</head>
<style>
table, td, tr, th {border:1px solid black;}
table, div {width:100%;}
button {width:100px; height:30px; background-color:pink; float:right; }
.boardNum {text-align:center;}
#info {font-size:0.6em;}
</style>
<body>
	<div id="info">
	기존 세션 값 : <%=session.getId() %> <br>
	세션 아이디 값 : <%=session.getAttribute("loginSession") %> <br>
	세션 결과 : <%=session.getAttribute("result") %> <br>
	</div>

	<div>
		<c:if test="${not empty sessionScope.result}">
			<button id="writeBtn" onclick="clickWrite()">글쓰기</button>
		</c:if>
	</div>	
	<table>
		<tr>
			<th>게시글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록시간</th>
		</tr>
		<c:forEach var="item" items="${list}" varStatus="status">
			<tr>	
				<td class="boardNum"><c:out value="${status.count}" /></td>
				<td class="boardTit"><c:out value="${item.title}" /></td>	
				<td class="boardWriter"><c:out value="${item.writer}" /></td>	
				<td class="boardCreTime"><c:out value="${item.createTime}" /></td>	
			</tr>
		</c:forEach>
	</table>
	

</body>
<script>
// 글쓰기 : ! 로그인시에만 노출
$(function()  {
	
})



function clickWrite() {
	alert("clickWrite");
	
	location.href="writeBoard";
}


</script>
</html>