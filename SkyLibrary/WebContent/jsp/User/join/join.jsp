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
		
		<title>회원가입</title>
		
		<link rel="stylesheet" href="../../../css/mainCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/join.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="../../../js/join.js"></script>
		<script src="../../../js/common.js"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
			<header>
				<div class="head_option">
					<div class="rightnow">
						<a href="#"><span class="rightnow_click">본문 바로가기</span></a>
					</div>
					<div class="head_btns">
						<a href="../loginout/login.jsp"><input class="head_btn" type="button" value="로그인"></a>
						<a href="../join/join.jsp"><input class="head_btn" type="button" value="회원가입"></a>
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
			
			<section>
				<div class="section">
					<span class="top_title">회원가입</span>
					<br>
					<br>
					<form method="post" class="joinfrm" name="joinfrm" action="joinOk.jsp">
						<div class="joinbox">
							<table style="width:550px; height:700px; border-collapse:collapse; margin-left:25px;" >
								<tr>
									<td>아이디<span class="star">*</span></td>
									<td>
										<input type="text" id="id" name="id">&nbsp;
										<input type="button" class="joinbtn1" onclick="ID_check()" value="중복확인">
										<a id="id_message"></a>
									</td>
								</tr>
								<tr>
									<td>비밀번호<span class="star">*</span></td>
									<td><input type="password" id="pw1" name="pw1" onblur="Password_check()"><p/><a id="password_message"></a></td>
								</tr>
								<tr>
									<td>비밀번호 확인<span class="star">*</span></td>
									<td><input type="password" id="pw2" name="pw2" onblur="Password_check2()"><p/><a id="password_message2"></a></td>
								</tr>
								<tr>
									<td>이름<span class="star">*</span></td>
									<td><input type="text" id="name" name="name"></td>
								</tr>
								<tr>
									<td>이메일<span class="star">*</span></td>
									<td>
										<input type="text" id="email1" name="email1"> @
										<select name="email2">
											<option value="e1">naver.com
											<option value="e2">nate.com
											<option value="e3">gmail.com
										</select>
									</td>
								</tr>
								<tr>
									<td>연락처<span class="star">*</span></td>
									<td>
										<select name="num1">
											<option value="010">010
											<option value="011">011
											<option value="016">016										
										</select>
										 -
										<input type="text" id="num2" name="num2" maxlength="4">
										 - 
										<input type="text" id="num3" name="num3" maxlength="4">	
									</td>
								</tr>
								<tr>
									<td>주소</td>
									<td>
										<input type="text" id="postnum" name="postnum" size="7">&nbsp;
										<input type="button" class="joinbtn1" value="우편번호 찾기" onclick="PostOpen()"><br>
										<input type="text" id="addr1" name="addr1" size="50"><br>
										<input type="text" id="addr2" name="addr2" size="50">
									</td>
								</tr>
							</table>
							<br>
						</div>
						<br>
						<button type="button" class="joinbtn2" onclick="Submit()">가입</button>
					</form>
				</div>	
			</section>
			<!-- section end -->
			
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
			
		</div>
	</body>
</html>