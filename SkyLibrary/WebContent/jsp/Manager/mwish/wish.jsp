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
		
		<title>������� ����</title>
		
		<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/mwish.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/mwish.js" charset="EUC-KR"></script>
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
						<span class="info_title"><span class="point">*</span>������� ��û ����</span>
						<div class="optionBox">	
							��ȸ::
							Ÿ�Ա���:
							<select name="selectType" id="selectType">
								<option value="4">��ü</option>
								<option value="0">��û��</option>
								<option value="1">ó����</option>
								<option value="2">��ҵ�</option>
								<option value="3">������</option>
							</select>
							<span class="slot">|</span>
							ó���� ����:
							<input type="date" name="startDate" id="startDate">
							����
							<input type="date" name="endDate" id="endDate">
							����
							<input type="button" class="optionBox_btn" value="ã��" onclick="searchFn()">
							<span class="slot">|</span>
							ó��::
							��μ���:
							<input type="checkbox"  id="checkAll">
							<span class="slot">|</span>
							���õ� �� ó��:
							<select name="TypeSaveSelect" id="TypeSaveSelect">
								<option value="0">��û��</option>
								<option value="1">ó����</option>
								<option value="2">��ҵ�</option>
								<option value="3">������</option>
							</select>
							<input type="button" onclick="checkedSaveFn()" value="����" class="optionBox_btn">
						</div>
						<table class="table" border="1">
							<thead>
								<tr class="fixTable">
									<th width="50">��ȣ</th>
									<th width="150">���̵�</th>
									<th width="250">isbn</th>
									<th width="700">å�̸�</th>
									<th width="200">��û��</th>
									<th width="200">ó����</th>
									<th width="100">ó������</th>
									<th width="50">����</th>
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