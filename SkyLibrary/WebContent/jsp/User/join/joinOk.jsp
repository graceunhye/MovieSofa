<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%
try{
	request.setCharacterEncoding("EUC-KR");
	
	String user_id      =  request.getParameter("id");                //ȸ�����Խ� �Է��� ���̵�
	String user_pw      =  request.getParameter("pw1");               //ȸ�����Խ� �Է��� ��й�ȣ
	String user_name    =  request.getParameter("name");              //ȸ�����Խ� �Է��� �̸�
	String user_num     =  request.getParameter("num1")+"-";          //�ڵ��� ��ȣ
		   user_num     += request.getParameter("num2")+"-";
		   user_num     += request.getParameter("num3");
	String user_postnum =  (request.getParameter("postnum")).trim();  //ȸ�����Խ� �Է��� �����ȣ
	String user_email1  =  request.getParameter("email1");            //ȸ�����Խ� �Է��� �̸��� ���̵�
	String user_email2  =  request.getParameter("email2");            //ȸ�����Խ� �Է��� �̸��� url
	String user_addr1   =  request.getParameter("addr1");             //ȸ�����Խ� �Է��� �ּ�
	String user_addr2   =  request.getParameter("addr2");             //ȸ�����Խ� �Է��� ���ּ�

	
	//int�ε� null�̰ų� ������ ������� �� ���
	if(user_postnum == null || user_postnum.equals(""))
	{
		user_postnum = "0";
	}
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;


	String dbURL      = "jdbc:mysql://localhost:3306/skylibrary?"
									+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID       = "root";
	String dbPassword = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

	String sql = "";
	sql += "insert into user ";
	sql += "(id, pw, name, num, postNum, email1, email2, addr1, addr2) ";
	sql += "values ";
	sql += "(?, md5(?), ?, ?, ?, ?, ?, ?, ?) ";

	mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	mstmt.setString(1,user_id);
	mstmt.setString(2,user_pw);
	mstmt.setString(3,user_name);
	mstmt.setString(4,user_num);
	mstmt.setInt(5,Integer.parseInt(user_postnum));
	mstmt.setString(6,user_email1);
	mstmt.setString(7,user_email2);
	mstmt.setString(8,user_addr1);
	mstmt.setString(9,user_addr2);
	mstmt.executeUpdate();
	
	mstmt.close();
	conn.close();

%> 
<script>
	alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
	window.location = "../loginout/login.jsp";
</script>				
<%
}catch(Exception e){

%>
<script>
	alert("ȸ�����Կ� �����Ͽ����ϴ�. �ٽ� �õ����ּ���.");
	window.location = "join.jsp";
</script>
<%
}
%>