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
		
		<title>��� ���� ��û</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/wish.css" type="text/css"/>
		
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
						<input class="head_btn" type="button" value="�α���" onclick="location.href='../../loginout/login.jsp'">
						<input class="head_btn" type="button" value="ȸ������" onclick="location.href='../../join/join.jsp'">
					</div>
				<%		
				}else {
				%>
					<div class="head_btns">
						<span class="head_id"><%= id %> ��</span>
						<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../loginout/logout.jsp'">
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
						<a href="wish.jsp"><li class="on left_menu_sub">������� ��û</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">������� ��û</span>
						<span class="page_map">���������� > ������� ��û</span>
					</div>
					<div class="content">
						<article class="article">
							<div class="contentPart">
								<h3><font color="orange">*</font>������� ��û �ȳ�</h3>
								<ul class="info1">
									<li>��û�� ���� 1�� 3�� �̳�(�Ǵ� 5���� ����)</li>
									<li>��û��� : ���ົ(���Ӱ��๰, �񵵼�(����å, ������� ��)�� ��û ����)</li>
									<li>������� ���� : ������ �����ȸ ���Ǹ� ���� ������</li>
								 	<li>������� ��ġ �˸� : SMS ����(�ȳ� ���� ������ ���� ���������������� SMS ���� üũ Ȯ��)</li>
									<li>�켱����Ⱓ : ��û������ ���� ��ġ�Ϸκ��� �ָ����� </li>
								</ul>
							</div>
						</article>
						<div class="contentPart">
							<h3><font color="orange">*</font>������� ���� ���ܱ���</h3>
							<table class="wishInfoTable" border="1">
								<thead>
									<tr>
										<th scope="col">�� ��</th>
										<th scope="col">��  ��</th>
										<th scope="col">�� �� </th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="subTitle">����</td>
										<td>5���� �̻��� ����</td>
										<td class="">&nbsp;</td>
									</tr>
									<tr>
										<td rowspan="11" class="subTitle">��������</td>
										<td>���嵵��, �ߺ� ��û����, �Ű� ���� ��������</td>
										<td class="">&nbsp;</td>
									</tr>
									<tr>
										<td>������, ���輭, ����, ���б���, ��������</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>���������� �Һи��� ����</td>
										<td>����, ���ڸ�, ���ǻ� ��</td>
									</tr>
									<tr>
										<td>��Ÿ��,  �θǽ�, ������, ���θ�ȭ(�н���ȭ ����)</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>����</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>��ǳ���, ������ ������ ������ �� �ִ� ���ص���</td>
										<td>��������, ���¹� ��</td>
									</tr>
									<tr>
										<td>���� �Ǵ� ��ġ ������ ��û����</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>���� �� ������ ������ ���� ���� ���� ����</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>������ �������� ���� ������ ����</td>
										<td>��ĥ, ��ƼĿ, ����, �÷����� �� ������ ���� ����</td>
									</tr>
									<tr>
										<td>����� ������ ���� �� ��û�� ���</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>���Ⱓ�๰(���� �� ���Ӱ��๰)</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="subTitle">�Լ����ɼ�</td>
										<td>ǰ�� �� ���� ����, ���Ⱓ����</td>
										<td>������� ���������� ���߿� �Ǹŵ��� ���� �ڷ�</td>
									</tr>
									<tr>
										<td class="subTitle">�ֽż�</td>
										<td>����� �� 5�� �̻��� ����</td>
										<td>��ǻ��, ����, ���й� �оߴ� ���ǵ� �� 2�� �̻��� �ڷ�</td>
									</tr>
								</tbody>
							</table>
						</div>
						<p class="tip"><font color="orange">��</font> ��û�Ͻ� �ڷ�� �ڷἱ������ȸ�� ���Ǹ� ���� ����, ���� �� �̿��ڿ��� �����˴ϴ�.</p>
						
						<div class="contentPart">
							<h3><font color="orange">*</font>������� ���� Ȯ��</h3>
							<ul class="info2">
								<li>��û�� : ������� ����ڰ� ���� Ÿ�缺 ���� �� �������� Ȯ�� ���� ����</li>
								<li><font color="blue">ó����</font> : ��������� ���Կ� �ݿ��Ͽ� �ֹ� ���� ����</li>
								<li><font color="red">��ҵ�</font> : ���Կ��� ���ܵ� ����(��� ���� Ȯ�� ����)</li>
								<li><font color="green">������</font> : ��������� �ڷ�ǿ� ��ġ�� ����</li>
							</ul>
						</div>
						<div class="wishBtns">
							<input type="button" onclick="wishNeedLoginFn(0)" value="��û�ϱ�" class="wishBtn">
							<input type="button" onclick="wishNeedLoginFn(1)" value="��ûȮ��" class="wishBtn">
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