<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%@ include file="../include/openDB.jsp" %>    
<%
request.setCharacterEncoding("EUC-KR");
String mv_no = request.getParameter("mv_no");         //영화번호
String id    = (String)session.getAttribute("idKey"); //아이디
if(id == null){ id = ""; }

%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>영화 상세보기</title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="../js/alert_login.js"></script>
		<script type="text/javascript">
		
			function noneIdFn() { //로그인하지 않았을 때 글쓰기 버튼 함수
				alert("로그인이 필요한 서비스 입니다. 로그인화면으로 이동합니다.");
				location.href="sessionLogin.jsp";
			}
			
		</script>
		
		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
	    <link rel="stylesheet" type="text/css" href="../css/mv_detail.css">
		
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

		<%
		String sql = "";
		sql  = "select movieinfo.mv_no as mv_no, movieinfo.mv_type as mv_type, ";
		sql += "movieinfo.mv_thum as mv_thum, movieinfo.mv_title as mv_title, ";
		sql += "movieinfo.mv_gen as mv_gen, movieinfo.mv_date as mv_date, ";
		sql += "movieinfo.mv_dire as mv_dire, movieinfo.mv_act as mv_act, ";
		sql += "movieinfo.mv_story as mv_story, movieinfo.mv_clip as mv_clip ";
		sql += "from movieimg inner join movieinfo ";
		sql += "on movieimg.mv_no = movieinfo.mv_no ";
		sql += "where movieinfo.mv_no =" + mv_no + "";

		mstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs = mstmt.executeQuery();
		rs.next();	

		
		/**  영화정보 가져오기  **/
		String	gmv_no    = rs.getString("mv_no");      //영화번호
		String	gmv_type  = rs.getString("mv_type");	//영화타입(한국:k(korea),외국:w(world))		
		String	gmv_thum  = rs.getString("mv_thum");    //영화썸네일
		String	gmv_title = rs.getString("mv_title");   //영화제목
		String	gmv_gen   = rs.getString("mv_gen");     //영화장르
		String	gmv_date  = rs.getString("mv_date");    //영화개봉일
		String	gmv_dire  = rs.getString("mv_dire");    //영화감독
		String	gmv_act   = rs.getString("mv_act");     //영화배우들
		String	gmv_story = rs.getString("mv_story");   //영화줄거리
		String  gmv_clip  = rs.getString("mv_clip");    //영화예고편
	
		rs.close();
		mstmt.close();		
		%> 
		
				<div class="mv_section">
					<div class="mvImg">
						<img class="mainImage" src='../img/poster/<%= gmv_thum %>' width="540" height="755">
					</div>
					<div class="mvInfoTable">
						<table class="mvInfo">
							<tr class="mvTitle">
								<td class="titleInfo" colspan="2"><%= gmv_title %></td>
							</tr>				
							<tr class="mvType mvInfotr">
								<td class="type">장르:</td>
								<td class="typeInfo mvInfotd"><%= gmv_gen %></td>
							</tr>						
							<tr class="mvType mvInfotr">
								<td class="type">개봉:</td>
								<td class="typeInfo mvInfotd"><%= gmv_date %></td>
							</tr>
							<tr class="mvDirector">
								<td class="director">감독:</td>
								<td class="directorInfo mvInfotd">
									<%= gmv_dire %> 
								</td>
							</tr>
							<tr class="mvDirector">
								<td class="director">출연:</td>
								<td class="directorInfo mvInfotd">
									<%= gmv_act %> 
								</td>
							</tr>
							<tr>
								<td class="summary" colspan="2">줄거리</td>
							</tr>
							<tr class="mvSummary">
								<td class="summaryInfo mvInfotd" colspan="2">
									<%= gmv_story %>
								</td>
							</tr>
						</table>
					</div>
					<!-- movie info end -->
					
					<div class="mv_clip">
						<div class="clip_title">
							<span>Clip</span>
						</div>
						<div class="video">
							<%= gmv_clip %>
						</div>
					</div>
				</div>	
				<!-- cilp end -->
					
			<div style="clear:both;width:1280px;">
				<div class="rv">
					<div class="rvtxt_box">
						<h1>
								<%
								if(id.equals("")){ //로그인 되지 않았을 때 조건
								%>		
									Review
									<input type="button" class="rvbtn" value="글쓰기" onclick="noneIdFn()">
								<%
								}else { //로그인 됐을 때 조건
								%>
									<form action="rv_insert.jsp" method="post" name="frm" id="frm">
										Review
										<input type="hidden" id="mv_no" name="mv_no" value="<%= gmv_no %>">
										<input type="submit" class="rvbtn" value="글쓰기" >
									</form>
								<%
								}
								%>
						</h1>
					</div>
					
							
			<%
			
			int i = 1;
			int no = Integer.parseInt(request.getParameter("mv_no"));
			PreparedStatement mStmt;
			
			sql =  " select mv_no, rv_no, rv_title, rv_body, rv_date, rv_hit, rv_file ";
			sql += " from review ";
			sql += " where mv_no="+ no;
			sql += " order by rv_no desc ";
			sql += " limit 0,5";
			
			mStmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = mStmt.executeQuery();
			
			
			/** 리뷰들 뿌리기  **/
			while(rs.next())
				{
					String grv_no    = rs.getString("rv_no");     //리뷰번호
					String grv_title = rs.getString("rv_title");  //리뷰제목
					String grv_body  = rs.getString("rv_body");   //리뷰내용
					String grv_date  = rs.getString("rv_date");   //리뷰작성일
					String grv_hit   = rs.getString("rv_hit");    //리뷰조회수
					String grv_file  = rs.getString("rv_file");   //첨부파일명
					
				%> 				
					<table class="rvt_1">	
					<tr>
						<td class="rvt_td" rowspan="3">
							<div class="imgwrap">
								<%
												if(grv_file == null) {
											%>
													<img src="../img/page/review.png" class="rvImg">
											<%		
												}else {
											%>	
													<img src="mv_filedown.jsp?rv_file=<%= grv_file %>" class="rvImg">
											<%		
												}
											%>
							</div>
						</td>
						<td class="rv_title"><a href="rv_view.jsp?rv_no=<%= grv_no %>"><%= grv_title %></a></td>
					</tr>
					<tr>
						<td class="rv_content" rowspan="2">
							<%= grv_body %>
						</td>
					</tr>
					<tr></tr>
					</table>				
				<%
				
				}//while문 종료
				rs.close();
				mStmt.close();
			%>	
					<div style="padding-left: 1100px">
						<br/>
						<form method="post" action="rv_list.jsp" name="frm" id="frm">
							<input type="hidden" id="mv_no" name="mv_no" value="<%= gmv_no %>">
							<input type="submit" class="rvbtn" value="더보기">
						</form>
					</div>
				</div>	
			</div>
			<!-- review end -->						
	
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
		</div>	
		<!-- footer end -->
		
	</body>
	<!-- body end -->
	
</html>