<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import= "java.util.regex.Pattern" %>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("EUC-KR");
	String user_id = request.getParameter("id"); //회원가입시 입력한 아이디
	String user_pw = request.getParameter("pw"); //회원가입시 입력한 비밀번호
	
	//user_id = user_id.trim();

	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;

	String dbURL      ="jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID       ="root";
	String dbPassword ="mySQL1234";		
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);


	mstmt= conn.prepareStatement("select id from user where id = '" + user_id +"'");
	rs = mstmt.executeQuery();
		

	
	if(Pattern.matches("^[a-zA-Z0-9]*$", user_id) == false){
			//숫자랑 영어만 들어있지 않은경우
			out.print("result4");
			
	}else if("".equals(user_id)){
			//아이디 값이 비어있는 경우
			out.print("result1");
			
	}else if(rs.next() == true){
			//아이디 있음
			out.print("result2");
			
	}else if(rs.next() == false){
		   //아이디없음
		   out.print("result3");

	}
	
    
    

	rs.close();
	mstmt.close();
	conn.close();
	
%>