<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	    
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>영화 메인</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="../js/mv_main.js"></script>
		
		<!-- css -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Jua&display=swap">
		<link rel="stylesheet" href="../css/common.css">
		<link rel="stylesheet" href="../css/mv_main.css">

	</head>
	<!-- head end -->
	
	<body style="background-color:#2E2D2C;margin:0;">
		<div class="wrap">
			<header style="align: center;">
				<div style="text-align:right;">
				
					<% 
					if(!id.equals(""))
					{
					%>	
						<font style="font-weight:bold;"><%= id %> 님</font>
						<a class="a" href="sessionLogout.jsp">LOGOUT</a> 
					<% 
					} else {
					%> 
						<a class="a" href="sessionLogin.jsp">LOGIN</a>
						<a class="a" href="mv_join.jsp">JOIN</a>	
					<% 	
					}
					%>  
					
				</div>
				<div style="margin-left: 470px">
					<a class="a" href="home.jsp">
						<img src="../img/page/logo.png" name="logo" id="logo" width="300px">
					</a>
				</div>
			</header>
			<!-- header end -->
		
			<nav style="width: 1280px;height: 48px; background-color: #2E2D2C;position: sticky;top:0;">
			   <ul class="menu">
					<li class="menu_li"><a class="menu_a" href="mv_main.jsp">BOXOFFICE</a></li>
					<li class="menu_li"><a class="menu_a" href="mv_list.jsp">REVIEW</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">NEWS</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">TALK</a></li>
					<form name="frm" id="frm" method="post" action="mv_search.jsp">
						<li class="menu_li">
							<select class="search_type" id="select" name="select">
								<option value="1">전체</option>
								<option value="2">한국영화</option>
								<option value="3">해외영화</option>
							</select>
						</li>
						<li class="menu_li">
							<input class="search_text" type="text" id="key" name="key" placeholder="검색어를 입력하세요.">
						</li>
						<li class="menu_li">
							<input class="search_btn" type="submit" value="search">
						</li>
					</form>
				</ul>				
			</nav>	
			<!-- nav end -->

			<section>
				<article>
					<h2>현재 상영작 TOP8</h2>
					<div class="second">		
						<table class="boxoffice">
							<tr>
								<td><div class="td1">NO.1</div></td>
								<td><div class="td1">NO.2</div></td>
								<td><div class="td1">NO.3</div></td>
								<td><div class="td1">NO.4</div></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td><img src="../img/poster/도굴.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/삼진그룹영어토익반.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/담보.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/노트북.jpg" width="250px" height="350px"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td class="td3"><b>도굴</b></td>
								<td class="td3"><b>삼진그룹 영어토익반</b></td>
								<td class="td3"><b>담보</b></td>
								<td class="td3"><b>노트북</b></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td class="td3">2020.11.04 개봉</td>
								<td class="td3">2020.10.21 개봉</td>
								<td class="td3">2020.09.29 개봉</td>
								<td class="td3">2020.11.04 개봉</td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td><div class="td2">NO.5</div></td>
								<td><div class="td2">NO.6</div></td>
								<td><div class="td2">NO.7</div></td>
								<td><div class="td2">NO.8</div></td>
							</tr>
							<tr>
								<td><img src="../img/poster/미스터트롯더무비.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/위플래쉬.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/테넷.jpg" width="250px" height="350px"></td>
								<td><img src="../img/poster/내가죽던날.jpg" width="250px" height="350px"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td class="td3"><b>미스터트롯 : 더 무비</b></td>
								<td class="td3"><b>위플래쉬</b></td>
								<td class="td3"><b>테넷</b></td>
								<td class="td3"><b>내가 죽던 날</b></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td class="td3">2020.11.04 개봉</td>
								<td class="td3">2020.10.28 개봉</td>
								<td class="td3">2020.08.26 개봉</td>
								<td class="td3">2020.11.12 개봉</td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
						<span id="ing"><h1>현재 상영 중</h1></span>		
					</div>
					<div class="rolling_panel">	
					<ul>
						<li><img class="img" src="../img/poster/21브릿지.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/애비규환.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/킹덤오브헤븐.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/소리도없이.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/다만악에서구하소서.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/마틴에덴.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/테슬라.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/걸후드.jpg" width="100px"></li>
						<li><img class="img" src="../img/poster/페뷸러스.jpg" width="100px"></li>
					</ul>
					</div>
					<a href="javascript:void(0)" id="prev"><img src="../img/page/left.png" class="next" width="50px"></a>	
					<a href="javascript:void(0)" id="next"><img src="../img/page/right.png" class="next" width="50px"></a>
				</article>
			</section>
			<!-- section end -->
			
			<footer style="background-color:#2e2d2c;height:100px;">
				<div class="footer">
					<ul>
						<li class="footer_title">       Crew member</li>
						<li class="footer_content">     Kang GoEun</li>
						<li class="footer_content">     Park SuJin</li>
						<li class="footer_content">     Bae MinJu</li>
						<li class="footer_content">     Song EunHye</li>
						<li class="footer_title">&copy; moviesofa</li>
					</ul>
				</div>
			</footer>
			<!-- footer end -->
			
		</div>
	</body>
	<!-- body end -->

</html>