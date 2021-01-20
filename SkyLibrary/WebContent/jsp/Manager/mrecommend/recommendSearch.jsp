<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	request.setCharacterEncoding("EUC-KR");
	String select = request.getParameter("select");
	String keyword = request.getParameter("keyword");
	
	if(select == null)
	{
		select = "1";
	}
	if(keyword == null)
	{
		keyword = "";
	}
	
	Connection        conn;
	PreparedStatement mStmt;
	ResultSet         rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );
	
	String sql = "";
	
	//select ���� ���� sql��
	switch(select) {
	case "1": //��ü
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where subject like '%"+keyword+"%' or writer like '%" + keyword + "%' ";
		break;
	case "2": //�ѱ���ȭ
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where subject like '%"+keyword+"%' ";
		break;
	case "3": //�ؿܿ�ȭ
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where writer like '%"+keyword+"%' ";
		break;
	}
	
	mStmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	rs = mStmt.executeQuery();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�缭 ��õ ��������</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<script src="../mnotice/js/jquery-3.5.1.min.js"></script>
<style>
/* recommendSearch.jsp css */
.booklist{
	position : relative;
	padding-left : 10%;
	height : 800px;
	width : 900px;
}
.searchpage{
	position : relative;
	padding-left : 42%;				
}	
.recommend{
	border-top : 3px solid #a8a8a8;
}
a{
	color : black;
	text-decoration: none;
}
.rselect{
	position : relative;
	margin-left : 9%;
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
				<span class="info_title"><span class="point">*</span>���� ���</span>				
				</div>
				<br>
				<br>
				<div class="rselect">
					<form action="recommendSearch.jsp" name="frm" id="frm" method="post">					
						<select id="select" name="select">							
							<%
							if( select.equals("1") )
							{
								%><option value="1" selected>��ü</option><%
							}else
							{
								%><option value="1">��ü</option><%									
							}
							if( select.equals("2") )
							{
								%><option value="2" selected>����</option><%
							}else
							{
								%><option value="2">����</option><%									
							}
							if( select.equals("3") )
							{
								%><option value="3" selected>����</option><%
							}else
							{
								%><option value="3">����</option><%									
							}									
							%>
						</select>
						<input type="text" name="keyword" id="keyword" value="<%= keyword %>">
						<input type="submit" value="�˻�">
					</form>	
				</div>	
				<div class="content">
					<div class="booklist">	
					<br>
					<br>
					<%
					
					if(rs != null){
						while(rs.next()){
							String vsubject   = rs.getString("subject");    //å����
							String vstory = rs.getString("story");   //å�ٰŸ�
							String vpdate = rs.getString("pdate"); //å�߸���
							String vcoverimg    = rs.getString("coverimg");    //åĿ���̹���
							String vcompany   = rs.getString("company");    //���ǻ�
							String vwriter = rs.getString("writer");   //����
							String visbn = rs.getString("isbn"); //ISBN
						%> 
						<div class="recommend">					
							<table width="800px">
								<tr>
									<td rowspan="4" width="15%" align="center">
										<a href="recommendView.jsp?isbn=<%= visbn %>"><img src="<%= vcoverimg %>" alt="<%= vsubject %>" width="82px"></a>
									</td>
									<td colspan="2"><a href="recommendView.jsp?isbn=<%= visbn %>"><b><%= vsubject %></b></a></td>
								</tr>
								<tr>
									<td width="30%">���� : <%= vwriter %></td>
									<td width="30%">ISBN : <%= visbn %></td>
								</tr>
								<tr>
									<td width="30%">���ǻ� : <%= vcompany %></td>
									<td width="30%">������ : �ϴ� ������</td>
								</tr>
								<tr>
									<td width="30%">������ : <%= vpdate %></td>
									<td width="30%">�ڷ�� : �Ϲ��ڷ��</td>
								</tr>
							</table>
						</div>							
						<%	
						}//while�� ����
					} else {
					%>
						<h3>�˻������ �����ϴ�.</h3>
					<% 
					}//if�� ����
					
					
					//����,��ȸ �� sql���� Ȱ���� ��ġ�� ���� ������ �ʾҴٸ� 
					//�ݾ��ִ� ���ǹ�
					if(rs    != null) try { rs.close(); }     catch(SQLException e) {out.print("����!");}
					if(mStmt != null) try { mStmt.close(); }  catch(SQLException e) {out.print("����!");}
					if(conn  != null) try { conn.close(); }   catch(SQLException e) {out.print("����!");}
					%> 
					</div>		
				</div>	
			</div>
		</section>
	</div>
</body>
</html>