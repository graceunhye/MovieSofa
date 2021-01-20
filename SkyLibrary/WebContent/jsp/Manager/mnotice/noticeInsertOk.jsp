<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>    
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	Connection conn;
	PreparedStatement mstmt;
	ResultSet rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
	
	final String saveFolder = "D:\\kge\\SkyLibrary\\WebContent\\jsp\\Manager\\mnotice\\img\\upload";
	final String encoding   = "EUC-KR";
	final int maxSize       = 10*1024*1024; //10mb 


	//������ ������ ���ε�Ǵ� ������ MultipartRequest ��ü ���� �����̴�. 
	MultipartRequest multi = null; 
	multi = new MultipartRequest (request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
	//request�� �Ǵ� ���� null�� ���Ѵ�. 
	//out.print("����"); 
	
	String fileName = multi.getFilesystemName("fname");
	//fileSelect.jsp ���Ͽ��� input �±� name 
	
	String original = multi.getOriginalFileName("fname"); 
	//filename�� �ߺ��̸��� ���� ��� �ڵ����� index�� �ٴµ�, index�Ǳ� ���� ������ 
	
	String type = multi.getContentType("fname"); 
	//� Ÿ���� �������� �˾Ƽ� �ؼ�����
	
	File f = multi.getFile("fname"); 
	//÷������ � ������ ���� ũ�� ������ 
	
	int len = 0; 
	if(f!=null) 
	{ 
		len = (int)f.length(); 
	} 
	
	String no     = multi.getParameter("no");
	String mid    = multi.getParameter("mid");
	String title  = multi.getParameter("title");
	String body   = multi.getParameter("ir1");
	String ndate  = multi.getParameter("ndate");
	String nhit   = multi.getParameter("nhit");
	String nfile  = multi.getFilesystemName("fname");
	String sql="";
	
	//noticeInsert ���� ������ ������ ���ο� ���� ����ϱ�
	sql  = "insert into notice ";
	sql += "(mid, title , body, ndate, nfile) ";
	sql += "values ";
	sql += "(?, ?, ?, now(), ?)";
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );

	mstmt.setString(1,id);        //�缭���̵�
	mstmt.setString(2,title);      //������������
	mstmt.setString(3,body);       //�������׳���
	mstmt.setString(4,nfile);      //��������÷������

	mstmt.executeUpdate();
	mstmt.close();
	
	/**  ���� �ֱٿ� ��ϵ� ������������ ��������  **/
	sql = "select * from notice where no=last_insert_id()";
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	/**  ������������ ��������  g=get **/
	String gno        = rs.getString("no");    //�������׹�ȣ
	//String vMid       = rs.getString("mid");   //�缭���̵�
	String gtitle     = rs.getString("title"); //������������ 
	String gbody      = rs.getString("body");  //�������׳���
	String gndate     = rs.getString("ndate");
	String gnhit      = rs.getString("nhit");
	String gnfile     = rs.getString("nfile"); //��������÷������
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� �󼼺���</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<script>
	function deleteFn(){
		if(confirm("�����Ͻðڽ��ϱ�?")){
			location.href = "noticeDelete.jsp?no=<%= no %>";
		}
	}
</script>
<style>
	.view_btn{
		position : relative;
		margin-left : 59%;
	}
</style>
</head>
<body style="margin: 0px;">
	<div class="wrap">
		<header>
			<div class="header">
				<div class="title_box"><span class="head_title">������ ������ </span><span class="name">�ϴõ�����</span></div>
			</div>
		</header>
		<section>
			<jsp:include page="../include/nav.jsp" />
			<div class="section">
				<div class="user_info">
					<span class="info_title"><span class="point">*</span>�������� </span>
					<br>
					<br>
					<table border="1" style="border-collapse:collapse" width="1000px">
						<tr>
							<td align="center" width="5%">�۹�ȣ</td>
							<td align="center" width="10%"><%= gno %></td>
							<td align="center" width="5%">�ۼ���</td>
							<td align="center" width="10%"><%= id %></td>
						</tr>		
						<tr class="mid_tr">
							<td align="center" width="5%">�ۼ���</td>
							<td align="center" width="10%"><%= gndate %></td>
							<td align="center" width="5%">��ȸ��</td>
							<td align="center" width="10%"><%= gnhit %></td>
						</tr>
						<tr>
							<td align="center" height="40px">����</td>
							<td colspan="3"><%= gtitle %></td>	
						</tr>
						<tr>
							<td align="center" height="400px">����</td>
							<td colspan="3"><%= gbody %></td>	
						</tr>
						<tr>
							<td align="center" height="50px">÷������</td>
							<td colspan="3">
								<%
									if(gnfile != null){
										%>
										<img src="noticeFileDown.jsp?type=img&nfile=<%= gnfile %>" width="300px">
										<br>
										<a href="noticeFileDown.jsp?nfile=<%= gnfile %>"><%= gnfile %></a>
										<%
									} else {
										%><%
									}
								%>
							</td>
						</tr>
					</table>
					<br>
					<br>
					<div class="view_btn">
						<input type="button" value="����" id="nmodify" onclick="location.href='noticeModify.jsp'">
						<input type="button" value="����" id="ndelete" onclick="deleteFn()">
						<input type="button" value="���" onclick="location.href='notice.jsp'">
					</div>	
				</div>
			</div>
		</section>
	</div>
</body>
</html>