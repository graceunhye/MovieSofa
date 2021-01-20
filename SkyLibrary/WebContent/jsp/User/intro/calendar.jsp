<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>������ ����</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/calendar.css" type="text/css"/>
		
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
									<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='.User/loginout/logout.jsp'">
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
							<li><a href="notice.jsp">������ �Ұ�</a></li>
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
						<li class="left_menu_title">������ �Ұ�</li>
						<a href="notice.jsp"><li class="left_menu_sub">��������</li></a>
						<a href="calendar.jsp"><li class="on left_menu_sub">���� ����</li></a>
						<a href="path.jsp"><li class="left_menu_sub last_sub">���ô� ��</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">���� ����</span>
						<span class="page_map">������ �Ұ� > ���� ����</span>
					</div>
					<div class="content">
					
						<div class="calendar">
							<h2><font color="orange">*</font>�޷�</h2>
							<img src="../../../img/homePage/12Calendar.jpg" width="700" alt="�ӽô޷�" style="margin-top:20px;">
						</div>
						<br>
						<br>
						<div class="info_box">
							<h2><font color="orange">*</font>�̴��� �������</h2>
							<ul class="info">
								<li>�۰����� ����(12��2�� ~ 12��13��)</li>
								<li>��� ���� ���Ⱑ�� �Ǽ� 5��->7��</li>
								<li>�츮���� ��ſ��� �������� ��ȸ</li>
							</ul>
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