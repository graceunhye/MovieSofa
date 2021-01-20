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
		<title>질의응답 작성하기</title>
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
						<a href="#section"><span class="rightnow_click">본문 바로가기</span></a>
					</div>
					<div class="head_btns" id="head_btns">
					</div>
				<%
				if(id.equals("") || id == null){
				%>		
					<div class="head_btns">
						<input class="head_btn" type="button" value="로그인"  onclick="location.href='../../User/loginout/login.jsp'">
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
							<li><a href="javascript:needLoginFn(<%= id %>)" class="myPage">마이페이지</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">도서관 이용</li>
						<a href="useTime.jsp"><li class="left_menu_sub">이용시간</li></a>
						<a href="useGuide.jsp"><li class="left_menu_sub">대출/반납/예약/연장</li></a>
						<a href="qna.jsp"><li class="on left_menu_sub last_sub">질의응답</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">질의응답</span>
						<span class="page_map">도서관 이용 > 질의응답 > 질문하기</span>
					</div>
					<div class="content">
						<div class="qInsertTableWrap">
							<form action="qnaInsertOk.jsp" method="post">
								<table class="qInsertTable">
									<tr>
										<th align="center" width="100">제목</th>
										<td class="qInsertTableTd">
											<input type="text" size="115" placeholder="제목을 입력해주세요."  name="title">
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td width="800" height="400" class="qInsertTableTd">
											<textarea name="body" cols="120" rows="25" placeholder="내용을 입력해주세요." style="resize:none"></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div align="right">
												<input type="submit" value="등록하기" class="qna_btn">
												<input type="button" value="취소하기" onclick="qnaInsertCancelFn()" class="qna_btn">
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