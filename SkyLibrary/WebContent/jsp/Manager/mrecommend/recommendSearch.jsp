<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
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
	
	String sql = "";
	
	//select 값에 따른 sql문
	switch(select) {
	case "1": //전체
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where subject like '%"+keyword+"%' or writer like '%" + keyword + "%' ";
		break;
	case "2": //한국영화
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where subject like '%"+keyword+"%' ";
		break;
	case "3": //해외영화
		sql = "select subject, story, pdate, coverimg, company, writer, isbn from book where writer like '%"+keyword+"%' ";
		break;
	}
	
	mStmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	rs = mStmt.executeQuery();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사서 추천 도서관리</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<script src="../mnotice/js/jquery-3.5.1.min.js"></script>
<style>
/* recommendSearch.jsp css */
.booklist{
	position : relative;
	padding-left : 10%;
	height : 800px;
	width : 900px;
}
.searchpage{
	position : relative;
	padding-left : 42%;				
}	
.recommend{
	border-top : 3px solid #a8a8a8;
}
a{
	color : black;
	text-decoration: none;
}
.rselect{
	position : relative;
	margin-left : 9%;
}
</style>
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
								%><option value="3" selected>저자</option><%
							}else
							{
								%><option value="3">저자</option><%									
							}									
							%>
						</select>
						<input type="text" name="keyword" id="keyword" value="<%= keyword %>">
						<input type="submit" value="검색">
					</form>	
				</div>	
				<div class="content">
					<div class="booklist">	
					<br>
					<br>
					<%
					
					if(rs != null){
						while(rs.next()){
							String vsubject   = rs.getString("subject");    //책제목
							String vstory = rs.getString("story");   //책줄거리
							String vpdate = rs.getString("pdate"); //책발매일
							String vcoverimg    = rs.getString("coverimg");    //책커버이미지
							String vcompany   = rs.getString("company");    //출판사
							String vwriter = rs.getString("writer");   //저자
							String visbn = rs.getString("isbn"); //ISBN
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
						}//while문 종료
					} else {
					%>
						<h3>검색결과가 없습니다.</h3>
					<% 
					}//if문 종료
					
					
					//연결,조회 등 sql관련 활동을 마치고 아직 닫히지 않았다면 
					//닫아주는 조건문
					if(rs    != null) try { rs.close(); }     catch(SQLException e) {out.print("오류!");}
					if(mStmt != null) try { mStmt.close(); }  catch(SQLException e) {out.print("오류!");}
					if(conn  != null) try { conn.close(); }   catch(SQLException e) {out.print("오류!");}
					%> 
					</div>		
				</div>	
			</div>
		</section>
	</div>
</body>
</html>