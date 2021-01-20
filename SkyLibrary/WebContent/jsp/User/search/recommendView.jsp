<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>     
<%
	String isbn = request.getParameter("isbn");
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>�缭��õ���� ������</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/bookView.css" type="text/css"/>
		
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
						<a href="best.jsp"><li class="left_menu_sub">�α⵵��</li></a>
						<a href="new.jsp"><li class="left_menu_sub">��������</li></a>
						<a href="recommend.jsp"><li class="on left_menu_sub last_sub">�缭��õ����</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">��������</span>
						<span class="page_map">�����˻� > ��������</span>
					</div>
					<div class="content">
					
					<%
					
					Connection conn;
					PreparedStatement mstmt;
					ResultSet rs;
					
					String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
					String     mUserID   = "root";
					String     mUserPass = "mySQL1234";
					
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
					
					String sql = "";
					sql = "select * from book left join rbook ";
					sql += "on book.isbn = rbook.isbn ";
					sql += "where book.isbn = '" + isbn + "'" ;
					sql += "union ";
					sql += "select * from book right join rbook ";
					sql += "on book.isbn = rbook.isbn ";
					sql += "where book.isbn = '" + isbn + "'";			
							
					mstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
					rs = mstmt.executeQuery();
					rs.next();	
			
					
					/**  å���� ��������  **/
					String	gsubject    = rs.getString("subject");      //å����
					String	gstory      = rs.getString("story");	    //å �ٰŸ�		
					String	gpdate      = rs.getString("pdate");        //������
					String	gcoverimg   = rs.getString("coverimg");     //åĿ���̹���
					String	gcompany    = rs.getString("company");      //���ǻ�
					String	gwriter     = rs.getString("writer");       //����
					String	gisbn       = rs.getString("isbn");         //ISBN
					int 	grent       = rs.getInt("rent");            //�뿩����  0:���Ⱑ��, 1:������
					
					//String gstard = rs.getString("starrd");
					String gwhy = rs.getString("why");
				
					rs.close();
					mstmt.close();		
					%> 
						<div class="searchview">
							<br>
							<br>
							<div class="searchview1">
								<table width="800px" class="viewTable" >
									<tr height="80px;">
										<td colspan="3" align="center" height="50" class="view_td">
											<h2>&lt;&lt;&nbsp;&nbsp;  <%= gsubject %>  &nbsp;&nbsp;&gt;&gt;</h2>
										</td>
									</tr>
									<tr class="tr">
										<td rowspan="6" width="15%" align="center" class="imgtd">
											<img src="<%= gcoverimg %>" alt="<%= gsubject %>" width="82px">
										</td>
										<th>����</th>
										<td><%= gwriter %></td>
									</tr>
									<tr class="tr">
										<th>���ǻ�</th>
										<td><%= gcompany %></td>							
									</tr>
									<tr class="tr">
										<th>������</th>
										<td><%= gpdate %></td>							
									</tr>
									<tr class="tr">
										<th>ISBN</th>
										<td><%= gisbn %></td>							
									</tr>
									<tr class="tr lasttd">
										<th>������</th>
										<td>�ϴ� ������</td>							
									</tr>
								</table>
							</div>
							<br>
							<div class="searchview2">
								<h3><font color="orange">*</font>å ����</h3>
								<div class="storyDiv">
									<%= gstory %>
								</div>
							</div>
							<br>
							<div class="searchview3">
								<h3><font color="orange">*</font>��õ ����</h3>
								<div class="storyDiv">
									<%= gwhy %>
								</div>
							</div>					
							<br>
							<br>
							<button type="button" onclick="location.href='recommend.jsp'" class="listbtn">�������</button>
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