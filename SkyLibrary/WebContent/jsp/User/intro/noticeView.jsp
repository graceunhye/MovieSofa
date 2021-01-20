<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
	
	String no = request.getParameter("no");	

	Connection conn;
	PreparedStatement mstmt;
	ResultSet rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
	
	
	String sql = "";
	
	/** 조회수 증가  **/
	sql  = "update notice ";
	sql += "set nhit=nhit+1 ";
	sql += "where no="+no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	mstmt.executeUpdate();
	mstmt.close();
	
	
	sql = "select no,mid,title,body,ndate,nhit,nfile ";
	sql += "from notice ";
	sql += "where no=" + no;

	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	String vNO        = rs.getString("no");    //공지사항번호
	String vMid       = rs.getString("mid");   //사서아이디
	String vTitle     = rs.getString("title"); //공지사항제목 
	String vBody      = rs.getString("body");  //공지사항내용
	String vNdate     = rs.getString("ndate");
	String vNhit      = rs.getString("nhit");
	String vNfile     = rs.getString("nfile"); //공지사항첨부파일	

%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>공지사항</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/noticeView.css" type="text/css"/>
		
		<script src="../../../js/common.js"></script>
		<script src="../../../js/jquery-3.5.1.min.js"></script>
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
								<input class="head_btn" type="button" value="회원가입" onclick="location.href='./User/join/join.jsp'">
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
					<span class="page_map">도서관 소개 > 공지사항 > 공지사항 보기</span>
				</div>
				<div class="content_view">
					<table width="1200">
						<tr class="top_tr">
							<th align="center" height="40px" width="15%" class="top_td" width="50">제목</th>
							<td colspan="2" class="top_td"><%= vTitle %></td>	
						</tr>		
						<tr class="mid_tr">
							<th align="center">작성일</th>
							<td><%= vNdate %></td>
						</tr>
						<tr class="mid_tr">
							<th align="center">조회수</th>
							<td><%= vNhit %></td>
						</tr>	
						<tr class="mid_tr">
							<th align="center" height="400px" class="mid_tr">내용</th>
							<td colspan="2">
								<%
									if(vNfile != null) {
										%>
										<img src="../../Manager/mnotice/noticeFileDown.jsp?type=img&nfile=<%= vNfile %>">
										<%= vBody %>
										<%
									} else {
										%><%= vBody %><%
									}
								%>
							</td>	
						</tr>
						<tr class="mid_tr">
							<th align="center" height="50px">첨부파일</th>
							<td colspan="2">
								<%
									if(vNfile != null){
										%>
										<a href="../../Manager/mnotice/noticeFileDown.jsp?nfile=<%= vNfile %>"><%= vNfile %></a>
										<%
									} else {
										%><%
									}
								%>
							</td>
						</tr>
					</table>
					<br>
					<br>
					<div class="view_btn">
						<input class="listBtn" type="button" value="목록으로" onclick="location.href='notice.jsp'">
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