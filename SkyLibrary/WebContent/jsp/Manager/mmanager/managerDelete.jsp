<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %> 
<%
	String manager_id = request.getParameter("id"); //입력한 사서 아이디
	String manager_pw = request.getParameter("pw"); //입력한 사서 비밀번호
	String manager_name = request.getParameter("name"); //입력한 사서 이름
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;
	
	String dbURL="jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID="root";
	String dbPassword="mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

	String sql = "";
	
	
	
	
	sql  = "delete ";
	sql += "from manager ";
	sql += "where mid='" + manager_id +"'";
	
	mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	mstmt.executeUpdate();
	
	mstmt.close();
	conn.close();
%>
<script>
	alert("삭제가 완료되었습니다.");
	window.location.href = "manager.jsp";
</script>    