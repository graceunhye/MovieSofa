<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>  
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	    
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>영화 목록</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
	    
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
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
	
	<h3>영화 리뷰 보기</h3>			
	<section>
	<article>

		<%		
		
		Connection        conn;
		PreparedStatement mStmt;
		ResultSet         rs;
		
		String     mDBMS     = "jdbc:mysql://localhost:3306/moviesofa?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		String     mUserID   = "root";
		String     mUserPass = "mySQL1234";
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );

		
		//변수값 정보
		int recordTotal = 0; //영화이미지 총 갯수
		int pageno      = 0; //페이지번호
		int perpage     = 0; //한 페이지당 게시물 수
		int startno     = 0; //시작번호
		
		
		try
		{
			
			String sql;
			
			String curpage = request.getParameter("page");
			if(curpage == null)
			{
				curpage = "1";
			}

			//영화이미지 갯수 조회
			sql = "select count(*) as cnt from movieimg ";
			
			mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = mStmt.executeQuery();	
			rs.next();
			
			recordTotal = Integer.parseInt(rs.getString("cnt"));
			
			rs.close();
			mStmt.close();	
			//영화이미지 갯수  조회 종료
			

			pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
			perpage = 10;
			startno = ((pageno - 1) * perpage);
			
			
			
			//한페이지에 올릴 영화이미지 정보 조회
			sql = "select mv_no, mv_img, mv_title from movieimg order by mv_no ";
			sql += "limit " + startno + "," + perpage;
			
			mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = mStmt.executeQuery();	
			
			
			int i = recordTotal - ((pageno - 1) * perpage);
			
			
			//영화 정보 뿌리기
			while(rs.next())
			{
				String vMovieno    = rs.getString("mv_no");    //영화번호
				String vMovieimage = rs.getString("mv_img");   //영화이미지
				String vMovietitle = rs.getString("mv_title"); //영화제목
			%> 
			
				<ul class="gallery">
					<li>
						<a href='mv_view.jsp?mv_no=<%= vMovieno %>'>
							<img src="../img/poster/<%= vMovieimage %>" width='200px' height='290px' alt=<%= vMovietitle %>>
						</a>
						<br>
						<%= vMovietitle %>
					</li>
				</ul>	
										
			<%
			}
			
			rs.close();
			mStmt.close();		
			conn.close();
			
		} catch (Exception e)
		{
			out.println("ERROR:" + e.getMessage());
		}
		%>
		<%
		
		int maxPage = recordTotal / perpage;
		if( ( recordTotal % perpage ) != 0)
		{
			maxPage++;
		}

		%>
			<div class="pagelink">	
				<%
				for (int j = 1 ; j <= maxPage; j++) {

				    if (j == pageno) {
				        %> <b><a href="mv_list.jsp?page=<%= j %>"><%= j %></a></b><%
				    } else {
				    	 %> <a href="mv_list.jsp?page=<%= j %>"><%= j %></a> <%
				    }
				}
				%> 
			</div>	
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
		</div>	
	<!-- footer end -->			
</body>
	<!-- body end -->
</html>