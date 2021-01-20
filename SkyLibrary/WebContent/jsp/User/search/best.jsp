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
		
		<title>�α⵵��</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/best.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/common.js"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
			<header>
				<div class="head_option">
					<div class="rightnow">
						<a href="#section"><span class="rightnow_click">���� �ٷΰ���</span></a>
					</div>
						<%
							if(id.equals("") || id == null){
						%>		
								<div class="head_btns">
									<input class="head_btn" type="button" value="�α���" onclick="location.href='../../User/loginout/login.jsp'">
									<input class="head_btn" type="button" value="ȸ������" onclick="location.href='../../User/join/join.jsp'">
								</div>
						<%		
							}else {
						%>
								<div class="head_btns">
									<span class="head_id"><%= id %> ��</span>
									<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../User/loginout/logout.jsp'">
								</div>
						<%		
							}
						%>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp"><img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="�ΰ�"></a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="total.jsp">�����˻�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../use/useTime.jsp">������ �̿�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../intro/notice.jsp">������ �Ұ�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="javascript:needLoginFn('<%= id %>')" class="myPage">����������</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">�����˻�</li>
						<a href="total.jsp"><li class="left_menu_sub">���հ˻�</li></a>
						<a href="best.jsp"><li class="on left_menu_sub">�α⵵��</li></a>
						<a href="new.jsp"><li class="left_menu_sub">��������</li></a>
						<a href="recommend.jsp"><li class="left_menu_sub last_sub">�缭��õ����</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">�α⵵��</span>
						<span class="page_map">�����˻� > �α⵵��</span>
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
							sql = "select subject, story, pdate, coverimg, company, writer, isbn, bcount from book order by bcount desc ";
							sql += "limit " + startno + "," + perpage;
							
							mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							
							
							int i = recordTotal - ((pageno - 1) * perpage);
							
							
							//���� ���� �Ѹ���
							while(rs.next())
							{
								String vsubject     = rs.getString("subject");     //å����
								String vstory       = rs.getString("story");       //å�ٰŸ�
								String vpdate       = rs.getString("pdate");       //å�߸���
								String vcoverimg    = rs.getString("coverimg");    //åĿ���̹���
								String vcompany     = rs.getString("company");     //���ǻ�
								String vwriter      = rs.getString("writer");      //����
								String visbn        = rs.getString("isbn");        //ISBN
		
							%> 
							
							<div class="best">					
								<table width="800px">
									<tr>
										<td rowspan="4" width="15%" align="center">
											<a href="bestView.jsp?isbn=<%= visbn %>"><img src="<%= vcoverimg %>" alt="<%= vsubject %>" width="82px"></a>
										</td>
										<td colspan="2"><a href="bestView.jsp?isbn=<%= visbn %>"><b><%= vsubject %></b></a></td>
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
									%><a href="best.jsp?page=1">�Ǿ�����</a><% 
									%><a href="best.jsp?page=<%=startPage - 1%>">����</a><% 
								}
								
								for (int j = startPage ; j <= endPage; j++) {
								    if (j == pageno) {
								        %> <b><a href="best.jsp?page=<%= j %>"><%= j %></a></b><%
								    } else {
								    	 %> <a href="best.jsp?page=<%= j %>"><%= j %></a> <%
								    }
								}
								
								if (endPage < maxPage) {
									%> <a href="best.jsp?page=<%= endPage + 1%>">����</a><%
									%> <a href="best.jsp?page=<%= maxPage %>">�ǵڷ�</a><%		
								}
							%> 
							</div>	
						</div>		
					</div>	
				</div>
			</section>
			<!-- section end -->
			
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
			
		</div>
	</body>
</html> 