<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../include/openDB.jsp" %>  
<%

//인코딩 및 파라메터 정보
request.setCharacterEncoding("EUC-KR");
String id    = (String)session.getAttribute("idKey");
if(id == null){ id = ""; }
String mv_no = request.getParameter("mv_no"); 

String sql = "";


%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>리뷰 목록</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="../js/alert_login.js"></script>
		<script type="text/javascript">
		
			function noneIdFn() { //로그인하지 않았을 때 글쓰기 버튼 함수
				alert("로그인이 필요한 서비스 입니다. 로그인화면으로 이동합니다.");
				location.href="sessionLogin.jsp";
			}
			
			function IdFn() { //로그인 했을 때 글쓰기 버튼 함수
				location.href="rv_insert.jsp";
			}
			
		</script>
		
		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
	    <link rel="stylesheet" type="text/css" href="../css/mv_detail.css">
	    <link rel="stylesheet" type="text/css" href="../css/mv_list.css"/>
		
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
					
			<div style="clear:both;width:1280px;">
				<div class="rv">
					<div class="rvtxt_box" style="font-size:30px;font-weight:bold;padding-left:30px;">
					
					
						<%
						if(id.equals("")){ //로그인 하지 않았을 때
						%>		
							Review<input type="button" class="rvbtn" value="글쓰기" onclick="noneIdFn()">
						<%
						}else { //로그인 했을 때
						%>
							<form method="post" action="rv_insert.jsp" name="frm" id="frm">
								Review
								<input type="hidden" id="mv_no" name="mv_no" value="<%= mv_no %>">
								<input type="submit" class="rvbtn" value="글쓰기">
							</form>								
						<%
						}
						%>	
						
					</div>

					<%		
					int recordTotal = 0;  //
					int pageno      = 0;  //페이지 번호
					int perpage     = 0;  //페이지당 게시물 수
					int startno     = 0;  //시작번호
					String curpage  = ""; //현재페이지
					
					try
					{
			
						curpage = request.getParameter("page");
						if(curpage == null)
						{
							curpage = "1";
						}
			
						sql = "select count(*) as cnt from review where mv_no=" + mv_no; //선택한 영화의 리뷰수 가져오기
						
						mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mstmt.executeQuery();	
						rs.next();			
						recordTotal = Integer.parseInt(rs.getString("cnt"));
						rs.close();
						mstmt.close();	
						
						
						pageno  = Integer.parseInt(curpage); 
						perpage = 5;
						startno = ((pageno - 1) * perpage);
						
						sql = "select * from review where mv_no=" + mv_no ;
						sql += " order by rv_no desc limit " + startno + "," + perpage;
						
						mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mstmt.executeQuery();	
						
						int i = recordTotal - ((pageno - 1) * perpage);
						
						
						//리뷰 목록 뿌리기
						while(rs.next()) 
						{
							String grv_no     = rs.getString("rv_no");    //리뷰번호
							String grv_writer = rs.getString("id");       //리뷰작성자
							String grv_title  = rs.getString("rv_title"); //리뷰제목
							String grv_body   = rs.getString("rv_body");  //리뷰내용
							String grv_date   = rs.getString("rv_date");  //리뷰작성일
							String grv_file   = rs.getString("rv_file");  //리뷰작성일
			
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
									<td class="rv_title">
										<a href="rv_view.jsp?rv_no=<%= grv_no %>">
											<%= grv_title %>
										</a>
									</td>
								</tr>
								<tr>
									<td class="rv_content" rowspan="2">
										<%= grv_body %>
									</td>
								</tr>
								<tr></tr>		
							</table>	
										
						<%
						}
						
						rs.close();
						mstmt.close();		
						conn.close();
						
					} catch (Exception e)
					{
						out.println("ERROR:" + e.getMessage());
					}
					
					int maxPage = recordTotal / perpage; //최대 페이지 수 결정
					if( ( recordTotal % perpage ) != 0)
					{
						maxPage++;
					}
					
					%>
					
					
					<div class="pagelink">	
					
					
					
						<%
						for (int j = 1 ; j <= maxPage; j++) {
		
						    if (j == pageno) {
						    %> 
						    	<b><a href="rv_list.jsp?page=<%= j %>&mv_no=<%= mv_no %>"><%= j %></a></b>
						    <%
						    } else {
						    %> 
						    	<a href="rv_list.jsp?page=<%= j %>&mv_no=<%= mv_no %>"><%= j %></a> 
						    <%
						    }
						}
						%> 
					</div>	
				</div>	
			</div>			
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