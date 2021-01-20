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
		
		<title>희망도서 관리</title>
		
		<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/mwish.css" type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/mwish.js" charset="EUC-KR"></script>
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
						<span class="info_title"><span class="point">*</span>희망도서 신청 정보</span>
						<div class="optionBox">	
							조회::
							타입구분:
							<select name="selectType" id="selectType">
								<option value="4">전체</option>
								<option value="0">신청중</option>
								<option value="1">처리중</option>
								<option value="2">취소됨</option>
								<option value="3">소장중</option>
							</select>
							<span class="slot">|</span>
							처리일 구분:
							<input type="date" name="startDate" id="startDate">
							에서
							<input type="date" name="endDate" id="endDate">
							까지
							<input type="button" class="optionBox_btn" value="찾기" onclick="searchFn()">
							<span class="slot">|</span>
							처리::
							모두선택:
							<input type="checkbox"  id="checkAll">
							<span class="slot">|</span>
							선택된 글 처리:
							<select name="TypeSaveSelect" id="TypeSaveSelect">
								<option value="0">신청중</option>
								<option value="1">처리중</option>
								<option value="2">취소됨</option>
								<option value="3">소장중</option>
							</select>
							<input type="button" onclick="checkedSaveFn()" value="저장" class="optionBox_btn">
						</div>
						<table class="table" border="1">
							<thead>
								<tr class="fixTable">
									<th width="50">번호</th>
									<th width="150">아이디</th>
									<th width="250">isbn</th>
									<th width="700">책이름</th>
									<th width="200">신청일</th>
									<th width="200">처리일</th>
									<th width="100">처리구분</th>
									<th width="50">선택</th>
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