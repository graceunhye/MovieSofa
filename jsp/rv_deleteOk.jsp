<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String rv_no = request.getParameter("rv_no");  //�����ȣ
	String mv_no = request.getParameter("mv_no");  //��ȭ��ȣ

	//jdbc ����
	Connection conn;
	PreparedStatement mstmt;

	String dbURL="jdbc:mysql://localhost:3306/moviesofa?"
				+"useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
	String dbID="root";
	String dbPassword="mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( dbURL ,dbID ,dbPassword );	
	String sql = "";
	
	
	//sql = "delete from review where rv_no="+rv_no;
	
	mstmt = conn.prepareStatement("delete from review where rv_no="+rv_no);
	mstmt.executeUpdate();
	mstmt.close();
%>
<script>
	alert("���� �Ǿ����ϴ�.");
	window.location.href="rv_list.jsp?mv_no="+<%= mv_no %>;
</script>
<%
conn.close();
%>