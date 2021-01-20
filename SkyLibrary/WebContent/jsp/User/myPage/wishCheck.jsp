<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	request.setCharacterEncoding("EUC-KR"); 
	String id       = (String)session.getAttribute("idKey");  //���̵�
	String firstDay = request.getParameter("firstday");       //ó����
	String lastDay  = request.getParameter("lastday");        //���߰�
	
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>������� ��ȸ</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/wishCheck.css" type="text/css"/>
		
		<script type="text/javascript" src="../../"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
		<input type="hidden" value="<%= id %>" id="id">
		<header>
			<div class="head_option">
				<div class="rightnow">
					<a href="#section"><span class="rightnow_click">���� �ٷΰ���</span></a>
				</div>
				<div class="head_btns">
					<span class="head_id"><%= id %> ��</span>
					<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../loginout/logout.jsp'">
				</div>
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
					<a href="wish.jsp"><li class="on left_menu_sub">������� ��û</li></a>
					<a href="renting.jsp"><li class="left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
				</ul>
			</nav>
			<!-- nav end -->
			<div class="section">
				<div class="section_top">
					<span class="top_title">������� ��û</span>
					<span class="page_map">���������� > ������� ��û > ������� Ȯ��</span>
				</div>
				<div>
					<div class="searchOptionWrap">
						<form method="post" action="wishCheck.jsp">
							��¥:: <input type="date" name="startDay"/> �Ϻ���
							<input type="date" name="finishDay"/> �ϱ���
							<input type="submit" value="����" class="normalBtn">
						</form> 
					</div>
					<div class="wishTableWrap">
						<table border="1" class="wishTable">
							<thead>
								<tr height="50px">
									<th width="50px">��ȣ</th>
									<th width="300px">ǥ��</th>
									<th width="150px">ISBN</th>
									<th width="100px">���ڸ�</th>
									<th width="100px">������</th>
									<th width="150px">��û����</th>
									<th width="100px">�������</th>
								</tr>
							</thead>
							<tbody>
								<%
								
								Connection conn;
								PreparedStatement mstmt;
								ResultSet rs;
								String dbURL="jdbc:mysql://localhost:3306/skylibrary?"
											+"useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
								String dbID="root";
								String dbPassword="mySQL1234";
								Class.forName("com.mysql.cj.jdbc.Driver");
								conn = DriverManager.getConnection( dbURL ,dbID ,dbPassword );
									
								String sql = "select * from abook where id='"+id+"' ";
								if(firstDay != null && lastDay != null) 
								{
									sql += " order by no desc and wdate between "+firstDay+" and "+lastDay+" limit 0,10";
								}else
								{
									sql += " order by no desc limit 0,10";
								}
								
								
								mstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs = mstmt.executeQuery(sql);
	
								
								for(int i=0; i<10; i++) {
									if(rs.next() == true) {
										String gno 	    = rs.getString("no");
										String gsubject = rs.getString("subject");
										String gisbn    = rs.getString("isbn");
										String gwdate   = rs.getString("wdate");
										String gwriter  = rs.getString("writer");
										String gcompany = rs.getString("company");
										String gatype   = rs.getString("atype");
										String type     = "";
										switch(gatype)
										{
										case "0":
											type = "<font>��û��</font>";
											break;
											
										case "1":
											type = "<font color='blue'>ó����</font>";
											break;
											
										case "2": 
											type = "<font color='red'>��ҵ�</font>";
											break;
											
										case "3":
											type = "<font color='green'>������</font>";
											break;
										}
											
								%>
										<tr height="40px;">
											<td class="mid"><%= gno %></td>
											<td><%= gsubject %></td>
											<td class="mid"><%= gisbn %></td>
											<td class="mid"><%= gwriter %></td>
											<td class="mid"><%= gcompany %></td>
											<td class="mid"><%= gwdate %></td>
											<td class="mid"><%= type %></td>
										</tr>
								<%
									}else {
								%>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
	
								<%		
									} //if�� ����
								} //for�� ����
								%>								
							</tbody>
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