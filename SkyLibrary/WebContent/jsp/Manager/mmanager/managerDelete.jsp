<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %> 
<%
	String manager_id = request.getParameter("id"); //�Է��� �缭 ���̵�
	String manager_pw = request.getParameter("pw"); //�Է��� �缭 ��й�ȣ
	String manager_name = request.getParameter("name"); //�Է��� �缭 �̸�
	
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
	alert("������ �Ϸ�Ǿ����ϴ�.");
	window.location.href = "manager.jsp";
</script>    