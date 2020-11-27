<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>	    
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>무비소파 메인</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="../css/home.css">
		
	</head>
	<!-- head end -->
	
	<body style="margin:-20px;">
		<nav class="nav">
			<ul class="menu">
				<li class="menuTap">
					<a href="mv_main.jsp">BOXOFFICE</a>
				</li>
				<li class="menuTap">
					<a href="mv_list.jsp">REVIEW</a>
				</li>
				<li class="menuTap">
					<a style="cursor:pointer" onclick="alert('준비중인 서비스입니다.')">NEWS</a>
				</li>
				<li class="menuTap">
					<a style="cursor:pointer" onclick="alert('준비중인 서비스입니다.')">TALK</a>
				</li>
				<form class="form" >
				<% 
					if(!id.equals(""))
					{
					%>	 
						<font style="color:white;font-weight:bold;"><%= id %> 님 환영합니다.</font>
						<li class="first">
							<input class="btn" onclick="location.href='sessionLogout.jsp'" type="button" value="LOGOUT">
						</li> <% 
					} else {
						%> 
						<li class="first">
							<input class="btn" onclick="location.href='sessionLogin.jsp'" type="button" value="LOGIN">
							<input class="btn" onclick="location.href='mv_join.jsp'" type="button" value="JOIN">
						</li>	
						<% 	
					}
				%>  
				</form>
			</ul>				
		</nav>
		<!-- nav end -->
		
		<section class="section">
			<div class="logotop"></div>
			<div class="logotext">
				<div class="movetext">MOVIE SOFA</div>
			</div>
			<div class="logoimg">
				<div class="movelogo"><img src="../img/page/logo_only.png" style="margin-bottom:-10px;"/></div>
			</div>
			<div class="logoflat" ></div>
		</section>
		<!-- section end -->
		
	</body>
	<!-- body end -->
</html>