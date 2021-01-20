<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>   

<%

String id = (String)session.getAttribute("idKey");
if(id == null){ id = ""; }

try{
	
	request.setCharacterEncoding("EUC-KR");
	
	String user_name    = request.getParameter("name");             //이름
	String user_num     = request.getParameter("num1")+"-";         //휴대폰 번호
		   user_num    += request.getParameter("num2")+"-";
		   user_num    += request.getParameter("num3");
	String user_postnum = (request.getParameter("postnum")).trim(); //새로  입력한 우편번호
	String user_email1  = request.getParameter("email1");           //새로  입력한 이메일 아이디
	String user_email2  = request.getParameter("email2");           //새로  입력한 이메일 url
	String user_addr1   = request.getParameter("addr1");            //새로  입력한 주소
	String user_addr2   = request.getParameter("addr2");            //새로  입력한 상세주소

	//int인데 null이거나 공백이 들어있을 때 대비
	if(user_postnum == null || user_postnum.equals(""))
	{
		user_postnum = "0";
	}
	
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;


	String dbURL      = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID       = "root";
	String dbPassword = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

	
	String sql = "";
	sql += "update user ";
	sql += "set name=?, num=?, postNum=?, addr1=?, addr2=?, email1=?, email2=? ";
	sql += "where id='" + id+"'";

	mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	mstmt.setString(1,user_name);
	mstmt.setString(2,user_num);
	mstmt.setInt(3,Integer.parseInt(user_postnum));
	mstmt.setString(4,user_addr1);
	mstmt.setString(5,user_addr2);
	mstmt.setString(6,user_email1);
	mstmt.setString(7,user_email2);
	mstmt.executeUpdate();

	mstmt.close();
	conn.close();

%> 
<script>
	alert("회원정보가 수정  되었습니다.");
	window.location = "../myPage/userInfo.jsp";
</script>				
<%
}catch(Exception e){
	e.printStackTrace();
%>
<script>
	alert("회원정보 수정에 실패하였습니다. 다시 시도해주세요.");
	window.location = "../myPage/userInfo.jsp";
</script>
<%
}
%>