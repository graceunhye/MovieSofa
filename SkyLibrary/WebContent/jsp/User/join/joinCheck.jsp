<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import= "java.util.regex.Pattern" %>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("EUC-KR");
	String user_id = request.getParameter("id"); //ȸ�����Խ� �Է��� ���̵�
	String user_pw = request.getParameter("pw"); //ȸ�����Խ� �Է��� ��й�ȣ
	
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
			//���ڶ� ��� ������� �������
			out.print("result4");
			
	}else if("".equals(user_id)){
			//���̵� ���� ����ִ� ���
			out.print("result1");
			
	}else if(rs.next() == true){
			//���̵� ����
			out.print("result2");
			
	}else if(rs.next() == false){
		   //���̵����
		   out.print("result3");

	}
	
    
    

	rs.close();
	mstmt.close();
	conn.close();
	
%>