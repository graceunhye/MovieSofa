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
	
	<title>공지사항</title>
	
	<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
	
	<script src="../mnotice/js/jquery-3.5.1.min.js"></script>
	
	<style>
		/** notice.jsp css **/
		#insert_btn{
			position : relative;
			margin-left : 5%;
		}
		.notice_page{
			positon : relative;
			margin-left : 40%;
		}
		a{
			color : black;
			text-decoration: none;
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
					<span class="info_title"><span class="point">*</span>공지사항</span>
					<br>
					<br>
					<div class="user_content">										
					<br>
					<button id="insert_btn" type="button" class="optionBox_btn_free" width="200" onclick="location.href='noticeInsert.jsp'">공지사항 작성</button>
						<table class="content_table">
						<tr class="top_tr">
							<td>글번호</td>
							<td>제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
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
		
							//도서 개수 조회
							sql = "select count(*) as cnt from notice ";
							
							mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
							rs = mStmt.executeQuery();	
							rs.next();
							
							recordTotal = Integer.parseInt(rs.getString("cnt"));
							
							rs.close();
							mStmt.close();	
							
							pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
							perpage = 10;
							startno = ((pageno - 1) * perpage);
							
							sql =  "select no,mid,title,body,ndate,nhit ";
							sql += "from notice ";
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
								<td align="center"><%= i-- %></td>
								<td><a href="noticeView.jsp?no=<%= vNo %>"><%= vTitle %></a></td>
								<td align="center"><%= vMid %></td>
								<td align="center"><%= vNdate %></td>
								<td align="center"><%= vNhit %></td>
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
						</div>
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
						<div class="notice_page">	
						<%
							if(pageno > BLOCK) {
								%><a href="notice.jsp?page=1">맨앞으로</a><% 
								%><a href="notice.jsp?page=<%=startPage - 1%>">이전</a><% 
							}
							
							for (int j = startPage ; j <= endPage; j++) {
							    if (j == pageno) {
							        %> <b><a href="notice.jsp?page=<%= j %>"><%= j %></a></b><%
							    } else {
							    	 %> <a href="notice.jsp?page=<%= j %>"><%= j %></a> <%
							    }
							}
							
							if (endPage < maxPage) {
								%> <a href="notice.jsp?page=<%= endPage + 1%>">다음</a><%
								%> <a href="notice.jsp?page=<%= maxPage %>">맨뒤로</a><%		
							}
						%> 
						</div>													
					</div>
				</div>	
		</section>
	</div>
</body>
</html>