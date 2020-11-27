<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	//���ڵ� �� �Ķ���� ����
	request.setCharacterEncoding("EUC-KR");
	String key    = request.getParameter("key");	       //�˻���
	String select = request.getParameter("select");        //�˻��ɼ�
	String id     = (String)session.getAttribute("idKey"); //���̵�
	
	if(id     == null) {id = "";}
	if(key    == null) {key = "?!";}   //�������� �������� ���� �־� null�� ����
	if(select == null) {select = "1";} //�˻��ɼ� ���� �� �� �� �⺻�� "1"(��ü�˻�)
	
	
	String dbURL="jdbc:mysql://localhost:3306/moviesofa?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";                             
	String dbID="root";
	String dbPassword="mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection( dbURL ,dbID ,dbPassword );
	
	
	String sql = "";
	
	//select ���� ���� sql��
	switch(select) {
	case "1": //��ü
		sql = "select mv_no, mv_title, mv_story, mv_thum from movieinfo where mv_title like '%"+key+"%'";
		break;
	case "2": //�ѱ���ȭ
		sql = "select mv_no, mv_title, mv_story, mv_thum from movieinfo where mv_type='k' and mv_title like '%"+key+"%'";
		break;
	case "3": //�ؿܿ�ȭ
		sql = "select mv_no, mv_title, mv_story, mv_thum from movieinfo where mv_type='w' and mv_title like '%"+key+"%'";
		break;
	}
	
	PreparedStatement pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	ResultSet rs = pstmt.executeQuery();
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>�˻����</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		
		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/mv_search.css">
	</head>
	<!-- head end -->
	
	<body style="background-color:#2E2D2C;margin:0;">
		<div class="wrap">
			<header style="align: center;">
				<div style="text-align:right;">
				
					<% 
					if(!id.equals(""))
					{
					%>	
						<font style="font-weight:bold;"><%= id %> ��</font>
						<a class="a" href="sessionLogout.jsp">LOGOUT</a> 
					<% 
					} else {
					%> 
						<a class="a" href="sessionLogin.jsp">LOGIN</a>
						<a class="a" href="mv_join.jsp">JOIN</a>	
					<% 	
					}
					%>  
					
				</div>
				<div style="margin-left: 470px">
					<a class="a" href="home.jsp">
						<img src="../img/page/logo.png" name="logo" id="logo" width="300px">
					</a>
				</div>
			</header>
			<!-- header end -->
		
			<nav style="width: 1280px;height: 48px; background-color: #2E2D2C;position: sticky;top:0;">
			   <ul class="menu">
					<li class="menu_li"><a class="menu_a" href="mv_main.jsp">BOXOFFICE</a></li>
					<li class="menu_li"><a class="menu_a" href="mv_list.jsp">REVIEW</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('�غ����� �����Դϴ�.')">NEWS</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('�غ����� �����Դϴ�.')">TALK</a></li>
					<form name="frm" id="frm" method="post" action="mv_search.jsp">
						<li class="menu_li">
							<select class="search_type" id="select" name="select">
								<option value="1">��ü</option>
								<option value="2">�ѱ���ȭ</option>
								<option value="3">�ؿܿ�ȭ</option>
							</select>
						</li>
						<li class="menu_li">
							<input class="search_text" type="text" id="key" name="key" placeholder="�˻�� �Է��ϼ���.">
						</li>
						<li class="menu_li">
							<input class="search_btn" type="submit" value="search">
						</li>
					</form>
				</ul>				
			</nav>	
			<!-- nav end -->
			
			<section>
				<article>
					<div class="poster">
					
					
					<%
						if(select.equals("1")) {
					%>
						<h1>��ü �˻����</h1>
					<% 
						}else if(select.equals("2")) {
					%>
						<h1>�ѱ���ȭ �˻����</h1>
					<% 		
						}else if(select.equals("3")) {
					%>
						<h1>�ؿܿ�ȭ �˻����</h1>
					<% 		
						}

						
						/**  ��ȭ���� �Ѹ���   **/
						if(rs != null){
							while(rs.next()) {
								int    gmv_no    = rs.getInt("mv_no");         //��ȭ��ȣ
								String gmv_thum  = rs.getString("mv_thum");    //��ȭ�����
								String gmv_title = rs.getString("mv_title");   //��ȭ����
								String gmv_story = rs.getString("mv_story");   //��ȭ�ٰŸ�
						%>
									<table class="rvm">
										<tr>
											<th>
												<a href="mv_view.jsp?mv_no=<%= gmv_no %>">
													<img src="../img/poster/<%= gmv_thum %>" width="100">
												</a>
											</th>
											<td>
												<a href="mv_view.jsp?mv_no=<%= gmv_no %>">
													<b>
														<%= gmv_title %>
													</b>
												</a>
												<br/>
												<br/>
												<%= gmv_story %>
											</td>
										</tr>
									</table>
									
						<% 
							}//while�� ����
						}else {
						%>
							<h3>�˻������ �����ϴ�.</h3>
						<% 
						}//if�� ����
						
						
						//����,��ȸ �� sql���� Ȱ���� ��ġ�� ���� ������ �ʾҴٸ� 
						//�ݾ��ִ� ���ǹ�
						if(rs    != null) try { rs.close(); }     catch(SQLException e) {out.print("����!");}
						if(pstmt != null) try { pstmt.close(); }  catch(SQLException e) {out.print("����!");}
						if(conn  != null) try { conn.close(); }   catch(SQLException e) {out.print("����!");}
						%>
						
					</div>	
				</article>
			</section>			
			<!-- section end -->
			
			<footer style="background-color:#2e2d2c;height:100px;">
				<div class="footer">
					<ul>
						<li class="footer_title">       Crew member</li>
						<li class="footer_content">     Kang GoEun</li>
						<li class="footer_content">     Park SuJin</li>
						<li class="footer_content">     Bae MinJu</li>
						<li class="footer_content">     Song EunHye</li>
						<li class="footer_title">&copy; moviesofa</li>
					</ul>
				</div>
			</footer>
			<!-- footer end -->
		</div>
	</body>
	<!-- body end -->
</html>