<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>ȸ������</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- script -->
		<script src="../js/jquery-3.5.1.min.js"></script>

	</head>
	<!-- head end -->

<%
try{
	request.setCharacterEncoding("EUC-KR");
	String user_id = request.getParameter("id"); //ȸ�����Խ� �Է��� ���̵�
	String user_pw = request.getParameter("pw"); //ȸ�����Խ� �Է��� ��й�ȣ
	String id = null;
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;


	String dbURL="jdbc:mysql://localhost:3306/moviesofa?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID="root";
	String dbPassword="mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);


	String sql = "";
	sql += "insert into user ";
	sql += "(id, pw) ";
	sql += "values ";
	sql += "(?, ?) ";

	mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	mstmt.setString(1,user_id);
	mstmt.setString(2,user_pw);
	mstmt.executeUpdate();

	mstmt.close();
	conn.close();

%> 
<script>
	alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
	window.location = "sessionLogin.jsp";
</script>				
<%
}catch(Exception e) {
%>
<script>
	alert("ȸ�����Կ� �����Ͽ����ϴ�. �ٽ� �õ����ּ���.");
	window.location = "mv_join.jsp";
</script>
<%
}	
%>
