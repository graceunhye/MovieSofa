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
			alert("로그인 되었습니다.");
			if(confirm("관리자 페이지로 이동하시겠습니까?")){
				//확인버튼 클릭시 동작
				location.href = "../../Manager/muser/mUser.jsp";
			} else {
				//취소버튼 클릭시 동작
				location.href = "../../main.jsp";
			}
			
		</script>
	<% 
	} else { 
	%>
		<script>
			alert("아이디 또는 비밀번호가 일치하지 않습니다. 다시 시도해주세요.");
			location.href = "../../User/loginout/login.jsp";
		</script>
	<% 
	} 
	%>	