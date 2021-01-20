<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
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
	
	
	sql = "select no,title,body,ndate,nhit,nfile ";
	sql += "from notice ";
	sql += "where no=" + no;

	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	String vNO        = rs.getString("no");    //공지사항번호
	//String vMid       = rs.getString("mid");   //사서아이디
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
<title>공지사항 상세보기</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<script>
	function deleteFn(){
		if(confirm("삭제하시겠습니까?")){
			location.href = "noticeDelete.jsp?no=<%= no %>";
		}
	}
</script>
<style>
	.view_btn{
		position : relative;
		margin-left : 59%;
	}
	.view_td{
		background-color : #f5f5f5;
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
					<span class="info_title"><span class="point">*</span>공지사항 </span>
					<br>
					<br>
					<table border="1" style="border-collapse:collapse" width="1000">
						<tr>
							<td align="center" width="7%" class="view_td">글번호</td>
							<td align="center" width="10%"><%= vNO %></td>
							<td align="center" width="7%" class="view_td">작성자</td>
							<td align="center" width="10%"><%= id %></td>
						</tr>		
						<tr class="mid_tr">
							<td align="center" width="7%" class="view_td">작성일</td>
							<td align="center" width="10%"><%= vNdate %></td>
							<td align="center" width="7%" class="view_td">조회수</td>
							<td align="center" width="10%"><%= vNhit %></td>
						</tr>
						<tr>
							<td align="center" height="40px" class="view_td" width="7%">제목</td>
							<td colspan="3"><%= vTitle %></td>	
						</tr>
						<tr>
							<td align="center" height="400px" class="view_td" width="7%">내용</td>
							<td colspan="3">
							<%
								if(vNfile != null) {
									%>
									<img src="noticeFileDown.jsp?type=img&nfile=<%= vNfile %>">
									<%= vBody %>
									<%
								} else {
									%><%= vBody %><%
								}
							%>
							</td>	
						</tr>
						<tr>
							<td align="center" height="50px" class="view_td" width="7%">첨부파일</td>
							<td colspan="3">
								<%
									if(vNfile != null){
										%>
										<a href="noticeFileDown.jsp?nfile=<%= vNfile %>"><%= vNfile %></a>
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
						<input type="button" value="수정" id="nmodify" class="optionBox_btn_free" onclick="location.href='noticeModify.jsp?no=<%= no %>'">
						<input type="button" value="삭제" id="ndelete"  class="optionBox_btn_free" onclick="deleteFn()">
						<input type="button" value="목록"  class="optionBox_btn_free" onclick="location.href='notice.jsp'">
					</div>	
				</div>
			</div>
		</section>
	</div>
</body>
</html>