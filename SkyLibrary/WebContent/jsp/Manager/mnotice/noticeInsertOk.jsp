<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>    
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	Connection conn;
	PreparedStatement mstmt;
	ResultSet rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
	
	final String saveFolder = "D:\\kge\\SkyLibrary\\WebContent\\jsp\\Manager\\mnotice\\img\\upload";
	final String encoding   = "EUC-KR";
	final int maxSize       = 10*1024*1024; //10mb 


	//파일이 서버에 업로드되는 시점은 MultipartRequest 객체 생성 순간이다. 
	MultipartRequest multi = null; 
	multi = new MultipartRequest (request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
	//request가 되는 순간 null로 변한다. 
	//out.print("성공"); 
	
	String fileName = multi.getFilesystemName("fname");
	//fileSelect.jsp 파일에서 input 태그 name 
	
	String original = multi.getOriginalFileName("fname"); 
	//filename은 중복이름이 들어올 경우 자동으로 index가 붙는데, index되기 전의 원본명 
	
	String type = multi.getContentType("fname"); 
	//어떤 타입의 문서인지 알아서 해석해줌
	
	File f = multi.getFile("fname"); 
	//첨부파일 어떤 종류고 파일 크기 얼마인지 
	
	int len = 0; 
	if(f!=null) 
	{ 
		len = (int)f.length(); 
	} 
	
	String no     = multi.getParameter("no");
	String mid    = multi.getParameter("mid");
	String title  = multi.getParameter("title");
	String body   = multi.getParameter("ir1");
	String ndate  = multi.getParameter("ndate");
	String nhit   = multi.getParameter("nhit");
	String nfile  = multi.getFilesystemName("fname");
	String sql="";
	
	//noticeInsert 에서 가져온 정보로 새로운 리뷰 등록하기
	sql  = "insert into notice ";
	sql += "(mid, title , body, ndate, nfile) ";
	sql += "values ";
	sql += "(?, ?, ?, now(), ?)";
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );

	mstmt.setString(1,id);        //사서아이디
	mstmt.setString(2,title);      //공지사항제목
	mstmt.setString(3,body);       //공지사항내용
	mstmt.setString(4,nfile);      //공지사항첨부파일

	mstmt.executeUpdate();
	mstmt.close();
	
	/**  가장 최근에 등록된 공지사항정보 가져오기  **/
	sql = "select * from notice where no=last_insert_id()";
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	/**  공지사항정보 가져오기  g=get **/
	String gno        = rs.getString("no");    //공지사항번호
	//String vMid       = rs.getString("mid");   //사서아이디
	String gtitle     = rs.getString("title"); //공지사항제목 
	String gbody      = rs.getString("body");  //공지사항내용
	String gndate     = rs.getString("ndate");
	String gnhit      = rs.getString("nhit");
	String gnfile     = rs.getString("nfile"); //공지사항첨부파일
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
					<table border="1" style="border-collapse:collapse" width="1000px">
						<tr>
							<td align="center" width="5%">글번호</td>
							<td align="center" width="10%"><%= gno %></td>
							<td align="center" width="5%">작성자</td>
							<td align="center" width="10%"><%= id %></td>
						</tr>		
						<tr class="mid_tr">
							<td align="center" width="5%">작성일</td>
							<td align="center" width="10%"><%= gndate %></td>
							<td align="center" width="5%">조회수</td>
							<td align="center" width="10%"><%= gnhit %></td>
						</tr>
						<tr>
							<td align="center" height="40px">제목</td>
							<td colspan="3"><%= gtitle %></td>	
						</tr>
						<tr>
							<td align="center" height="400px">내용</td>
							<td colspan="3"><%= gbody %></td>	
						</tr>
						<tr>
							<td align="center" height="50px">첨부파일</td>
							<td colspan="3">
								<%
									if(gnfile != null){
										%>
										<img src="noticeFileDown.jsp?type=img&nfile=<%= gnfile %>" width="300px">
										<br>
										<a href="noticeFileDown.jsp?nfile=<%= gnfile %>"><%= gnfile %></a>
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
						<input type="button" value="수정" id="nmodify" onclick="location.href='noticeModify.jsp'">
						<input type="button" value="삭제" id="ndelete" onclick="deleteFn()">
						<input type="button" value="목록" onclick="location.href='notice.jsp'">
					</div>	
				</div>
			</div>
		</section>
	</div>
</body>
</html>