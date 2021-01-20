<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.text.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>���⵵�� ��ȸ</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/renting.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/common.js"></script>
		<script src="../../../js/renting.js"></script>
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
									<input class="head_btn" type="button" value="�α���" onclick="location.href='../../loginout/login.jsp'">
									<input class="head_btn" type="button" value="ȸ������" onclick="location.href='../../join/join.jsp'">
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
						<li class="left_menu_title">����������</li>
						<a href="userInfo.jsp"><li class="left_menu_sub">ȸ������</li></a>
						<a href="wish.jsp"><li class="left_menu_sub">������� ��û</li></a>
						<a href="renting.jsp"><li class="on left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">���⵵�� ��ȸ / ����</span>
						<span class="page_map">������ �̿� > ���⵵�� ��ȸ</span>
					</div>
					<div class="content">
						<div class="rentTableWrap">
						<table width="1200" class="rentTable">
							<tr align="center"  class="top_tr">
								<th width="25%" class="top_td">����</th>
								<th width="20%" class="top_td">����</th>
								<th width="15%" class="top_td">���ǻ�</th>
								<th width="10%" class="top_td">��������</th>
								<th width="10%" class="top_td">�ݳ�������</th>
								<th width="10%" class="top_td">�����ݳ�</th>
								<th width="10%" class="top_td">��������</th>
							</tr>
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
								sql = "select * from user u, rent r, book b ";
								sql += "where r.id = u.id ";
								sql += "and r.isbn = b.isbn ";
								sql += "and u.id = ?";				
								mstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
								mstmt.setString(1,id);
								rs = mstmt.executeQuery();
						
								while(rs.next()) {
									/**  å���� ��������  **/
									String	gsubject    = rs.getString("subject");      //å����
									String	gcompany    = rs.getString("company");      //���ǻ�
									String	gwriter     = rs.getString("writer");       //����
									String	gisbn       = rs.getString("isbn");         //ISBN
		
									String gstartd = rs.getString("startd");
									String gendd = rs.getString("endd");
									
									/**  �뿩��¥, �ݳ���¥ ��ȯ�ؼ� ���ϱ�  **/
									SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
									Date start_d = dateFormat.parse(gstartd);
									Date end_d = dateFormat.parse(gendd);
		
									Calendar cal = Calendar.getInstance();
									cal.setTime(start_d);
									cal.add(Calendar.DATE,14);
		
									String startd_add = dateFormat.format(cal.getTime());
									Date startadd_d = dateFormat.parse(startd_add);
									
									int compare = end_d.compareTo(startadd_d);
															
								%> 
									<tr id="rent_tr" align="center">
										<td class="mid_td"><%= gsubject %></td>
										<td class="mid_td"><%= gwriter %></td>
										<td class="mid_td"><%= gcompany %></td>
										<td class="mid_td" class="endd_td"><%= gstartd %></td>
										<td class="mid_td"><%= gendd %></td>
										<td class="mid_td">
											<input type="button" value="�ݳ�" class="normalBtn" onclick="returnFn(this,'<%= id %>','<%= gisbn %>')">
										</td>
										<% 
										if (compare > 0) {									
										%> 
											<td class="mid_td" id="extension_td">
												<input type="button" value="����Ұ�" class="normalBtn" disabled>
											</td>
										<%
										} else {
										%>
										<td id="extension_td" class="mid_td">
											<input type="button" class="normalBtn" value="����" onclick="extensionFn(this, '<%= gisbn %>')">
										</td>
									</tr>
									<%
										} 
									%>
								<%
								}
								
								rs.close();
								mstmt.close();	
								%>	
							</table> 
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