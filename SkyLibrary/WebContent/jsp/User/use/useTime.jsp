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
		
		<title>이용 시간 안내</title>
		
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
								<input class="head_btn" type="button" value="로그아웃" onclick="location.href='../../User/loginout/logout.jsp'">
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
						<li><a href="../intro/notice.jsp">도서관 소개</a></li>
						<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
						<li><a href="javascript:needLoginFn('<%= id %>')" class="myPage">마이페이지</a></li>
					</ul>
				</nav>
			</div>
		</header>
		<!-- header end -->
		
		<section id="section">
			<nav class="left_menu">
				<ul>
					<li class="left_menu_title">도서관 이용</li>
					<a href="useTime.jsp"><li class="on left_menu_sub">이용시간</li></a>
					<a href="useGuide.jsp"><li class="left_menu_sub">대출/반납/예약/연장</li></a>
					<a href="qna.jsp"><li class="left_menu_sub last_sub">질의응답</li></a>
				</ul>
			</nav>
			<div class="section">
				<div class="section_top">
					<span class="top_title">이용시간</span>
					<span class="page_map">도서관 이용 > 이용시간</span>
				</div>
				<div class="content">		
					<h3><font color="orange">*</font>자료실 운영시간</h3>
					<table class="timeTable" border="1">
						<tr>
							<th>일반</th>
							<th>주말</th>
						</tr>
						<tr>
							<td>오전 9시 ~ 오후 7시</td>
							<td>오전 9시 ~ 오후 5시</td>
						</tr>
					</table>		
					<span class="tip"><font color="orange">※</font>월요일.법정공휴일은 <font color="orange">휴관</font></span>
				</div>	
			</div>
		</section>
		<!-- section end -->
		
		<jsp:include page="../include/footer.jsp"/>
		<!-- footer end -->
		
		</div>
	</body>
</html>