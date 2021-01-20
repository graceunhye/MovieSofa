<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%

	String id = (String)session.getAttribute("idKey");
	if(id == null ){id= "";}
	
	
%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�������� �ۼ��ϱ�</title>
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
					<div class="head_btns" id="head_btns">
					</div>
				<%
				if(id.equals("") || id == null){
				%>		
					<div class="head_btns">
						<input class="head_btn" type="button" value="�α���"  onclick="location.href='../../User/loginout/login.jsp'">
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
							<li><a href="javascript:needLoginFn(<%= id %>)" class="myPage">����������</a></li>
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
				<div class="section">
					<div class="section_top">
						<span class="top_title">��������</span>
						<span class="page_map">������ �̿� > �������� > �����ϱ�</span>
					</div>
					<div class="content">
						<div class="qInsertTableWrap">
							<form action="qnaInsertOk.jsp" method="post">
								<table class="qInsertTable">
									<tr>
										<th align="center" width="100">����</th>
										<td class="qInsertTableTd">
											<input type="text" size="115" placeholder="������ �Է����ּ���."  name="title">
										</td>
									</tr>
									<tr>
										<th>����</th>
										<td width="800" height="400" class="qInsertTableTd">
											<textarea name="body" cols="120" rows="25" placeholder="������ �Է����ּ���." style="resize:none"></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div align="right">
												<input type="submit" value="����ϱ�" class="qna_btn">
												<input type="button" value="����ϱ�" onclick="qnaInsertCancelFn()" class="qna_btn">
											</div>
										</td>
									</tr>
								</table>
							</form>
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