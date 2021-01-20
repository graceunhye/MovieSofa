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
	
	<title>사서 추천 도서관리</title>
	
	<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
	<link rel="stylesheet" href="../../../css/mrecommend.css" type="text/css"/>
	
	<script src="../../../js/jquery-3.5.1.min.js"></script>
</head>
<body style="margin: 0px;">
	<div class="wrap">
		<header>
			<div class="header">
				<div class="title_box"><span class="head_title">관리자 페이지 </span><span class="name">하늘도서관</span></div>
			</div>
		</header>
		<section>
			<jsp:include page="../include/nav.jsp" />
			<div class="section">
				<div class="user_info">
				<span class="info_title"><span class="point">*</span>도서 목록</span>				
				</div>
				<br>
				<br>
				<div class="rselect">
					<form action="recommendSearch.jsp" name="frm" id="frm" method="post">					
						<select id="select" name="select">
							<option value="1" selected>전체</option>
							<option value="2">제목</option>
							<option value="3">저자</option>
						</select>
						<input type="text" name="keyword" id="keyword">
						<input type="submit" value="검색"  class="optionBox_btn_free">
					</form>	
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
					int recordTotal = 0; //도서 총 갯수
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
						//책 개수  조회 종료
						
														
						pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
						perpage = 5;
						startno = ((pageno - 1) * perpage);
						
						
						//한페이지에 올릴 도서 정보 조회
						sql = "select subject, story, pdate, coverimg, company, writer, isbn, bcount from book ";
						sql += "limit " + startno + "," + perpage;
						
						mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
						rs = mStmt.executeQuery();	
						
						
						int i = recordTotal - ((pageno - 1) * perpage);
						
						
						//영화 정보 뿌리기
						while(rs.next())
						{
							String vsubject  = rs.getString("subject");  //책제목
							String vstory    = rs.getString("story");    //책줄거리
							String vpdate    = rs.getString("pdate");    //책발매일
							String vcoverimg = rs.getString("coverimg"); //책커버이미지
							String vcompany  = rs.getString("company");  //출판사
							String vwriter   = rs.getString("writer");   //저자
							String visbn     = rs.getString("isbn");     //ISBN
	
						%> 
						
						<div class="recommend">					
							<table width="800px">
								<tr>
									<td rowspan="4" width="15%" align="center">
										<a href="recommendView.jsp?isbn=<%= visbn %>"><img src="<%= vcoverimg %>" alt="<%= vsubject %>" width="82px"></a>
									</td>
									<td colspan="2"><a href="recommendView.jsp?isbn=<%= visbn %>"><b><%= vsubject %></b></a></td>
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
									%><a href="recommend.jsp?page=1">맨앞으로</a><% 
									%><a href="recommend.jsp?page=<%=startPage - 1%>">이전</a><% 
								}
								
								for (int j = startPage ; j <= endPage; j++) {
								    if (j == pageno) {
								        %> <b><a href="recommend.jsp?page=<%= j %>"><%= j %></a></b><%
								    } else {
								    	 %> <a href="recommend.jsp?page=<%= j %>"><%= j %></a> <%
								    }
								}
								
								if (endPage < maxPage) {
									%> <a href="recommend.jsp?page=<%= endPage + 1%>">다음</a><%
									%> <a href="recommend.jsp?page=<%= maxPage %>">맨뒤로</a><%		
								}
							%> 
							</div>	
					</div>		
				</div>	
			</div>
		</section>
	</div>
</body>
</html>