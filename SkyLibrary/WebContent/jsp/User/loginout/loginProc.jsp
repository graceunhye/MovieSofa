<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="regMgr" class="login.RegisterMgr" />    
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
		if(session.getAttribute("idKey").equals("ezen"))
		{
		%>
			<script>
				alert("�α��� �Ǿ����ϴ�.");
				location.href = "../../Manager/mwish/wish.jsp";
			</script>
		<%	
		}else{
		%>
			<script>
				alert("�α��� �Ǿ����ϴ�.");
				location.href = "../../main.jsp";
			</script>			
		<%	
		}
	} else { 
	%>
		<script>
			alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			location.href = "login.jsp";
		</script>
	<% 
	} 
	%>	