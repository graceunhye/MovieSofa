<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�缭����</title>
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
		//���δ� �������ϱ�data �ʿ����!
		success: function(data)
		{
			if(data.trim() == "TRUE"){
				alert("��� ���� ���̵��Դϴ�.");
				document.frm.id.value = "";
			}else{
				alert("����Ͻ� �� �ִ� ���̵��Դϴ�.");
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
				<div class="title_box"><span class="head_title">������ ������ </span><span class="name">�ϴõ�����</span></div>
			</div>
		</header>
		<section>
			<jsp:include page="../include/nav.jsp" />
			<div class="section">
				<div class="user_info">
					<span class="info_title"><span class="point">*</span>�缭 ����</span>
					<br>
					<br>
					<div class="user_content">
					<br>
						<div class="mjoin_box">
							<form action="managerInsertOk.jsp" method="post" name="frm">
								<table>
									<tr height="50" class="login_txt">
										<td width="100" align="right" class="login_input"><span class="star id">*</span><span class="id_title">���̵�</span>:</td>
										<td width="300"> <input type="text" class="input" name="id" size="38" placeholder=" ���̵� �Է����ּ���."> </td>
										<td><input type="button" value="�ߺ�Ȯ��" onclick="ID_check()"class="optionBox_btn_free"  class="redup_btn"></td>
									</tr>
									<tr height="50" class="login_txt">
										<td align="right" class="login_input"><span class="star">*</span>��й�ȣ:</td>
										<td colspan="2"><input type="password" name="pw"  class="input" size="38" placeholder=" ��й�ȣ�� �Է����ּ���."></td>
									</tr>
									<tr class="login_option">
										<td align="right" class="login_input"><span class="star">*</span>�̸�:</td>
										<td colspan="2"><input type="text" name="name"  class="input" size="38" placeholder=" �̸��� �Է����ּ���."></td>
									</tr>
								</table>
								<br>
								<div class="insert_box">
									<input type="submit" value="���" class="optionBox_btn_free">
									<button type="button" class="optionBox_btn_free" onclick="location.href='manager.jsp'">���</button>									
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