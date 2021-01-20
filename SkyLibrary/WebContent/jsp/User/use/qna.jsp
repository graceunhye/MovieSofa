<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="java.net.URLEncoder"%>
<%

	request.setCharacterEncoding("EUC-KR");


	String id      = (String)session.getAttribute("idKey");
	String keyword = request.getParameter("keyword");
	String select  = request.getParameter("select");
	
	
	
	if(id == null){ id = ""; }
	if(keyword == null){ keyword = ""; }
	if(select == null || select.equals("0")){ select = "nope"; }
	
	
	
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
					<div class="head_btns">
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
				<div class="section">
					<div class="section_top">
						<span class="top_title">질의응답</span>
						<span class="page_map">도서관 이용 > 질의응답</span>
					</div>
					<div class="content">
						<div align="center">
						<%
						Connection        conn;
						PreparedStatement mStmt;
						ResultSet         rs;				
						String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
													+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
						String     mUserID   = "root";
						String     mUserPass = "mySQL1234";
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection( mDBMS, mUserID ,mUserPass );
		
						
						//변수값 정보
						int recordTotal = 0; //책 총 갯수
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
		
							//질문 개수 조회
							sql = "select count(*) as cnt from q ";
							if(!keyword.equals("")){
								if(!select.equals("nope"))
								{
									sql += "where "+ select +" like '%"+ keyword +"%' ";
									
								}else 
								{
									sql += "where title like '%"+ keyword +"%' or body like '%"+ keyword +"%'";
								}
							}
							mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							rs.next();
							
							recordTotal = Integer.parseInt(rs.getString("cnt"));
							
							rs.close();
							mStmt.close();	
							
							
		
							pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
							perpage = 15;
							startno = ((pageno - 1) * perpage);
							
							
							
							//한페이지에 올릴 도서 정보 조회
							sql = "select no, id, title, body, wdate, hit, atype from q ";
							if(!select.equals("nope"))
							{
								sql += "where "+ select +" like '%"+ keyword +"%' ";
							}else 
							{
								sql += "where title like '%"+ keyword +"%' or body like '%"+ keyword +"%'";
							}
							sql += " order by no desc limit " + startno + "," + perpage;
		
							mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							
		
							int i = recordTotal - ((pageno - 1) * perpage);
							%>
							<span class="searchResultNum">검색된 결과수:: <font color="orange"><%= recordTotal %></font></span>		
							<div class="searchBox">
								<form id="frm" name="frm" method="post" action="qna.jsp">
									<select id="select" class="select" name="select">
										<option value="0">전체</option>
										<option value="title">제목</option>
										<option value="body">내용</option>
									</select>
									<input type="text" name="keyword" id="keyword" class="keyword" value="<%= keyword %>">
									<input type="submit" value="검색" class="searchBtn">
								</form>
							</div>		
							<table width="1200px" class="qnaTable">
								<tr height="50px" class="top_tr">
									<th align="center" class="top_td">글번호</th>
									<th width="500" class="top_td">제목</th>
									<th align="center" class="top_td">작성자</th>
									<th align="center" class="top_td">작성일</th>
									<th align="center" class="top_td">상태</th>
								</tr>
							<%
							
							
							//도서 정보 뿌리기
							while(rs.next())
							{
								int    gno     = rs.getInt("no");        //질문번호
								int    ghit    = rs.getInt("hit");       //조회수
								int    gatype  = rs.getInt("atype");     //답변여부 (true:1, false:0)
								String gid     = rs.getString("id");     //질문 작성자
								String gtitle  = rs.getString("title");  //질문 제목
								String gwdate  = rs.getString("wdate");  //질문일자
								
								
		
							%> 
								<tr>
									<td><%= gno %></td>
									<td><a href="qnaView.jsp?no=<%= gno %>"><%= gtitle %></a></td>
									<td><%= gid %></td>
									<td><%= gwdate %></td>
									<td>
									
									
									<%
										if(gatype==0){
									%>
											<font color="blue">답변대기</font>
									<%		
										}else{
									%>
											<font color="orange">답변완료</font>
									<%		
										}
									%>
									
									
									</td>
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
							<span class="btns"><input class="btn" type="button" value="글쓰기" onclick="qnaNeedLogin('<%= id %>')"></span>
							<br>
						</div>
							<%
						
							int BLOCK = 5;
							int startPage = ((pageno-1)/BLOCK*BLOCK)+1;
							int endPage = ((pageno-1)/BLOCK*BLOCK)+BLOCK;
		
							int maxPage = recordTotal / perpage;
							if( ( recordTotal % perpage ) != 0){
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
						<div class="searchpage">	
						<%
							if(pageno > BLOCK) {
								%><a href="qna.jsp?page=1&keyword=<%= pageword %>&select=<%= select %>">맨앞으로</a>&nbsp;<% 
								%><a href="qna.jsp?page=<%=startPage - 1%>&keyword=<%= pageword %>&select=<%= select %>">이전</a><% 
							}
							
							for (int j = startPage ; j <= endPage; j++) {
							    if (j == pageno) {
							        %> <b><a href="qna.jsp?page=<%= j %>&keyword=<%= pageword %>&select=<%= select %>"><%= j %></a></b><%
							    } else {
							    	 %> <a href="qna.jsp?page=<%= j %>&keyword=<%= pageword %>&select=<%= select %>"><%= j %></a> <%
							    }
							}
							
							if (endPage < maxPage) {
								%> <a href="qna.jsp?page=<%= endPage + 1%>&keyword=<%= pageword %>&select=<%= select %>">다음</a>&nbsp;<%
								%> <a href="qna.jsp?page=<%= maxPage %>&keyword=<%= pageword %>&select=<%= select %>">맨뒤로</a><%		
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
</html>