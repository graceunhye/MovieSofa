<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../include/openDB.jsp" %>  
<%

//���ڵ� �� �Ķ���� ����
request.setCharacterEncoding("EUC-KR");
String id    = (String)session.getAttribute("idKey");
if(id == null){ id = ""; }
String mv_no = request.getParameter("mv_no"); 

String sql = "";


%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>���� ���</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="../js/alert_login.js"></script>
		<script type="text/javascript">
		
			function noneIdFn() { //�α������� �ʾ��� �� �۾��� ��ư �Լ�
				alert("�α����� �ʿ��� ���� �Դϴ�. �α���ȭ������ �̵��մϴ�.");
				location.href="sessionLogin.jsp";
			}
			
			function IdFn() { //�α��� ���� �� �۾��� ��ư �Լ�
				location.href="rv_insert.jsp";
			}
			
		</script>
		
		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
	    <link rel="stylesheet" type="text/css" href="../css/mv_detail.css">
	    <link rel="stylesheet" type="text/css" href="../css/mv_list.css"/>
		
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
					
			<div style="clear:both;width:1280px;">
				<div class="rv">
					<div class="rvtxt_box" style="font-size:30px;font-weight:bold;padding-left:30px;">
					
					
						<%
						if(id.equals("")){ //�α��� ���� �ʾ��� ��
						%>		
							Review<input type="button" class="rvbtn" value="�۾���" onclick="noneIdFn()">
						<%
						}else { //�α��� ���� ��
						%>
							<form method="post" action="rv_insert.jsp" name="frm" id="frm">
								Review
								<input type="hidden" id="mv_no" name="mv_no" value="<%= mv_no %>">
								<input type="submit" class="rvbtn" value="�۾���">
							</form>								
						<%
						}
						%>	
						
					</div>

					<%		
					int recordTotal = 0;  //
					int pageno      = 0;  //������ ��ȣ
					int perpage     = 0;  //�������� �Խù� ��
					int startno     = 0;  //���۹�ȣ
					String curpage  = ""; //����������
					
					try
					{
			
						curpage = request.getParameter("page");
						if(curpage == null)
						{
							curpage = "1";
						}
			
						sql = "select count(*) as cnt from review where mv_no=" + mv_no; //������ ��ȭ�� ����� ��������
						
						mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mstmt.executeQuery();	
						rs.next();			
						recordTotal = Integer.parseInt(rs.getString("cnt"));
						rs.close();
						mstmt.close();	
						
						
						pageno  = Integer.parseInt(curpage); 
						perpage = 5;
						startno = ((pageno - 1) * perpage);
						
						sql = "select * from review where mv_no=" + mv_no ;
						sql += " order by rv_no desc limit " + startno + "," + perpage;
						
						mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mstmt.executeQuery();	
						
						int i = recordTotal - ((pageno - 1) * perpage);
						
						
						//���� ��� �Ѹ���
						while(rs.next()) 
						{
							String grv_no     = rs.getString("rv_no");    //�����ȣ
							String grv_writer = rs.getString("id");       //�����ۼ���
							String grv_title  = rs.getString("rv_title"); //��������
							String grv_body   = rs.getString("rv_body");  //���䳻��
							String grv_date   = rs.getString("rv_date");  //�����ۼ���
							String grv_file   = rs.getString("rv_file");  //�����ۼ���
			
						%> 
						
							<table class="rvt_1">			
								<tr>
									<td class="rvt_td" rowspan="3">
										<div class="imgwrap">
											<%
												if(grv_file == null) {
											%>
													<img src="../img/page/review.png" class="rvImg">
											<%		
												}else {
											%>	
													<img src="mv_filedown.jsp?rv_file=<%= grv_file %>" class="rvImg">
											<%		
												}
											%>
										</div>
									</td>
									<td class="rv_title">
										<a href="rv_view.jsp?rv_no=<%= grv_no %>">
											<%= grv_title %>
										</a>
									</td>
								</tr>
								<tr>
									<td class="rv_content" rowspan="2">
										<%= grv_body %>
									</td>
								</tr>
								<tr></tr>		
							</table>	
										
						<%
						}
						
						rs.close();
						mstmt.close();		
						conn.close();
						
					} catch (Exception e)
					{
						out.println("ERROR:" + e.getMessage());
					}
					
					int maxPage = recordTotal / perpage; //�ִ� ������ �� ����
					if( ( recordTotal % perpage ) != 0)
					{
						maxPage++;
					}
					
					%>
					
					
					<div class="pagelink">	
					
					
					
						<%
						for (int j = 1 ; j <= maxPage; j++) {
		
						    if (j == pageno) {
						    %> 
						    	<b><a href="rv_list.jsp?page=<%= j %>&mv_no=<%= mv_no %>"><%= j %></a></b>
						    <%
						    } else {
						    %> 
						    	<a href="rv_list.jsp?page=<%= j %>&mv_no=<%= mv_no %>"><%= j %></a> 
						    <%
						    }
						}
						%> 
					</div>	
				</div>	
			</div>			
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