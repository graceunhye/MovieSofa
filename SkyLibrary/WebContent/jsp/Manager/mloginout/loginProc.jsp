<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="regMgr" class="login.mRegisterMgr" />    
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
		session.setAttribute("admKey", id);
		
		String test = (String)session.getAttribute("idKey");
		%>
		<script>
			alert("�α��� �Ǿ����ϴ�.");
			if(confirm("������ �������� �̵��Ͻðڽ��ϱ�?")){
				//Ȯ�ι�ư Ŭ���� ����
				location.href = "../../Manager/muser/mUser.jsp";
			} else {
				//��ҹ�ư Ŭ���� ����
				location.href = "../../main.jsp";
			}
			
		</script>
	<% 
	} else { 
	%>
		<script>
			alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �õ����ּ���.");
			location.href = "../../User/loginout/login.jsp";
		</script>
	<% 
	} 
	%>	