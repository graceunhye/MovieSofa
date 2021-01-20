<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%

	request.setCharacterEncoding("EUC-KR");


	String id      = (String)session.getAttribute("idKey");
	String keyword = request.getParameter("keyword");
	String select  = request.getParameter("select");
	
	
	
	if(id == null){ id = ""; }
	if(keyword == null){ keyword = ""; }
	if(select == null || select.equals("0")){ select = "nope"; }
	
	
	
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>��������</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/qna.css" type="text/css"/>
		
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
					<div class="head_btns">
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
							<li><a href="../search/total.jsp">�����˻�</a></li>
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
						<li class="left_menu_title">������ �̿�</li>
						<a href="useTime.jsp"><li class="left_menu_sub">�̿�ð�</li></a>
						<a href="useGuide.jsp"><li class="left_menu_sub">����/�ݳ�/����/����</li></a>
						<a href="qna.jsp"><li class="on left_menu_sub last_sub">��������</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">��������</span>
						<span class="page_map">������ �̿� > ��������</span>
					</div>
					<div class="content">
						<div align="center">
						<%
						Connection        conn;
						PreparedStatement mStmt;
						ResultSet         rs;				
						String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
													+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
						String     mUserID   = "root";
						String     mUserPass = "mySQL1234";
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );
		
						
						//������ ����
						int recordTotal = 0; //å �� ����
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
							sql = "select count(*) as cnt from q ";
							if(!keyword.equals("")){
								if(!select.equals("nope"))
								{
									sql += "where "+ select +" like '%"+ keyword +"%' ";
									
								}else 
								{
									sql += "where title like '%"+ keyword +"%' or body like '%"+ keyword +"%'";
								}
							}
							mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							rs.next();
							
							recordTotal = Integer.parseInt(rs.getString("cnt"));
							
							rs.close();
							mStmt.close();	
							
							
		
							pageno  = Integer.parseInt(curpage); //���� ������ ���� ������ ��ȣ�� ����
							perpage = 15;
							startno = ((pageno - 1) * perpage);
							
							
							
							//���������� �ø� ���� ���� ��ȸ
							sql = "select no, id, title, body, wdate, hit, atype from q ";
							if(!select.equals("nope"))
							{
								sql += "where "+ select +" like '%"+ keyword +"%' ";
							}else 
							{
								sql += "where title like '%"+ keyword +"%' or body like '%"+ keyword +"%'";
							}
							sql += " order by no desc limit " + startno + "," + perpage;
		
							mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							
		
							int i = recordTotal - ((pageno - 1) * perpage);
							%>
							<span class="searchResultNum">�˻��� �����:: <font color="orange"><%= recordTotal %></font></span>		
							<div class="searchBox">
								<form id="frm" name="frm" method="post" action="qna.jsp">
									<select id="select" class="select" name="select">
										<option value="0">��ü</option>
										<option value="title">����</option>
										<option value="body">����</option>
									</select>
									<input type="text" name="keyword" id="keyword" class="keyword" value="<%= keyword %>">
									<input type="submit" value="�˻�" class="searchBtn">
								</form>
							</div>		
							<table width="1200px" class="qnaTable">
								<tr height="50px" class="top_tr">
									<th align="center" class="top_td">�۹�ȣ</th>
									<th width="500" class="top_td">����</th>
									<th align="center" class="top_td">�ۼ���</th>
									<th align="center" class="top_td">�ۼ���</th>
									<th align="center" class="top_td">����</th>
								</tr>
							<%
							
							
							//���� ���� �Ѹ���
							while(rs.next())
							{
								int    gno     = rs.getInt("no");        //������ȣ
								int    ghit    = rs.getInt("hit");       //��ȸ��
								int    gatype  = rs.getInt("atype");     //�亯���� (true:1, false:0)
								String gid     = rs.getString("id");     //���� �ۼ���
								String gtitle  = rs.getString("title");  //���� ����
								String gwdate  = rs.getString("wdate");  //��������
								
								
		
							%> 
								<tr>
									<td><%= gno %></td>
									<td><a href="qnaView.jsp?no=<%= gno %>"><%= gtitle %></a></td>
									<td><%= gid %></td>
									<td><%= gwdate %></td>
									<td>
									
									
									<%
										if(gatype==0){
									%>
											<font color="blue">�亯���</font>
									<%		
										}else{
									%>
											<font color="orange">�亯�Ϸ�</font>
									<%		
										}
									%>
									
									
									</td>
								</tr>
														
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
							</table>
							<br>
							<span class="btns"><input class="btn" type="button" value="�۾���" onclick="qnaNeedLogin('<%= id %>')"></span>
							<br>
						</div>
							<%
						
							int BLOCK = 5;
							int startPage = ((pageno-1)/BLOCK*BLOCK)+1;
							int endPage = ((pageno-1)/BLOCK*BLOCK)+BLOCK;
		
							int maxPage = recordTotal / perpage;
							if( ( recordTotal % perpage ) != 0){
								maxPage++;
							}
							
							if(maxPage < pageno){
								pageno = maxPage;
							}
							
							if(endPage > maxPage)
							{
								endPage = maxPage;
							}
							String pageword = URLEncoder.encode(keyword,"utf-8");
							
							%>
						<div class="searchpage">	
						<%
							if(pageno > BLOCK) {
								%><a href="qna.jsp?page=1&keyword=<%= pageword %>&select=<%= select %>">�Ǿ�����</a>&nbsp;<% 
								%><a href="qna.jsp?page=<%=startPage - 1%>&keyword=<%= pageword %>&select=<%= select %>">����</a><% 
							}
							
							for (int j = startPage ; j <= endPage; j++) {
							    if (j == pageno) {
							        %> <b><a href="qna.jsp?page=<%= j %>&keyword=<%= pageword %>&select=<%= select %>"><%= j %></a></b><%
							    } else {
							    	 %> <a href="qna.jsp?page=<%= j %>&keyword=<%= pageword %>&select=<%= select %>"><%= j %></a> <%
							    }
							}
							
							if (endPage < maxPage) {
								%> <a href="qna.jsp?page=<%= endPage + 1%>&keyword=<%= pageword %>&select=<%= select %>">����</a>&nbsp;<%
								%> <a href="qna.jsp?page=<%= maxPage %>&keyword=<%= pageword %>&select=<%= select %>">�ǵڷ�</a><%		
							}
						%> 
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