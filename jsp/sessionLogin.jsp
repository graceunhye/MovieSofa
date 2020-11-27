<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<%
	String id = (String)session.getAttribute("idKey");

	if (id != null){
	%>    
		<script>
			alert("로그인 되었습니다.");
			location.href = "home.jsp";
		</script>
	<%
		return;
 	} //if문 종료
 %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<!-- script -->
	<script src="../js/jquery-3.5.1.min.js"></script>
	<script src="../js/mv_login.js"></script>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="../css/mv_login.css">
</head>
<body style="margin:0;">
	<div class="wrap">
		<section style="text-align : center;height : 90vh;overflow:auto;">
			<article style="margin-top:10%">
				<div class = "login_frm">
					<a href="home.jsp"><img src = "../img/page/logo.png" class="logo_only"></a><br>
					<form action="sessionLoginProc.jsp" method="post">
						<input  type="text"     name = "id"        class="id"><br>
						<input  type="password" name = "pw"        class="pw"><br>
						<input  type="submit"   name = "login_btn" class="login_btn" value="로그인"><br>
						<button type="button"   name = "join_btn" class="join_btn" onclick="location.href='mv_join.jsp'">회원가입</button>
					</form>
				</div>
			</article>	
		</section>
	</div>
</body>
</html>