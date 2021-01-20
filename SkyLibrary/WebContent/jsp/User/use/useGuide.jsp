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
		
		<title>�̿� �ȳ�</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/useGuide.css" type="text/css"/>
		
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
						<a href="useTime.jsp"><li class="left_menu_sub">�̿�ð�</li></a>
						<a href="useGuide.jsp"><li class="on left_menu_sub">����/�ݳ�/����/����</li></a>
						<a href="qna.jsp"><li class="left_menu_sub last_sub">��������</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">�̿�ð�</span>
						<span class="page_map">������ �̿� > ����/�ݳ�/����/����</span>
					</div>
					<div class="content">
						<div class="guide">
							<h3><font color="orange">*</font>����</h3>
							<table border="1" width="800px" class="guideTable">
								<tr>
									<th>����</th>
									<th>����</th>
								</tr>
								<tr>
									<td class="subTitle">����Ǽ�</td>
									<td>1���� 1�� 10��</td>
								</tr>
								<tr>
									<td class="subTitle">������</td>
									<td>����
										<br>-14�� �̸��� ��ȣ�ڰ� ��� ���� ����
									</td>
								</tr>
								<tr>
									<td class="subTitle">ȸ�������ڰ�</td>
									<td>-���ֽ� ����</td>
								</tr>
								<tr>
									<td class="subTitle">ȸ������</td>
									<td>-���������� ���� ���� ȸ������</td>
								</tr>
								<tr>
									<td class="subTitle">���� �ڷ�</td>
									<td>�Ϲݵ���</td>
								</tr>
								<tr>
									<td class="subTitle">����Ⱓ</td>
									<td>14�� (1ȸ ���Ͽ� 7�� ���� ����)</td>
								</tr>
								<tr>
									<td class="subTitle">�ݳ���ü</td>
									<td>��ü�ϼ���ŭ ���� ����</td>
								</tr>
							</table>
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>�ݳ�</h3>
							- ������ �ڷ�� �ȳ�����ũ
							<br>
							- ���ιݳ��� (����� ������)
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>����</h3>
							- ����� ������ ���Ͽ� 1�� 2�Ǳ��� ���� �����մϴ�.
							<br>
							- ���� ������ ���Ͽ� 1�θ� ���� �����մϴ�. 
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>����</h3>
							- 1ȸ ���Ͽ� 7�� ���� �����մϴ�.
							<br>
							- ���� ����, ���൵���� ������ �Ұ����մϴ�.
							<br>
							- ��ü ȸ���� ��� ���� ��û�� �Ұ����մϴ�.
							<br>
							- ��� : ������ Ȩ������ �α���->���� ������->���⵵��/�����û
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>���⿬ü</h3>
							- ���⿬ü �ݳ������� �Ѱܼ� �ݳ��� ��� ��ü �ϼ���ŭ ������ �Ұ����մϴ�.
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>�����</h3>
							- �����ڰ� ���� ��� 7�� ���� �������� �����մϴ�.
						</div>
						<div class="guide">
							<h3><font color="orange">*</font>�ڷắ��</h3>
							- �����ڷḦ �Ѽ��ϰų� �н��Ͽ��� ������ ���� �ڷ�� �����ؾ� �մϴ�.
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