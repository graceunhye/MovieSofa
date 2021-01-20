<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>   

<%

String id = (String)session.getAttribute("idKey");
if(id == null){ id = ""; }

try{
	
	request.setCharacterEncoding("EUC-KR");
	
	String user_name    = request.getParameter("name");             //�̸�
	String user_num     = request.getParameter("num1")+"-";         //�޴��� ��ȣ
		   user_num    += request.getParameter("num2")+"-";
		   user_num    += request.getParameter("num3");
	String user_postnum = (request.getParameter("postnum")).trim(); //����  �Է��� �����ȣ
	String user_email1  = request.getParameter("email1");           //����  �Է��� �̸��� ���̵�
	String user_email2  = request.getParameter("email2");           //����  �Է��� �̸��� url
	String user_addr1   = request.getParameter("addr1");            //����  �Է��� �ּ�
	String user_addr2   = request.getParameter("addr2");            //����  �Է��� ���ּ�

	//int�ε� null�̰ų� ������ ������� �� ���
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
	alert("ȸ�������� ����  �Ǿ����ϴ�.");
	window.location = "../myPage/userInfo.jsp";
</script>				
<%
}catch(Exception e){
	e.printStackTrace();
%>
<script>
	alert("ȸ������ ������ �����Ͽ����ϴ�. �ٽ� �õ����ּ���.");
	window.location = "../myPage/userInfo.jsp";
</script>
<%
}
%>