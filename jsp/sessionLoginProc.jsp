<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="regMgr" class="MovieSofa.RegisterMgr" />    
<%

	String id = "";
	String pw = "";
	
	if(request.getParameter("id") != null){ 
		id = request.getParameter("id");
	}
	
	if(request.getParameter("pw") != null){
		pw = request.getParameter("pw");
	}
	
	if(regMgr.loginRegister(id, pw)){
		session.setAttribute("idKey", id);
		String test = (String)session.getAttribute("idKey");
%>
	<script>
		alert("로그인 되었습니다.");
		location.href = "home.jsp";
	</script>
<% } else { %>
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		location.href = "sessionLogin.jsp";
	</script>
<% } %>	