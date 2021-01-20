<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

%>	
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		
		<title>희망 도서 신청</title>
		
		<link rel="stylesheet" href="../../../css/common.css" type="text/css"/>
		<link rel="stylesheet" href="../../../css/wish.css"   type="text/css"/>
		
		<script src="../../../js/jquery-3.5.1.min.js"></script>
		<script src="../../../js/common.js"></script>
	</head>
	<body style="margin:0px">
		<div class="wrap"> 
			<header>
				<div class="head_option">
					<div class="rightnow">
						<a href="#section"><span class="rightnow_click">본문 바로가기</span></a>
					</div>
					<div class="head_btns">
						<span class="head_id"><%= id %> 님</span>
						<input class="head_btn" type="button" value="로그아웃" onclick="location.href='../../loginout/logout.jsp'">
					</div>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp"><img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="로고"></a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="../search/total.jsp">도서검색</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="../use/useTime.jsp">도서관 이용</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="../intro/notice.jsp">도서관 소개</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="빗방울"></li>
							<li><a href="javascript:needLoginFn('<%= id %>')" class="myPage">마이페이지</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
		
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">마이페이지</li>
						<a href="userInfo.jsp"><li class="left_menu_sub">회원정보</li></a>
						<a href="wish.jsp"><li class="on left_menu_sub">희망도서 신청</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">대출도서 조회</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">희망도서 신청</span>
						<span class="page_map">마이페이지 > 희망도서 신청 > 신청하기</span>
					</div>
					<div class="content">
						<form method="post" action="wishApplyOk.jsp">
						<p class="tip"><span class="point">*</span> 표시된 항목은 필수 입력 항목입니다</p>
						<table class="wish_table" >
							<tbody>
								<tr>
									<th scope="row"><label for="subject">도서명<span class="point">*</span></label></th>
									<td><input type="text" id="subject" name="subject" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="isbn">isbn <span class="point">*</span></label>
										</th>
									<td><input type="text" id="isbn"  name="isbn"/></td>
								</tr>
								<tr>
									<th scope="row"><label for="pdate">발행년도 <span class="point">*</span></label></th>
									<td><input type="text" id="pdate" name="pdate" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="price">가격<span class="point">*</span></label></th>
									<td><input type="text" name="price" id="price" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="writer">저자명</label></th>
									<td><input type="text" name="writer" id="writer" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="company">발행자</label></th>
									<td><input type="text" id="company" name="company" /></td>
								</tr>
								<tr>
									<th class="last" scope="row"><label for="why">신청이유</label></th>
									<td class="last"><textarea id="why" name="why" class="textarea" cols="85" rows="10"></textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="btns"><input class="btn" type="submit" value="신청"/><input class="btn" type="button" value="취소" onclick="wishCancelFn()"/></div>
						</form>
					</div>
				</div>
			</section>
			<!-- section end -->
				
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
			
		</div>
	</body>
</html>