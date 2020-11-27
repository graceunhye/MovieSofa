<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%
request.setCharacterEncoding("EUC-KR");
String id     = (String)session.getAttribute("idKey");
String mv_no  = request.getParameter("mv_no");
if(id == null){ id = ""; }
if(id.equals("")){

	response.sendRedirect("sessionLogin.jsp");
}
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>리뷰 등록하기</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">


		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/rv_view.css">
		
		<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script>
		
		var value = "";
		
		function readInputFile(input)
		{
			if(input.files && input.files[0])
			{
				var reader = new FileReader();
				reader.onload = function(e)
				{
					var str = "";
					str += "<img src="+ e.target.result +" width='300px'>";
					str += "<button type='button' id='del'>삭제</button>";
					$("#pic").html(str);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

		$(document).ready(function(){
			$("input[type=file]").on('change', function()
			{
				readInputFile(this);
			});
			
			$(document).on('click', "#del", function()
			{
				$("#pic").html("");
				$("input:file").val("");
			});
		});
		
		</script>
	</head>
	<!-- head end -->
	
	<body style="background-color:#2E2D2C;margin:0;">
		<div class="wrap">
			<header style="align: center;">
				<div style="text-align:right;">
				
					<% 
					if(!id.equals(""))
					{
					%>	
						<font style="font-weight:bold;"><%= id %> 님</font>
						<a class="a" href="sessionLogout.jsp">LOGOUT</a> 
					<% 
					} else {
					%> 
						<a class="a" href="sessionLogin.jsp">LOGIN</a>
						<a class="a" href="mv_join.jsp">JOIN</a>	
					<% 	
					}
					%>  
					
				</div>
				<div style="margin-left: 470px">
					<a class="a" href="home.jsp">
						<img src="../img/page/logo.png" name="logo" id="logo" width="300px">
					</a>
				</div>
			</header>
			<!-- header end -->
		
			<nav style="width: 1280px;height: 48px; background-color: #2E2D2C;position: sticky;top:0;">
			   <ul class="menu">
					<li class="menu_li"><a class="menu_a" href="mv_main.jsp">BOXOFFICE</a></li>
					<li class="menu_li"><a class="menu_a" href="mv_list.jsp">REVIEW</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">NEWS</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">TALK</a></li>
					<form name="frm" id="frm" method="post" action="mv_search.jsp">
						<li class="menu_li">
							<select class="search_type" id="select" name="select">
								<option value="1">전체</option>
								<option value="2">한국영화</option>
								<option value="3">해외영화</option>
							</select>
						</li>
						<li class="menu_li">
							<input class="search_text" type="text" placeholder="검색어를 입력하세요." id="key" name="key">
						</li>
						<li class="menu_li">
							<input class="search_btn" onclick="location.href='mv_search.jsp'" type="submit" value="search">
						</li>
					</form>
				</ul>				
			</nav>	
			<!-- nav end -->
			
			<section style="padding-top:10px; padding-bottom:30px;"> 
				<form id="frm" name="frm" method="post" action="rv_insertOk.jsp" enctype="multipart/form-data">
					<h2 id="title" style="color:#2e2d2c; text-align:center;">리뷰 등록</h2>
					<table class="reviewTable" align="center" width="1000px" border="1">
						<tr>
						 	<th width="17.5%">제목</th>
							 <td>
						 		<input type="text" name="rv_title"  id="rv_title" size="100%" style="width:99%; height:20px">
						 		<input type="hidden" name="mv_no" id="mv_no" value="<%= mv_no %>">
							</td>
						</tr>
						<tr>
						  	<th>내용</th>
						  	<td colspan="3">
							<textarea name="rv_body" id="rv_body" rows="26" cols="120"></textarea>
							</td>
						</tr>
						<tr>
						  <th>첨부파일</th>
						  <td colspan="3" style="text-align:left;">
						  	<div id="pic">
							</div> 
						  	<input type='file' id="fname" name="fname">
						  </td>
						</tr>
					</table>
					<span class="buttons">
						<input type="submit" value="저장">
						<input type= "button" value="취소" onclick="location.href='rv_list.jsp?mv_no=<%= mv_no %>'">
						<input type= "button" value="목록" onclick="location.href='rv_list.jsp?mv_no=<%= mv_no %>'">
					</span>
				</form>				
			</section>
			<!-- section end -->
			
			<footer style="background-color:#2e2d2c;height:100px;">
				<div class="footer">
					<ul>
						<li class="footer_title">       Crew member</li>
						<li class="footer_content">     Kang GoEun</li>
						<li class="footer_content">     Park SuJin</li>
						<li class="footer_content">     Bae MinJu</li>
						<li class="footer_content">     Song EunHye</li>
						<li class="footer_title">&copy; moviesofa</li>
					</ul>
				</div>
			</footer>
			<!-- footer end -->
			
		</div>
	</body>
	<!-- body end -->
</html>