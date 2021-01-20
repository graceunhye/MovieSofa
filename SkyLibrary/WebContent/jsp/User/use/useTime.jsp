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
		
		<title>�̿� �ð� �ȳ�</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/useTime.css" type="text/css"/>
		
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
					<a href="useTime.jsp"><li class="on left_menu_sub">�̿�ð�</li></a>
					<a href="useGuide.jsp"><li class="left_menu_sub">����/�ݳ�/����/����</li></a>
					<a href="qna.jsp"><li class="left_menu_sub last_sub">��������</li></a>
				</ul>
			</nav>
			<div class="section">
				<div class="section_top">
					<span class="top_title">�̿�ð�</span>
					<span class="page_map">������ �̿� > �̿�ð�</span>
				</div>
				<div class="content">		
					<h3><font color="orange">*</font>�ڷ�� ��ð�</h3>
					<table class="timeTable" border="1">
						<tr>
							<th>�Ϲ�</th>
							<th>�ָ�</th>
						</tr>
						<tr>
							<td>���� 9�� ~ ���� 7��</td>
							<td>���� 9�� ~ ���� 5��</td>
						</tr>
					</table>		
					<span class="tip"><font color="orange">��</font>������.������������ <font color="orange">�ް�</font></span>
				</div>	
			</div>
		</section>
		<!-- section end -->
		
		<jsp:include page="../include/footer.jsp"/>
		<!-- footer end -->
		
		</div>
	</body>
</html>