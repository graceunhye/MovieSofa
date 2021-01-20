<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
request.setCharacterEncoding("EUC-KR");
String checkNo      = request.getParameter("checkNo");
String selectChange = request.getParameter("selectChange");
System.out.println("selectChange::"+selectChange);
System.out.println("checkNo::"+checkNo);

String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
String     m_UserID   = "root";
String     m_UserPass = "mySQL1234";

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	

String sql = "update abook set atype="+selectChange+", okdate=now() where no="+checkNo+"";
pstmt = conn.prepareStatement(sql);
pstmt.executeUpdate();
pstmt.close();
conn.close();
System.out.println("end!!");
%>