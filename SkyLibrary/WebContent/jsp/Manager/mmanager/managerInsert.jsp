<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사서관리</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<link rel="stylesheet" href="../../../css/managerInsert.css" type="text/css"/>

<script src="../mnotice/js/jquery-3.5.1.min.js"></script>
<script>

function ID_check(){				
	
	var id = document.frm.id.value;
	//alert(id);
	$.ajax({
		url:"managerInsertCheck.jsp?id=" + id,
		type:"get",
		//전부다 가져오니까data 필요없다!
		success: function(data)
		{
			if(data.trim() == "TRUE"){
				alert("사용 중인 아이디입니다.");
				document.frm.id.value = "";
			}else{
				alert("사용하실 수 있는 아이디입니다.");
			}
		}
	});
		
}
</script>
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
					<span class="info_title"><span class="point">*</span>사서 관리</span>
					<br>
					<br>
					<div class="user_content">
					<br>
						<div class="mjoin_box">
							<form action="managerInsertOk.jsp" method="post" name="frm">
								<table>
									<tr height="50" class="login_txt">
										<td width="100" align="right" class="login_input"><span class="star id">*</span><span class="id_title">아이디</span>:</td>
										<td width="300"> <input type="text" class="input" name="id" size="38" placeholder=" 아이디를 입력해주세요."> </td>
										<td><input type="button" value="중복확인" onclick="ID_check()"class="optionBox_btn_free"  class="redup_btn"></td>
									</tr>
									<tr height="50" class="login_txt">
										<td align="right" class="login_input"><span class="star">*</span>비밀번호:</td>
										<td colspan="2"><input type="password" name="pw"  class="input" size="38" placeholder=" 비밀번호를 입력해주세요."></td>
									</tr>
									<tr class="login_option">
										<td align="right" class="login_input"><span class="star">*</span>이름:</td>
										<td colspan="2"><input type="text" name="name"  class="input" size="38" placeholder=" 이름을 입력해주세요."></td>
									</tr>
								</table>
								<br>
								<div class="insert_box">
									<input type="submit" value="등록" class="optionBox_btn_free">
									<button type="button" class="optionBox_btn_free" onclick="location.href='manager.jsp'">취소</button>									
								</div>	
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
</html>