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
	
	/** ��ȸ�� ����  **/
	sql  = "update notice ";
	sql += "set nhit=nhit+1 ";
	sql += "where no="+no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	mstmt.executeUpdate();
	mstmt.close();
	
	
	sql = "select no,title,body,ndate,nhit,nfile ";
	sql += "from notice ";
	sql += "where no=" + no;

	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	String vNO        = rs.getString("no");    //�������׹�ȣ
	//String vMid       = rs.getString("mid");   //�缭���̵�
	String vTitle     = rs.getString("title"); //������������ 
	String vBody      = rs.getString("body");  //�������׳���
	String vNdate     = rs.getString("ndate");
	String vNhit      = rs.getString("nhit");
	String vNfile     = rs.getString("nfile"); //��������÷������
	
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
	.view_td{
		background-color : #f5f5f5;
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
					<table border="1" style="border-collapse:collapse" width="1000">
						<tr>
							<td align="center" width="7%" class="view_td">�۹�ȣ</td>
							<td align="center" width="10%"><%= vNO %></td>
							<td align="center" width="7%" class="view_td">�ۼ���</td>
							<td align="center" width="10%"><%= id %></td>
						</tr>		
						<tr class="mid_tr">
							<td align="center" width="7%" class="view_td">�ۼ���</td>
							<td align="center" width="10%"><%= vNdate %></td>
							<td align="center" width="7%" class="view_td">��ȸ��</td>
							<td align="center" width="10%"><%= vNhit %></td>
						</tr>
						<tr>
							<td align="center" height="40px" class="view_td" width="7%">����</td>
							<td colspan="3"><%= vTitle %></td>	
						</tr>
						<tr>
							<td align="center" height="400px" class="view_td" width="7%">����</td>
							<td colspan="3">
							<%
								if(vNfile != null) {
									%>
									<img src="noticeFileDown.jsp?type=img&nfile=<%= vNfile %>">
									<%= vBody %>
									<%
								} else {
									%><%= vBody %><%
								}
							%>
							</td>	
						</tr>
						<tr>
							<td align="center" height="50px" class="view_td" width="7%">÷������</td>
							<td colspan="3">
								<%
									if(vNfile != null){
										%>
										<a href="noticeFileDown.jsp?nfile=<%= vNfile %>"><%= vNfile %></a>
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
						<input type="button" value="����" id="nmodify" class="optionBox_btn_free" onclick="location.href='noticeModify.jsp?no=<%= no %>'">
						<input type="button" value="����" id="ndelete"  class="optionBox_btn_free" onclick="deleteFn()">
						<input type="button" value="���"  class="optionBox_btn_free" onclick="location.href='notice.jsp'">
					</div>	
				</div>
			</div>
		</section>
	</div>
</body>
</html>