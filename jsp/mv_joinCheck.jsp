<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("EUC-KR");
	String user_id = request.getParameter("id"); //ȸ�����Խ� �Է��� ���̵�
	String user_pw = request.getParameter("pw"); //ȸ�����Խ� �Է��� ��й�ȣ


	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;

	String dbURL      ="jdbc:mysql://localhost:3306/moviesofa?"
							+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID       ="root";
	String dbPassword ="mySQL1234";		
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);


	mstmt= conn.prepareStatement("select id from user where id = '" + user_id +"'");
	rs = mstmt.executeQuery();
		
	//String check = ""; 
	//int    cnt   = 0;
		
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