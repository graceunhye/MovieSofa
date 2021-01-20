<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%

	request.setCharacterEncoding("EUC-KR");
	String SelectedIds = request.getParameter("SelectedIds");

	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
	
	String sql = "delete from user where id='"+SelectedIds+"'";
	pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	pstmt.executeUpdate();	

	pstmt.close();
	conn.close();
%>