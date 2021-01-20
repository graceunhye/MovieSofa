<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
request.setCharacterEncoding("EUC-KR"); 
String id      = (String)session.getAttribute("idKey"); //���̵�
String subject = request.getParameter("subject");       //å����
String isbn    = request.getParameter("isbn");          //isbn
String pdate   = request.getParameter("pdate");         //������
String price   = request.getParameter("price");         //����
String writer  = request.getParameter("writer");        //�۰���
String company = request.getParameter("company");       //���ǻ�
String why     = request.getParameter("why");           //����


Connection        conn;
PreparedStatement mstmt;
ResultSet         rs;


String dbURL       =  "jdbc:mysql://localhost:3306/skylibrary?"
						+  "useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
String dbID        ="root";
String dbPassword  ="mySQL1234";
Class.forName("com.mysql.cj.jdbc.Driver");
conn = DriverManager.getConnection( dbURL ,dbID ,dbPassword );
	
String   sql =  "insert into abook ";
		 sql += "(id, subject, isbn, pdate, price, writer, company, why, wdate) ";
		 sql += "values";
		 sql += "(?,?,?,?,?,?,?,?,now())";
		 
mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
mstmt.setString(1,id);
mstmt.setString(2,subject);
mstmt.setString(3,isbn);
mstmt.setString(4,pdate);
mstmt.setString(5,price);
mstmt.setString(6,writer);
mstmt.setString(7,company);
mstmt.setString(8,why);
mstmt.executeUpdate();
mstmt.close();
conn.close();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>������� ��û�Ϸ�</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/wish.css"   type="text/css"/>
		
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
						<span class="head_id">
							<c:out value="${ id }"/> ��
						</span>
						<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../loginout/logout.jsp'">
					</div>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp">
							<img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="�ΰ�">
						</a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="../search/total.jsp">�����˻�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../use/useTime.jsp">������ �̿�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../intro/notice.jsp">������ �Ұ�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="userInfo.jsp">����������</a></li>
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
						<span class="page_map">���������� > ������� ��û > ��û�ϱ�</span>
					</div>
					<div class="content">
						<p class="tip"><span class="point">*</span> ǥ�õ� �׸��� �ʼ� �Է� �׸��Դϴ�</p>
						<table class="wish_table" >
							<tbody>
								<tr>
									<th scope="row">������<span class="point">*</span></th>
									<td><%= subject %></td>
								</tr>
								<tr>
									<th scope="row">isbn<span class="point">*</span></th>
									<td><%= isbn %></td>
								</tr>
								<tr>
									<th scope="row">����⵵ <span class="point">*</span></th>
									<td><%= pdate %></td>
								</tr>
								<tr>
									<th scope="row">����<span class="point">*</span></th>
									<td><%= price %></td>
								</tr>
								<tr>
									<th scope="row">���ڸ�</th>
									<td><%= writer %></td>
								</tr>
								<tr>
									<th scope="row">������</th>
									<td><%= company %></td>
								</tr>
								<tr>
									<th class="last" scope="row">��û����</th>
									<td class="last"><%= why %></td>
								</tr>
							</tbody>
						</table>
						<div class="btns">
							<input class="btn" type="button" value="Ȯ��" onclick="location.href='wish.jsp'"/>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->
		
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
	
		</div>
		<script>
			alert("��û�� �Ϸ�Ǿ����ϴ�.");
		</script>
	</body>
</html>