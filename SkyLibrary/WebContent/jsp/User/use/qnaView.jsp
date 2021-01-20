<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%

	request.setCharacterEncoding("EUC-KR");
	String id  = (String)session.getAttribute("idKey"); //���̵�
	String no  = request.getParameter("no");            //�۹�ȣ
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
								+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
	
	
	/** �۹�ȣ no�� �Խù� �Ѹ��� **/
	String sql = "select * from q where no="+no;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	rs.next();
	String gtitle = rs.getString("title");  //��������
	String gbody  = rs.getString("body");   //��������
	String gwdate = rs.getString("wdate");  //��������
	String gid    = rs.getString("id");     //������
	String gatype = rs.getString("atype");  //�亯����
	
	rs.close();
	pstmt.close();
	
	/** �۹�ȣ no�� �޸� ��� �Ѹ���  **/
	sql = "select * from a where no="+no;
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	String gmid    = "";      //�缭���̵�
	String gmno    = "";      //������ȣ
	String gmbody  = "";      //�亯����
	String gmtitle = "";      //�亯����
	String gmwdate = "";      //�亯����
	
	
	//�亯�� ������ ��� �亯�� �����´�.
	if(rs.next() == true) {
		
		gmid    = rs.getString("mid"); 
		gmno    = rs.getString("no");
		gmbody  = rs.getString("body");
		gmtitle = rs.getString("title");
		gmwdate = rs.getString("wdate");
	}

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
				<%
				if(id == null || id.equals("") ){
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
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">��������</span>
						<span class="page_map">������ �̿� > �������� > ���� ����</span>
					</div>
					<div class="content">
						<div class="qTableWrap">
							<h2 class="subTitle"><span class="point">*</span>����</h2>
							<table border="1" width="1200px" class="qTable">
								<tr height="40px;">
									<th>������ȣ</th>
									<td><%= no %></td>
									<th>������</th>
									<td><%= gid %></td>
									<th>�ۼ���</th>
									<td><%= gwdate %></td>
								</tr>
								<tr height="40px;">
									<th>����</th>
									<td colspan="5"><%= gtitle %></td>
								</tr>
								<tr>
									<td colspan="6" class="body"><%= gbody %></td>
								</tr>
							</table>
						<%
							if((gmno==null || gmno.equals("")) && gid.equals(id)){
						%>
							<input type="button" value="����" onclick="qnaDeleteFn(<%= no %>)" class="qna_btn deleteBtn">
							<input type="button" value="�������" onclick="location.href='qna.jsp'" class="qna_btn gotolist">
						<%		
							}else{
						%>
							<input type="button" value="�������" onclick="location.href='qna.jsp'" class="qna_btn gotolist">
						<%		
							}
						%>	
						</div>
						<div>
						<%
							if(gmno==null || gmno.equals("")) {
						%>
							<hr class="hr">
							<span class="aEmpty"><span class="point">*</span>��ϵ� �亯�� �����ϴ�.</span>
						<%
							}else {
						%>		
							<hr class="hr">
							<h2 class="subTitle"><span class="point">*</span>�亯</h2>
							<table border="1" class="aTable" width="1200px;" >
								<tr height="40px">
									<th>����</th>
									<td><%= gmtitle %></td>
									<th>�ۼ���</th>
									<td><%= gmid %></td>
									<th>�亯��</th>
									<td><%= gmwdate %></td>
								</tr>
								<tr>
									<td colspan="6" class="body">
										<%= gmbody %>
									</td>
								</tr>
							</table>
							<%		
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
	<%
	if(rs != null) {
		try {rs.close();} catch (SQLException e) {} 
	}
	if(pstmt != null) {
		try {pstmt.close();} catch (SQLException e) {} 
	}
	if(conn != null) {
		try {conn.close();} catch (SQLException e) {} 
	}
	%>
</html>