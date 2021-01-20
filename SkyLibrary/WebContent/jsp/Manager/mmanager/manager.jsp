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
		
		<title>사서관리</title>
		
		<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/manager.css" type="text/css"/>
		
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
				<jsp:include page="../include/nav.jsp"></jsp:include>
				<div class="section">
					<div class="user_info">
						<span class="info_title"><span class="point">*</span>사서 관리</span>
						<br>
						<br>
						<div class="user_content">
						<br>
							<div class="insert_btn">			
								<input type="button"  class="optionBox_btn_free" value="사서등록" onclick="location.href='managerInsert.jsp'">
							</div>
						<table class="content_table">
							<tr class="top_tr">
								<td width="30%">사서 아이디</td>
								<td width="30%">사서 이름</td>
								<td width="30%">사서 관리</td>
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
							int recordTotal = 0; //사서정보 총 개수
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
								sql = "select count(*) as cnt from manager ";
								
								mStmt= conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs = mStmt.executeQuery();	
								rs.next();
								
								recordTotal = Integer.parseInt(rs.getString("cnt"));
								
								rs.close();
								mStmt.close();	
								
								pageno  = Integer.parseInt(curpage); //현재 페이지 값을 페이지 번호로 지정
								perpage = 5;
								startno = ((pageno - 1) * perpage);
								
								sql =  "select mid,name ";
								sql += "from manager ";
								sql += "order by mid asc ";
								sql += "limit " + startno + "," + perpage;
								
								mStmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
								rs = mStmt.executeQuery();	
	
								int i = recordTotal - ((pageno - 1) * perpage);
								
								//사서정보 뿌리기
								while(rs.next())
								{
									String vMid       = rs.getString("mid");
									String vName      = rs.getString("name");
			
								%> 	
								<tr class="mid_tr">
									<td align="center"><%= vMid %></td>
									<td><%= vName %></td>
									<td align="center">
										<input type="button"  class="optionBox_btn_free" value="수정" onclick="location.href='managerModify.jsp?id=<%= vMid %>'">
										<input type="button"   class="optionBox_btn_free" value="삭제" onclick="location.href='managerDelete.jsp?id=<%= vMid %>'">
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
								<div class="manager_page">	
								<%
									if(pageno > BLOCK) {
										%><a href="manager.jsp?page=1">맨앞으로</a><% 
										%><a href="manager.jsp?page=<%=startPage - 1%>">이전</a><% 
									}
									
									for (int j = startPage ; j <= endPage; j++) {
									    if (j == pageno) {
									        %> <b><a href="manager.jsp?page=<%= j %>"><%= j %></a></b><%
									    } else {
									    	 %> <a href="manager.jsp?page=<%= j %>"><%= j %></a> <%
									    }
									}
									
									if (endPage < maxPage) {
										%> <a href="manager.jsp?page=<%= endPage + 1%>">다음</a><%
										%> <a href="manager.jsp?page=<%= maxPage %>">맨뒤로</a><%		
									}
								%> 
								</div>													
							<br>
					</div>
				</div>
			</section>
		</div>
	</body>
</html>