<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("idKey");

	if (id == null){
	%>    
		<script>
			alert("�α��� ���� �ʾҽ��ϴ�.");
			location.href = "sessionLogin.jsp";
		</script>
	<%
		return;
	} //if�� ����
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
	<h2>�α���</h2>
	<table>
		<tr>
			<td><%= id %> ���� �α��� �ϼ̽��ϴ�.</td>
			<td><a href="sessionLogout.jsp">�α׾ƿ�</a></td>
		</tr>
	</table>
</body>
</html>