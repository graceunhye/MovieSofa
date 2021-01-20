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
		
		<title>�ϴ� ������ ����</title>
		
		<link rel="stylesheet" href="../css/mainCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../css/mainSection.css" type="text/css"/>
		
		<script src="../js/jquery-3.5.1.min.js"></script>
		<script src="../js/main.js" type="text/javascript"></script>
	</head>
	<body style="margin:0px" onload="loadFn()">
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
								<input class="head_btn" type="button" value="�α���" onclick="location.href='./User/loginout/login.jsp'">
								<input class="head_btn" type="button" value="ȸ������" onclick="location.href='./User/join/join.jsp'">
							</div>
					<%		
						}else {
					%>
							<div class="head_btns">
								<span class="head_id"><%= id %> ��</span>
								<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='./User/loginout/logout.jsp'">
							</div>
					<%		
						}
					%>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="main.jsp"><img class="logoImg" src="../img/homePage/logo.png" width="400" alt="�ΰ�"></a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="./User/search/total.jsp">�����˻�</a></li>
							<li class="rain"><img src="../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="./User/use/useTime.jsp">������ �̿�</a></li>
							<li class="rain"><img src="../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="./User/intro/notice.jsp">������ �Ұ�</a></li>
							<li class="rain"><img src="../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="./User/myPage/userInfo.jsp">���� ������</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<div class="section">
					<div class="banner">
						<a href="#"><span class="angle_left angle">&lt;&lt;</span></a>
						<img class="img" src="../img/homePage/banner1.png">
						<a href="#"><span class="angle_right angle">&gt;&gt;</span></a>
					</div>
					<br/><hr class="hr"/><br/>
					<div class="sub_content">
						<span class="sub_title newbook">��������</span>
						<div class="book"> 
							<ul class="book_list" id="book">
							</ul>
						</div>
						<div class="notice">
							<table class="notice_table">
								<tr height="50px">
									<td colspan="4"><span class="sub_title">��������</span></td>
								</tr>
								<tr>
									<td class="table_underline" align="center" width="40px">��ȣ</td>
									<td class="table_underline" align="center" width="320px">����</td>
									<td class="table_underline" align="center">�ۼ���</td>
								</tr>
								<tbody id="notice">
									
								</tbody>
								<tr height="20px">
									<td colspan="4" align="right"><a class="more" href="./User/intro/notice.jsp"><span class="notice_more">������</span></a></td>
								</tr>
							</table>
						</div>
						<div class="intro">
							<table class="intro_table" width="640">
								<tr>
									<td colspan="2"><span class="sub_title">������ �̿�ȳ�</span></td>
								</tr>
								<tr height="180px">
									<td align="left"  width="250px;" height="50px" class="line_right intro_info">
										<span class="point2">������, ������ �޹�</span><br>
										<span class="point2">����</span> ���� 09:00 ~ ���� 18:00<br>
										<span class="point2">�ָ�</span> ���� 10:00 ~ ���� 18:00<br>
										<font color="orange">*</font><font class="font">�� ������ ������ ���� ���� �� �� �ֽ��ϴ�.</font><br>
										<a href="./User/use/useTime.jsp"><span class="more use_time_more">������</span></a>
									</td>
									<td>
										<img class="sub_banner" src="../img/homePage/sub_banner1.jpg" width="300px"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->
			
			<footer>
				<div class="footer">
					<div class="footerUlWrapLeft">
						<ul class="kind">
							<li>
								<a href="../../main.jsp">
									<img class="footerLogo" src="../img/homePage/logo.png" width="250" alt="�ΰ�">
								</a>
							</li>
						</ul>
					</div>
					<div class="footerUlWrapRight">
						<ul class="kindn">
							<li class="footerTitle">�缭</li>
							<li class="normal">Song  EunHye</li>
							<li class="normal">Park  Sujin</li>
							<li class="normal">Kang  GoEun</li>
						</ul>
						<ul class="kindn">
							<li class="footerTitle">���۱Ⱓ</li>
							<li class="normal"><span class="footerSubTitle">1�� :: </span>2020.12.03 ~ 2020.12.31</li>
							<li class="normal"><font color="orange">&copy;</font> Sky Library</li>
						</ul>
					</div>
				</div>
			</footer>
			<!-- footer end -->
			
		</div>
	</body>
</html>