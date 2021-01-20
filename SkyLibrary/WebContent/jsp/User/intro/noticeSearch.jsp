<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	request.setCharacterEncoding("EUC-KR");
	String select = request.getParameter("select");
	String keyword = request.getParameter("keyword");
	
	if(select == null)
	{
		select = "1";
	}
	if(keyword == null)
	{
		keyword = "";
	}
	
	Connection        conn;
	PreparedStatement mStmt;
	ResultSet         rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );

%> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>공지사항</title>
	
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/noticeSearch.css" type="text/css"/>
		
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
							<li><a href="notice.jsp">도서관 소개</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<%
								if(id==null || id.equals("")){
							%>
									<li><a onclick="alert('로그인 후 이용 가능한 서비스 입니다.')" class="myPage">마이페이지</a></li>
							<%
								}else{
							%>
									<li><a href="../myPage/userInfo.jsp">마이페이지</a></li>
							<%		
								}
							%>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
			
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">도서관 소개</li>
						<a href="notice.jsp"><li class="on left_menu_sub">공지사항</li></a>
						<a href="calendar.jsp"><li class="left_menu_sub">월별 일정</li></a>
						<a href="path.jsp"><li class="left_menu_sub last_sub">오시는 길</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">공지사항</span>
						<span class="page_map">도서관 소개 > 공지사항</span>
						<div class="content">
							<div class="selectBox">
								<form id="frm" name="frm" method="post" action="noticeSearch.jsp">
									<select id="select" class="select" name="select">
									<%
									if( select.equals("1") )
									{
										%><option value="1" selected>전체</option><%
									}else
									{
										%><option value="1">전체</option><%									
									}
									if( select.equals("2") )
									{
										%><option value="2" selected>제목</option><%
									}else
									{
										%><option value="2">제목</option><%									
									}
									if( select.equals("3") )
									{
										%><option value="3" selected>내용</option><%
									}else
									{
										%><option value="3">내용</option><%									
									}									
									%>
									</select>
									<input type="text" name="keyword" id="keyword" class="searchbox" value="<%= keyword %>">
									<input type="submit" value="검색" class="search_btn">
								</form>
							</div>		
							<br>
							<br>
							<table class="content_table" style="border-collapse:collapse" width="1200px">
							<tr class="top_tr">
								<th align="center" class="top_td">글번호</th>
								<th align="center" class="top_td">제목</th>
								<th align="center" class="top_td">작성자</th>
								<th align="center" class="top_td">작성일</th>
								<th align="center" class="top_td">조회수</th>
							</tr>
							<%
							
							//변수값 정보
							int recordTotal = 0; 
							int pageno      = 0; 
							int perpage     = 5; 
							int startno     = 0; 
							
							try
							{					
								String curpage = request.getParameter("page");
								if(curpage == null)
								{
									curpage = "1";
								}
								
								String sql = "";
								String where = "";
		
								//select 값에 따른 sql문
								if( !keyword.equals(""))
								{
									switch(select) {
									case "1": //전체
										where = " title like '%"+keyword+"%' or body like '%" + keyword + "%' ";
										break;
									case "2": //제목
									where = " title like '%"+keyword+"%' ";
										break;
									case "3": //내용
										where = " body like '%"+keyword+"%' ";
										break;
									}
								}			
			
								//공지사항 개수 조회
								sql = "select count(*) as cnt from notice ";
								if( !where.equals(""))
								{
									sql += " where " + where;
								}
								mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs = mStmt.executeQuery();	
								rs.next();
								
								recordTotal = Integer.parseInt(rs.getString("cnt"));
								
								rs.close();
								mStmt.close();	
								
								pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
								perpage = 5;
								startno = ((pageno - 1) * perpage);
								
								sql =  "select no,mid,title,body,ndate,nhit ";
								sql += "from notice ";
								if( !where.equals(""))
								{
									sql += " where " + where;
								}						
								sql += "order by no desc ";
								sql += "limit " + startno + "," + perpage;
		
								mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs = mStmt.executeQuery();	
		
								int i = recordTotal - ((pageno - 1) * perpage);
								
								//공지사항 정보 뿌리기
								while(rs.next())
								{
									String vNo       = rs.getString("no");
									String vMid      = rs.getString("mid");
									String vTitle    = rs.getString("title");
									String vBody     = rs.getString("body");
									String vNdate    = rs.getString("ndate");
									String vNhit     = rs.getString("nhit");
			
								%> 	
								<tr class="mid_tr">
									<th align="center" class="mid_td"><%= i-- %></th>
									<td><a href="noticeView.jsp?no=<%= vNo %>" class="mid_td"><%= vTitle %></a></td>
									<td align="center" class="mid_td"><%= vMid %></td>
									<td align="center" class="mid_td"><%= vNdate %></td>
									<td align="center" class="mid_td"><%= vNhit %></td>
								</tr>												
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
		
							</table>
							<br>
							<br>
							<%
							
							int BLOCK = 5;
							int startPage = ((pageno-1)/BLOCK*BLOCK)+1;
							int endPage = ((pageno-1)/BLOCK*BLOCK)+BLOCK;
		
							int maxPage = recordTotal / perpage;
							
							if( ( recordTotal % perpage ) != 0)
							{
								maxPage++;
							}
							
							if(maxPage < pageno){
								pageno = maxPage;
							}
							
							if(endPage > maxPage)
							{
								endPage = maxPage;
							}
							
							String pageword = URLEncoder.encode(keyword,"utf-8");
							
							
							%>
								<div class="notice_page">	
								<%
									if(pageno > BLOCK) {
										%><a href="noticeSearch.jsp?page=1&select=<%= select %>&keyword=<%= pageword %>">맨앞으로</a><% 
										%><a href="noticeSearch.jsp?page=<%=startPage - 1%>&select=<%= select %>&keyword=<%= pageword %>">이전</a><% 
									}
									
									for (int j = startPage ; j <= endPage; j++) {
									    if (j == pageno) {
									        %> <b><a href="noticeSearch.jsp?page=<%= j %>&select=<%= select %>&keyword=<%= pageword %>"><%= j %></a></b><%
									    } else {
									    	 %> <a href="noticeSearch.jsp?page=<%= j %>&select=<%= select %>&keyword=<%= pageword %>"><%= j %></a> <%
									    }
									}
									
									if (endPage < maxPage) {
										%> <a href="noticeSearch.jsp?page=<%= endPage + 1%>&select=<%= select %>&keyword=<%= pageword %>">다음</a><%
										%> <a href="noticeSearch.jsp?page=<%= maxPage %>&select=<%= select %>&keyword=<%= pageword %>">맨뒤로</a><%		
									}
								%> 
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