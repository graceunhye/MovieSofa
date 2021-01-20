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
		
		<title>도서관 오시는 길</title>
		
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
						<a href="#section"><span class="rightnow_click">본문 바로가기</span></a>
					</div>
						<%
							if(id.equals("") || id == null){
						%>		
								<div class="head_btns">
									<input class="head_btn" type="button" value="로그인" onclick="location.href='../../User/loginout/login.jsp'">
									<input class="head_btn" type="button" value="회원가입" onclick="location.href='../../User/join/join.jsp'">
								</div>
						<%		
							}else {
						%>
								<div class="head_btns">
									<span class="head_id"><%= id %> 님</span>
									<input class="head_btn" type="button" value="로그아웃" onclick="location.href='.User/loginout/logout.jsp'">
								</div>
						<%		
							}
						%>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp"><img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="로고"></a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="../search/total.jsp">도서검색</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="../use/useTime.jsp">도서관 이용</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="notice.jsp">도서관 소개</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="javascript:needLoginFn('<%= id %>')" class="myPage">마이페이지</a></li>
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">도서관 소개</li>
						<a href="notice.jsp"><li class="left_menu_sub">공지사항</li></a>
						<a href="calendar.jsp"><li class="left_menu_sub">월별 일정</li></a>
						<a href="path.jsp"><li class="on left_menu_sub last_sub">오시는 길</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">오시는 길</span>
						<span class="page_map">도서관 소개 > 오시는 길</span>
					</div>
					<div class="content">
						<div class="mapWrap">
							<h2><font color="orange">*</font>지도</h2>
						<!-- 1. 지도 노드 -->
						<div id="daumRoughmapContainer1606983776975" class="root_daum_roughmap root_daum_roughmap_landing"></div>
						
						<!--
							2. 설치 스크립트
							* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
						-->
						<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
						
						<!-- 3. 실행 스크립트 -->
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
								<h2><font color="orange">*</font>버스 정류장</h2>
							</div>
							<div class="info_box">
								<ul class="info">
									<li><a href="https://map.kakao.com/?busStopId=BS303532">전북은행본점</a> | <b>99m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS55036">전북대정문 덕진소방서</a> | <b>120m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS303533">전주덕진소방서</a> | <b>155m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS303027">전북일보사</a> | <b>266m</b></li>
									<li><a href="https://map.kakao.com/?busStopId=BS55841">국민은행금암지점</a> | <b>274m</b></li>
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