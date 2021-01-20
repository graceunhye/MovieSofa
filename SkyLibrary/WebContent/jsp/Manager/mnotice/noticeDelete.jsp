<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	String no = request.getParameter("no");	
	
	Connection conn;
	PreparedStatement mstmt;
	ResultSet rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );

	String sql = "";
	
	mstmt = conn.prepareStatement("delete from notice where no="+no);
	mstmt.executeUpdate();
	mstmt.close();
%>
<script>
	alert("삭제 되었습니다.");
	window.location.href="notice.jsp";
</script>
<%
conn.close();
%>