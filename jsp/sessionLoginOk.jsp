<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("idKey");

	if (id == null){
	%>    
		<script>
			alert("로그인 되지 않았습니다.");
			location.href = "sessionLogin.jsp";
		</script>
	<%
		return;
	} //if문 종료
%>	
<!DOCTYPE html>
<html>
<head>S
<meta charset="EUC-KR">
<title>Insert title here</title>
	<!-- script -->
	<script src="../js/jquery-3.5.1.min.js"></script>
	<script src="../js/mv_login.js"></script>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="../css/mv_login.css">
</head>
<body>
	<h2>로그인</h2>
	<table>
		<tr>
			<td><%= id %> 님이 로그인 하셨습니다.</td>
			<td><a href="sessionLogout.jsp">로그아웃</a></td>
		</tr>
	</table>
</body>
</html>