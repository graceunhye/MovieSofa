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
		alert("�α��� �Ǿ����ϴ�.");
		location.href = "home.jsp";
	</script>
<% } else { %>
	<script>
		alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		location.href = "sessionLogin.jsp";
	</script>
<% } %>	