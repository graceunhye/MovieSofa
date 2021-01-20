<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	String admid = (String)session.getAttribute("admKey");
	if(id == null)
	{
		response.sendRedirect("/SkyLibrary/jsp/main.jsp");
		return; 
	}
	if( !id.equals("") && admid != null)
	{
		%>
		<script>
			if(confirm("�����ڴ� MyPage�� �������� �ʽ��ϴ�.\n\n������ �������� �̵� �Ͻðڽ��ϱ�?") == 1)
			{
				document.location = "/SkyLibrary/jsp/Manager/muser/mUser.jsp";
			}else				
			{
				document.location = "/SkyLibrary/jsp/main.jsp";
			}
		</script>
		<%
		return;
	}
	
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
	   			
		String	   name 		= rs.getString("name");      //�̸�
		String	   num 			= rs.getString("num");       //��ȣ
	   	int	  	   postNum 	   	= rs.getInt("postNum");      //�����ȣ
	   	String	   addr1       	= rs.getString("addr1");     //�ּ�
	   	String	   addr2 	    = rs.getString("addr2");     //�ּ�2
	   	String	   email1 	    = rs.getString("email1");    //�̸���
	   	String	   email2 	    = rs.getString("email2");    //������

		rs.close();
		pstmt.close();
		conn.close();	

%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>ȸ������</title>
			
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/userInfo.css" type="text/css"/>
		
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
						<span class="head_id"><%= id %> ��</span>
						<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../User/loginout/logout.jsp'">
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
						<a href="userInfo.jsp"><li class="on left_menu_sub">ȸ������</li></a>
						<a href="wish.jsp"><li class="left_menu_sub">������� ��û</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">ȸ������</span>
						<span class="page_map">���������� > ȸ������</span>
					</div>
					<div class="content">
						<div>
							<table class="content_table">
									<tr class="top_tr">
										<th style="width:25%;">ID</th>
										<td class="top_td"><%= id %></td>
									</tr>
									<tr class="mid_tr">
										<th>�̸�</th>
										<td class="mid_td"><%= name %></td>
									</tr>
									<tr class="mid_tr">
										<th>����ó</th>
										<td class="mid_td"><%= num %></td>
									</tr>
									<tr class="mid_tr">
										<th>�ּ�</th>
										<td class="mid_td"><%= addr1 %> <%= addr2 %></td>
									</tr>
									<tr class="mid_tr">
										<th >�̸���</th>
									<%
									  if(email2.equals("e1")){
									%>
										<td class="mid_td"><%= email1 %>@naver.com</td>
									<%}else if(email2.equals("e2")){ %>
										<td class="mid_td"><%= email1 %>@nate.com</td>
									<%}else if(email2.equals("e3")){ %>
										<td class="mid_td"><%= email1 %>@gamil.com</td>
									<%
										}
									%>
									</tr>
							</table>
							<button id="modify_b" type="button" onclick="location.href='userInfoModify.jsp'">ȸ������ ����</button>
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