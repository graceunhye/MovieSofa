<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%
	request.setCharacterEncoding("EUC-KR");
	String manager_id = request.getParameter("id"); //�Է��� �缭 ���̵�
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;
	
	String dbURL="jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID="root";
	String dbPassword="mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

	mstmt= conn.prepareStatement("select mid from manager where mid = '" + manager_id +"'");
	rs = mstmt.executeQuery();
		
	if(rs.next() == true)
	{
			//���̵� ����
			out.print("TRUE");
			
	}else{
		   //���̵����
		   out.print("FALSE");
	}

	mstmt.close();
	conn.close();
	
%>