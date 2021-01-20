<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
try{
	request.setCharacterEncoding("EUC-KR");
	String manager_id   = request.getParameter("id"); //입력한 사서 아이디
	String manager_pw   = request.getParameter("pw"); //입력한 사서 비밀번호
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
	sql += "insert into manager ";
	sql += "(mid, pw, name) ";
	sql += "values ";
	sql += "(?, md5(?), ?) ";
	
	mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	mstmt.setString(1,manager_id);
	mstmt.setString(2,manager_pw);
	mstmt.setString(3,manager_name);
	mstmt.executeUpdate();
	
	mstmt.close();
	conn.close();
%> 
<script>
	alert("등록이 완료되었습니다.");
	window.location = "manager.jsp";
</script>				
<%
}catch(Exception e){

%>
<script>
	alert("등록에 실패하였습니다. 다시 시도해주세요.");
	window.location = "managerInsert.jsp";
</script>
<%
}
%>