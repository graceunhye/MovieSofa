<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%

	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
	} catch(Exception e) {
		System.out.println("Error : ����̹� �ε� ����");
	}		


	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;


	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	String sql = "select name, num, postNum, addr1, addr2, email1, email2 from user where id ='" + id+"'";

	pstmt = conn.prepareStatement(sql);	
	rs = pstmt.executeQuery();		 
	rs.next();
   			
	/** ȸ�� ���� **/
	String	   name 		= rs.getString("name");     //�̸�               
	String	   num 			= rs.getString("num");      //��ȣ
	String	   postNum 	   	= rs.getString("postNum");  //�����ȣ
   	String	   addr1       	= rs.getString("addr1");    //�ּ�
   	String	   addr2 	    = rs.getString("addr2");    //�ּ�2
   	String	   email1 	    = rs.getString("email1");   //�̸���
   	String	   email2 	    = rs.getString("email2");   //������

	
	String num1 ="";
	String num2 ="" ;
	String num3 ="";
	
	if(num!= null || num.equals("")){
		//int num_idx = num.indexOf("-"); 
		String[] numArr = num.split("-");
		num1 = numArr[0];
		num2 = numArr[1];
		num3 = numArr[2];

	}
	
	if(postNum.equals("0")){
		postNum = "";
	}
	

%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>ȸ������</title>	
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/userInfoModify.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/common.js"></script>
		<script src="../../../js/userInfoModify.js"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
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
							<li><a href="../mLibrary/wish.jsp">����������</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">����������</li>
						<a href="userInfo.jsp"><li class="on left_menu_sub">ȸ������</li></a>
						<a href="wish.jsp"><li class="left_menu_sub">������� ��û</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">ȸ������</span>
						<span class="page_map">���������� > ȸ������ > ȸ������ ����</span>
					</div>
					<form method="post" class="modifyfrm" name="modifyfrm" action="userModifyOk.jsp">
						<div class="content">
							<table class="content_table">
								<tr class="top_tr">
									<th style="width:25%;">ID</th>
									<td class="top_td"><%= id%></td>
								</tr>
								<tr class="mid_tr">
									<th>�̸�</th>
									<td class="mid_td"><input type="text" value="<%= name %>" id="name" name="name"></td>
								</tr>
								<tr class="mid_tr">
									<th>����ó</th>
									<td class="mid_td">
										<select name="num1">
											<option value="010" <% if(num1.equals("010")){ %>selected<%} %>>010
											<option value="011" <% if(num1.equals("011")){ %>selected<%} %>>011
											<option value="016" <% if(num1.equals("016")){ %>selected<%} %>>016										
										</select>-
										<input type="text" value="<%= num2%>" id="num2" name="num2">-
										<input type="text" value="<%= num3%>" id="num3" name="num3">
									</td>
								</tr>
								<tr class="mid_tr">
									<th>�ּ�</th>
									<td class="mid_td">
										<input type="text" id="postnum" name="postnum" size="7" value=<%= postNum %>>&nbsp;
										<input type="button" class="joinbtn1" value="�����ȣ ã��" onclick="PostOpen()"><br>
										<input type="text" id="addr1" name="addr1" size="50" value="<%= addr1 %>"><br>
										<input type="text" id="addr2" name="addr2" size="50" value="<%= addr2 %>">
									</td>
								</tr>
								<tr class="mid_tr">
									<th>�̸���</th>
									<td class="mid_td">
										<input type="text" value="<%= email1%>" id="email1" name="email1">@
										<select name="email2">
											<option value="e1"  <% if(email2.equals("e1")){ %>selected<%} %>>naver.com
											<option value="e2" <% if(email2.equals("e2")){ %>selected<%} %>>nate.com
											<option value="e3" <% if(email2.equals("e3")){ %>selected<%} %>>gmail.com
										</select>
									</td>
								</tr>
							</table>
							<div class="btns">
								<button type="button"  class="modifyOk_b" onclick="Submit()">����</button>
								<button type="button"  class="modifyOk_b" onclick="location.href='userInfo.jsp'">���</button>
							</div>
							<br>
							<br>
							<div style="position:relative; left:30%;">
								<a style="color:gray;">�ϴõ������� �� �̻� �̿����� �ʴ´ٸ�? </a>
								<%
									int rent_count		= 0; //��Ʈ ���� �� ����
								
									sql = "select count(*) as cnt from rent where id ='"+ id +"' ";
									
									pstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
									rs = pstmt.executeQuery();	
									rs.next();
									
									rent_count = Integer.parseInt(rs.getString("cnt"));
									
									rs.close();
									pstmt.close();	
									//rent ���� ��ȸ �Ϸ�
									

									
									/* 
									pstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
									rs = pstmt.executeQuery();	
									rs.next();
									
									rent_count = Integer.parseInt(rs.getString("cnt"));
									
	
									
									rs.close();
									pstmt.close();
									conn.close();	 */
								
								%>
								<a style="text-decoration:underline;"href="javascript:userDelete('<%= rent_count %>','<%= id %>')">ȸ��Ż�� �ϱ�</a>
							</div>				
						</div>
					</form>
				</div>
			</section>
			<!-- section end -->
			
			<footer>
				<div class="footer">
					<ul class="kind">
						<li class="footer_title">&nbsp;�缭</li>
						<li>Song EunHye</li>
						<li>Park Sujin</li>
						<li>Kang GoEun</li>
					</ul>
					<ul class="kind">
						<li class="footer_title">&nbsp;���۱Ⱓ</li>
						<li>2020.12.03~2020.12.31</li>
					</ul>
					<ul class="copy">
						<li>&copy; Sky Library</li>
					</ul>
				</div>
			</footer>
			<!-- footer end -->
		
		</div>
	</body>
</html>