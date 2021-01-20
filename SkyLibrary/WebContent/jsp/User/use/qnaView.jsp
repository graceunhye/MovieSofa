<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%

	request.setCharacterEncoding("EUC-KR");
	String id  = (String)session.getAttribute("idKey"); //아이디
	String no  = request.getParameter("no");            //글번호
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
								+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
	
	
	/** 글번호 no인 게시물 뿌리기 **/
	String sql = "select * from q where no="+no;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	rs.next();
	String gtitle = rs.getString("title");  //질문제목
	String gbody  = rs.getString("body");   //질문내용
	String gwdate = rs.getString("wdate");  //질문일자
	String gid    = rs.getString("id");     //질문자
	String gatype = rs.getString("atype");  //답변여부
	
	rs.close();
	pstmt.close();
	
	/** 글번호 no에 달린 답글 뿌리기  **/
	sql = "select * from a where no="+no;
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	String gmid    = "";      //사서아이디
	String gmno    = "";      //질문번호
	String gmbody  = "";      //답변내용
	String gmtitle = "";      //답변제목
	String gmwdate = "";      //답변일자
	
	
	//답변이 존재할 경우 답변을 가져온다.
	if(rs.next() == true) {
		
		gmid    = rs.getString("mid"); 
		gmno    = rs.getString("no");
		gmbody  = rs.getString("body");
		gmtitle = rs.getString("title");
		gmwdate = rs.getString("wdate");
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>질의응답</title>
		
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
				<%
				if(id == null || id.equals("") ){
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
						<a href="useTime.jsp"><li class="left_menu_sub">이용시간</li></a>
						<a href="useGuide.jsp"><li class="left_menu_sub">대출/반납/예약/연장</li></a>
						<a href="qna.jsp"><li class="on left_menu_sub last_sub">질의응답</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">질의응답</span>
						<span class="page_map">도서관 이용 > 질의응답 > 질문 보기</span>
					</div>
					<div class="content">
						<div class="qTableWrap">
							<h2 class="subTitle"><span class="point">*</span>질문</h2>
							<table border="1" width="1200px" class="qTable">
								<tr height="40px;">
									<th>질문번호</th>
									<td><%= no %></td>
									<th>질문자</th>
									<td><%= gid %></td>
									<th>작성일</th>
									<td><%= gwdate %></td>
								</tr>
								<tr height="40px;">
									<th>질문</th>
									<td colspan="5"><%= gtitle %></td>
								</tr>
								<tr>
									<td colspan="6" class="body"><%= gbody %></td>
								</tr>
							</table>
						<%
							if((gmno==null || gmno.equals("")) && gid.equals(id)){
						%>
							<input type="button" value="삭제" onclick="qnaDeleteFn(<%= no %>)" class="qna_btn deleteBtn">
							<input type="button" value="목록으로" onclick="location.href='qna.jsp'" class="qna_btn gotolist">
						<%		
							}else{
						%>
							<input type="button" value="목록으로" onclick="location.href='qna.jsp'" class="qna_btn gotolist">
						<%		
							}
						%>	
						</div>
						<div>
						<%
							if(gmno==null || gmno.equals("")) {
						%>
							<hr class="hr">
							<span class="aEmpty"><span class="point">*</span>등록된 답변이 없습니다.</span>
						<%
							}else {
						%>		
							<hr class="hr">
							<h2 class="subTitle"><span class="point">*</span>답변</h2>
							<table border="1" class="aTable" width="1200px;" >
								<tr height="40px">
									<th>제목</th>
									<td><%= gmtitle %></td>
									<th>작성자</th>
									<td><%= gmid %></td>
									<th>답변일</th>
									<td><%= gmwdate %></td>
								</tr>
								<tr>
									<td colspan="6" class="body">
										<%= gmbody %>
									</td>
								</tr>
							</table>
							<%		
								}
							%>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->
		
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
		</div>
	</body>
	<%
	if(rs != null) {
		try {rs.close();} catch (SQLException e) {} 
	}
	if(pstmt != null) {
		try {pstmt.close();} catch (SQLException e) {} 
	}
	if(conn != null) {
		try {conn.close();} catch (SQLException e) {} 
	}
	%>
</html>