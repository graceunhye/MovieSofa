<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%

		String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		String     m_UserID   = "root";
		String     m_UserPass = "mySQL1234";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String	   id			;
		String	   name 		;
		String	   num 			;
	   	int	  	   postNum 	   	;
	   	String	   addr1       	;
	   	String	   addr2 	   	;
	   	String	   email1 	    ;
	   	String	   email2 	    ;
	
	   	int total		= 0; //유저 정보 총 갯수
		int pageno 		= 0; //페이지 번호
		int perpage		= 0; //한 페이지당 게시물 수
		int startno		= 0; //시작번호
	
try {

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );

		String sql;
		String curpage = request.getParameter("page");
		
		if(curpage == null){curpage = "1";}
		
		sql = "select count(*) as cnt from user";
		
		pstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);	
		rs = pstmt.executeQuery();	
		rs.next();
		
		total = Integer.parseInt(rs.getString("cnt"));
		
		rs.close();
		pstmt.close();	
		//유저 갯수 조회 완료
		
		pageno = Integer.parseInt(curpage); 
		//현재 페이지 값을 페이지 번호로 지정
		
		perpage = 15;
		startno = ((pageno-1)*perpage);
		
		
		/* 한 페이지에 올릴 유저 정보 조회 */
		
		sql = 	"select * from user ";
		sql +=	"limit " + startno + "," + perpage;
		pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = pstmt.executeQuery();	
		
		int i = total - ((pageno - 1) * perpage);

%>	    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>회원정보 관리</title>
		
		<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/muser.js"></script>
	</head>
	<body style="margin: 0px;">
		<div class="wrap">
			<header>
				<div class="header">
					<div class="title_box"><span class="head_title">관리자 페이지 </span><span class="name">하늘도서관</span></div>
				</div>
			</header>
			<!-- header end -->
			
			<section>
				<jsp:include page="../include/nav.jsp" />
				<div class="section">
					<div class="user_info">
						<span class="info_title"><span class="point">*</span>회원 정보</span>
						
						<!-- 회원 검색기능 -->
					<div id="User_search">
						<div style="margin-bottom:10px;">
							<select id="search_type">
								<option value="typeId" selected>아이디</option>
								<option value="typeName">이름</option>
							</select>
							<input id="User_searchT" type="text" >
							<input id="User_searchB" type="button" value="검색"  onclick="user_Search()">
						</div>
						<span>
							<a href="javascript:user_Delete();" style="text-decoration:none; color:#2c78d7; font-size:17px;" >선택한 회원 삭제</a>
						</span>
					</div>
						
						
						<!-- 회원정보 테이블 -->
						<div class="user_content">
							<table class="content_table">	
								<tr class="top_tr">
									<td style='width:5%'>선택</td>
									<td style='width:15%'>아이디</td>
									<td style='width:15%'>이름</td>
									<td style='width:20%'>연락처</td>
									<td style='width:40%'>이메일</td>
									<td style='width:5%'>수정</td>
								</tr>
								<% while(rs.next()){ 
									
								   id			= rs.getString("id");
								   name 		= rs.getString("name");
								   num 			= rs.getString("num");
								   postNum 	   	= rs.getInt("postNum");
								   addr1       	= rs.getString("addr1");
								   addr2 	    = rs.getString("addr2");
								   email1 	    = rs.getString("email1");
								   email2 	    = rs.getString("email2");
									
								%>
									<tr class="mid_tr">
										<td><input type='checkbox' style='zoom:1.5;' name='check' class="ckd" value="<%= id %>"></td>
										<td id="userId_<%= id %>"><%= id %></td>
										<td id="userName_<%= id %>"><%= name %></td>
										<td id="userNum_<%= id %>"><%= num %></td>
									<%
									if(email2 != null){
										
										 	 if(email2.equals("e1")){
											%>
												<td id="userE_<%= id %>"><%= email1 %>@naver.com</td>
											<%
											}else if(email2.equals("e2")){
											%>
												<td id="userE_<%= id %>"><%= email1 %>@nate.com</td>
											<%
											}else if(email2.equals("e3")){ 
											%>
												<td id="userE_<%= id%>"><%= email1 %>@gmail.com</td>
											<%
											} 
										
									}else if(email1 == null){ 
									%>
										<td id="userE_<%= id %>"> </td>
									<%	
									} 		
									%>
										<td id="userM_<%= id %>">
											<button type="button"  class="optionBox_btn_free" id="btnModify_<%= id %>" name="btnModify" onclick="user_modify('<%= id %>')">수정</button>
											<button type="button"  class="optionBox_btn_free" id="btnSave_<%= id %>" name="btnSave" style="display:none" onclick="user_modifyOK('<%= id %>')">저장</button>
										</td>
									</tr>
							<% 
							}
							%>
								
							</table>
						</div>
						
									<%
						
						int BLOCK = 10;
						int startPage = ((pageno-1)/BLOCK*BLOCK)+1;
						int endPage = ((pageno-1)/BLOCK*BLOCK)+BLOCK;
						
						int maxPage = total / perpage;
						
						if( ( total % perpage ) != 0)
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
							<div class="searchpage" style="width: 1200px; text-align:center; margin:0px;">	
							<%
								if(pageno > BLOCK) {
									%><a href="mUser.jsp?page=1">맨앞으로</a><% 
									%><a href="mUser.jsp?page=<%=startPage - 1%>">이전</a><% 
								}
								
								for (int j = startPage ; j <= endPage; j++) {
								    if (j == pageno) {
								        %> <b><a href="mUser.jsp?page=<%= j %>"><%= j %></a></b><%
								    } else {
								    	 %> <a href="mUser.jsp?page=<%= j %>"><%= j %></a> <%
								    }
								}
								
								if (endPage < maxPage) {
									%> <a href="mUser.jsp?page=<%= endPage + 1%>">다음</a><%
									%> <a href="mUser.jsp?page=<%= maxPage %>">맨뒤로</a><%		
								}
							%> 
							</div>
						
					</div>
				</div>
			</section>
		</div>
	</body>
</html>

<%
	
	rs.close();
	pstmt.close();
	conn.close();	
	
	} catch(Exception e) {
		
		System.out.println("Error : 드라이버 로딩 실패");
	}		


%>