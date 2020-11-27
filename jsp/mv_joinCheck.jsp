<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("EUC-KR");
	String user_id = request.getParameter("id"); //회원가입시 입력한 아이디
	String user_pw = request.getParameter("pw"); //회원가입시 입력한 비밀번호


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
			//아이디 있음
			out.print("TRUE");
			
	}else{
		   //아이디없음
		   out.print("FALSE");
	}

	mstmt.close();
	conn.close();
	
%>