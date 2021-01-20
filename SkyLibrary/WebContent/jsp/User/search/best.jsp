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
		<meta charset="EUC-KR">
		
		<title>인기도서</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/best.css" type="text/css"/>
		
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
							<li><a href="total.jsp">도서검색</a></li>
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
						<li class="left_menu_title">도서검색</li>
						<a href="total.jsp"><li class="left_menu_sub">통합검색</li></a>
						<a href="best.jsp"><li class="on left_menu_sub">인기도서</li></a>
						<a href="new.jsp"><li class="left_menu_sub">신착도서</li></a>
						<a href="recommend.jsp"><li class="left_menu_sub last_sub">사서추천도서</li></a>
					</ul>
				</nav>
				<div class="section">
					<div class="section_top">
						<span class="top_title">인기도서</span>
						<span class="page_map">도서검색 > 인기도서</span>
					</div>
					<div class="content">
						<div class="booklist">	
							<br>
							<br>
						<%
						
						Connection        conn;
						PreparedStatement mStmt;
						ResultSet         rs;
						
						String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
						String     mUserID   = "root";
						String     mUserPass = "mySQL1234";
						
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );
		
						
						//변수값 정보
						int recordTotal = 0; //도서 총 개수
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
		
							//도서 갯수 조회
							sql = "select count(*) as cnt from book ";
							
							mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							rs.next();
							
							recordTotal = Integer.parseInt(rs.getString("cnt"));
							
							rs.close();
							mStmt.close();	
							//책 갯수  조회 종료
							
		
							pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
							perpage = 5;
							startno = ((pageno - 1) * perpage);
							
							
							
							//한페이지에 올릴 도서 정보 조회
							sql = "select subject, story, pdate, coverimg, company, writer, isbn, bcount from book order by bcount desc ";
							sql += "limit " + startno + "," + perpage;
							
							mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							
							
							int i = recordTotal - ((pageno - 1) * perpage);
							
							
							//도서 정보 뿌리기
							while(rs.next())
							{
								String vsubject     = rs.getString("subject");     //책제목
								String vstory       = rs.getString("story");       //책줄거리
								String vpdate       = rs.getString("pdate");       //책발매일
								String vcoverimg    = rs.getString("coverimg");    //책커버이미지
								String vcompany     = rs.getString("company");     //출판사
								String vwriter      = rs.getString("writer");      //저자
								String visbn        = rs.getString("isbn");        //ISBN
		
							%> 
							
							<div class="best">					
								<table width="800px">
									<tr>
										<td rowspan="4" width="15%" align="center">
											<a href="bestView.jsp?isbn=<%= visbn %>"><img src="<%= vcoverimg %>" alt="<%= vsubject %>" width="82px"></a>
										</td>
										<td colspan="2"><a href="bestView.jsp?isbn=<%= visbn %>"><b><%= vsubject %></b></a></td>
									</tr>
									<tr>
										<td width="30%">저자 : <%= vwriter %></td>
										<td width="30%">ISBN : <%= visbn %></td>
									</tr>
									<tr>
										<td width="30%">출판사 : <%= vcompany %></td>
										<td width="30%">소장기관 : 하늘 도서관</td>
									</tr>
									<tr>
										<td width="30%">발행일 : <%= vpdate %></td>
										<td width="30%">자료실 : 일반자료실</td>
									</tr>
								</table>
							</div>
														
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
							
							%>
							<div class="searchpage">	
							<%
								if(pageno > BLOCK) {
									%><a href="best.jsp?page=1">맨앞으로</a><% 
									%><a href="best.jsp?page=<%=startPage - 1%>">이전</a><% 
								}
								
								for (int j = startPage ; j <= endPage; j++) {
								    if (j == pageno) {
								        %> <b><a href="best.jsp?page=<%= j %>"><%= j %></a></b><%
								    } else {
								    	 %> <a href="best.jsp?page=<%= j %>"><%= j %></a> <%
								    }
								}
								
								if (endPage < maxPage) {
									%> <a href="best.jsp?page=<%= endPage + 1%>">다음</a><%
									%> <a href="best.jsp?page=<%= maxPage %>">맨뒤로</a><%		
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