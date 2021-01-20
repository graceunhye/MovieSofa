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
		
		<title>������ ���ô� ��</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/path.css" type="text/css"/>
		
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
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">������ �Ұ�</li>
						<a href="notice.jsp"><li class="left_menu_sub">��������</li></a>
						<a href="calendar.jsp"><li class="left_menu_sub">���� ����</li></a>
						<a href="path.jsp"><li class="on left_menu_sub last_sub">���ô� ��</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">���ô� ��</span>
						<span class="page_map">������ �Ұ� > ���ô� ��</span>
					</div>
					<div class="content">
						<div class="mapWrap">
							<h2><font color="orange">*</font>����</h2>
						<!-- 1. ���� ��� -->
						<div id="daumRoughmapContainer1606983776975" class="root_daum_roughmap root_daum_roughmap_landing"></div>
						
						<!--
							2. ��ġ ��ũ��Ʈ
							* ���� �۰��� ���񽺸� 2�� �̻� ���� ���, ��ġ ��ũ��Ʈ�� �ϳ��� �����մϴ�.
						-->
						<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
						
						<!-- 3. ���� ��ũ��Ʈ -->
						<script charset="UTF-8">
							new daum.roughmap.Lander({
								"timestamp" : "1606983776975",
								"key" : "239tx",
								"mapWidth" : "700",
								"mapHeight" : "400"
							}).render();
						</script>
						<br>
						<br>
						<div>
							<div>
								<h2><font color="orange">*</font>���� ������</h2>
							</div>
							<div class="info_box">
								<ul class="info">
									<li><a href="https://map.kakao.com/?busStopId=BS303532">�������ົ��</a> | <b>99m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS55036">���ϴ����� �����ҹ漭</a> | <b>120m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS303533">���ִ����ҹ漭</a> | <b>155m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS303027">�����Ϻ���</a> | <b>266m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS55841">��������ݾ�����</a> | <b>274m</b></li>
								</ul>
							</div>
						</div>
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