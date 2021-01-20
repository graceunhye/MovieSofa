<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
request.setCharacterEncoding("EUC-KR"); 
String id      = (String)session.getAttribute("idKey"); //아이디
String subject = request.getParameter("subject");       //책제목
String isbn    = request.getParameter("isbn");          //isbn
String pdate   = request.getParameter("pdate");         //발행일
String price   = request.getParameter("price");         //가격
String writer  = request.getParameter("writer");        //작가명
String company = request.getParameter("company");       //출판사
String why     = request.getParameter("why");           //이유


Connection        conn;
PreparedStatement mstmt;
ResultSet         rs;


String dbURL       =  "jdbc:mysql://localhost:3306/skylibrary?"
						+  "useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
String dbID        ="root";
String dbPassword  ="mySQL1234";
Class.forName("com.mysql.cj.jdbc.Driver");
conn = DriverManager.getConnection( dbURL ,dbID ,dbPassword );
	
String   sql =  "insert into abook ";
		 sql += "(id, subject, isbn, pdate, price, writer, company, why, wdate) ";
		 sql += "values";
		 sql += "(?,?,?,?,?,?,?,?,now())";
		 
mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
mstmt.setString(1,id);
mstmt.setString(2,subject);
mstmt.setString(3,isbn);
mstmt.setString(4,pdate);
mstmt.setString(5,price);
mstmt.setString(6,writer);
mstmt.setString(7,company);
mstmt.setString(8,why);
mstmt.executeUpdate();
mstmt.close();
conn.close();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>희망도서 신청완료</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/wish.css"   type="text/css"/>
		
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
						<span class="head_id">
							<c:out value="${ id }"/> 님
						</span>
						<input class="head_btn" type="button" value="로그아웃" onclick="location.href='../../loginout/logout.jsp'">
					</div>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp">
							<img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="로고">
						</a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="../search/total.jsp">도서검색</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="../use/useTime.jsp">도서관 이용</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="../intro/notice.jsp">도서관 소개</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="userInfo.jsp">마이페이지</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
	
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">마이페이지</li>
						<a href="userInfo.jsp"><li class="left_menu_sub">회원정보</li></a>
						<a href="wish.jsp"><li class="on left_menu_sub">희망도서 신청</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">대출도서 조회</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">희망도서 신청</span>
						<span class="page_map">마이페이지 > 희망도서 신청 > 신청하기</span>
					</div>
					<div class="content">
						<p class="tip"><span class="point">*</span> 표시된 항목은 필수 입력 항목입니다</p>
						<table class="wish_table" >
							<tbody>
								<tr>
									<th scope="row">도서명<span class="point">*</span></th>
									<td><%= subject %></td>
								</tr>
								<tr>
									<th scope="row">isbn<span class="point">*</span></th>
									<td><%= isbn %></td>
								</tr>
								<tr>
									<th scope="row">발행년도 <span class="point">*</span></th>
									<td><%= pdate %></td>
								</tr>
								<tr>
									<th scope="row">가격<span class="point">*</span></th>
									<td><%= price %></td>
								</tr>
								<tr>
									<th scope="row">저자명</th>
									<td><%= writer %></td>
								</tr>
								<tr>
									<th scope="row">발행자</th>
									<td><%= company %></td>
								</tr>
								<tr>
									<th class="last" scope="row">신청이유</th>
									<td class="last"><%= why %></td>
								</tr>
							</tbody>
						</table>
						<div class="btns">
							<input class="btn" type="button" value="확인" onclick="location.href='wish.jsp'"/>
						</div>
					</div>
				</div>
			</section>
			<!-- section end -->
		
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
	
		</div>
		<script>
			alert("신청이 완료되었습니다.");
		</script>
	</body>
</html>