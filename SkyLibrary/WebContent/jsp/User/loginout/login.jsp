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
		
		<title>로그인</title>
		
		<link rel="stylesheet" href="../../../css/mainCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/loginoutSection.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/login.js"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
			<header>
				<div class="head_option">
					<div class="rightnow">
						<a href="#section"><span class="rightnow_click">본문 바로가기</span></a>
					</div>
					<div class="head_btns">
						<input class="head_btn" type="button" value="로그인" onclick="location.href='login.jsp'">
						<input class="head_btn" type="button" value="회원가입" onclick="location.href='../join/join.jsp'">
					</div>
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
			<div class="section">
				<div class="login_box">
				<h2 class="login_title">로그인</h2>
					<div class="login_input_box">
						<form action="loginProc.jsp" method="post" name="login_frm">
							<table>
								<tr height="50" class="login_txt">
									<td width="100" align="right" class="login_input"><span class="point id">*</span><span class="id_title">아이디</span>:</td>
									<td width="300"><input type="text" class="input" name="id" size="38" placeholder=" 아이디를 입력해주세요."></td>
								</tr>
								<tr height="50" class="login_txt">
									<td align="right" class="login_input"><span class="point">*</span>비밀번호:</td>
									<td><input type="password" name="pw"  class="input" size="38" placeholder=" 비밀번호를 입력해주세요."></td>
								</tr>
								<tr class="login_option">
									<td colspan="2" align="center">
										<a href="#">아이디/비밀번호찾기</a>
										<font color="#2C78D7">&nbsp;|&nbsp;</font>
										<a href="../join/join.jsp">회원가입</a>
										<font color="#2C78D7">&nbsp;|&nbsp;</font>
										<a href="javascript:m_login()">사서 로그인</a>
									</td>
								</tr>
								<tr height="70">
									<td colspan="2" align="center">
										<button type="button" class="login_btn" onclick="login()" >로그인</button>
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