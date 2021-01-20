<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>���� ����</title>
		
		<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/mqna.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/mqna.js" charset="EUC-KR"></script>
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
						<span class="info_title"><span class="point">*</span>���� ����</span>
						<div class="optionBox">	
							��ȸ::
							Ÿ�Ա���:
							<select name="selectType" id="selectType">
								<option value="2">��ü</option>
								<option value="0">�亯���</option>
								<option value="1">�亯�Ϸ�</option>
							</select>
							<span class="slot">|</span>
							�������� ����:
							<input type="date" name="startDate" id="startDate">
							����
							<input type="date" name="endDate" id="endDate">
							����
							<input type="button" class="optionBox_btn" value="ã��" onclick="searchFn()">
						</div>
						<table class="table" border="1">
							<thead>
								<tr class="fixTable">
									<th align="center" width="50">��ȣ</th>
									<th width="605">����</th>
									<th align="center" width="150">�ۼ���</th>
									<th align="center" width="200">�ۼ���</th>
									<th align="center" width="200">�亯��</th>
									<th align="center" width="200">����</th>
								</tr>
							</thead>
							<tbody id="result">
							</tbody>
						</table>
					</div>
					<div id="userInfoView" class="userInfoView">
						
					</div>
				</div>
			</section>
		</div>
	</body>
</html>