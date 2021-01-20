<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	 
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	
	<title>�缭 ��õ ��������</title>
	
	<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
	<link rel="stylesheet" href="../../../css/mrecommend.css" type="text/css"/>
	
	<script src="../../../js/jquery-3.5.1.min.js"></script>
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
							<option value="1" selected>��ü</option>
							<option value="2">����</option>
							<option value="3">����</option>
						</select>
						<input type="text" name="keyword" id="keyword">
						<input type="submit" value="�˻�"  class="optionBox_btn_free">
					</form>	
				</div>	
				<div class="content">
					<div class="booklist">	
					<br>
					<br>
					<%
					
					Connection        conn;
					PreparedStatement mStmt;
					ResultSet         rs;
					
					String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
					String     mUserID   = "root";
					String     mUserPass = "mySQL1234";
					
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );
	
					
					//������ ����
					int recordTotal = 0; //���� �� ����
					int pageno      = 0; //��������ȣ
					int perpage     = 0; //�� �������� �Խù� ��
					int startno     = 0; //���۹�ȣ
					
					try
					{					
						String sql;
						
						String curpage = request.getParameter("page");
						if(curpage == null)
						{
							curpage = "1";
						}
	
						//���� ���� ��ȸ
						sql = "select count(*) as cnt from book ";
						
						mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mStmt.executeQuery();	
						rs.next();
						
						recordTotal = Integer.parseInt(rs.getString("cnt"));
						
						rs.close();
						mStmt.close();	
						//å ����  ��ȸ ����
						
														
						pageno  = Integer.parseInt(curpage); //���� ������ ���� ������ ��ȣ�� ����
						perpage = 5;
						startno = ((pageno - 1) * perpage);
						
						
						//���������� �ø� ���� ���� ��ȸ
						sql = "select subject, story, pdate, coverimg, company, writer, isbn, bcount from book ";
						sql += "limit " + startno + "," + perpage;
						
						mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mStmt.executeQuery();	
						
						
						int i = recordTotal - ((pageno - 1) * perpage);
						
						
						//��ȭ ���� �Ѹ���
						while(rs.next())
						{
							String vsubject  = rs.getString("subject");  //å����
							String vstory    = rs.getString("story");    //å�ٰŸ�
							String vpdate    = rs.getString("pdate");    //å�߸���
							String vcoverimg = rs.getString("coverimg"); //åĿ���̹���
							String vcompany  = rs.getString("company");  //���ǻ�
							String vwriter   = rs.getString("writer");   //����
							String visbn     = rs.getString("isbn");     //ISBN
	
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
						}
						
						rs.close();
						mStmt.close();		
						conn.close();
						
					} catch (Exception e)
					{
						out.println("ERROR:" + e.getMessage());
					}
					%>
						<br>
						<br>
						<%
						
						int BLOCK = 5;
						int startPage = ((pageno-1)/BLOCK*BLOCK)+1;
						int endPage = ((pageno-1)/BLOCK*BLOCK)+BLOCK;
						
						int maxPage = recordTotal / perpage;
						
						if( ( recordTotal % perpage ) != 0)
						{
							maxPage++;
						}
						
						if(maxPage < pageno){
							pageno = maxPage;
						}
						
						if(endPage > maxPage)
						{
							endPage = maxPage;
						}
						
						%>
							<div class="searchpage">	
							<%
								if(pageno > BLOCK) {
									%><a href="recommend.jsp?page=1">�Ǿ�����</a><% 
									%><a href="recommend.jsp?page=<%=startPage - 1%>">����</a><% 
								}
								
								for (int j = startPage ; j <= endPage; j++) {
								    if (j == pageno) {
								        %> <b><a href="recommend.jsp?page=<%= j %>"><%= j %></a></b><%
								    } else {
								    	 %> <a href="recommend.jsp?page=<%= j %>"><%= j %></a> <%
								    }
								}
								
								if (endPage < maxPage) {
									%> <a href="recommend.jsp?page=<%= endPage + 1%>">����</a><%
									%> <a href="recommend.jsp?page=<%= maxPage %>">�ǵڷ�</a><%		
								}
							%> 
							</div>	
					</div>		
				</div>	
			</div>
		</section>
	</div>
</body>
</html>