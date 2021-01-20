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
		<link rel="stylesheet" href="../../../css/wish.css" type="text/css"/>
		
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
				<%
				if(id.equals("") || id == null){
				%>		
					<div class="head_btns">
						<input class="head_btn" type="button" value="로그인" onclick="location.href='../../loginout/login.jsp'">
						<input class="head_btn" type="button" value="회원가입" onclick="location.href='../../join/join.jsp'">
					</div>
				<%		
				}else {
				%>
					<div class="head_btns">
						<span class="head_id"><%= id %> 님</span>
						<input class="head_btn" type="button" value="로그아웃" onclick="location.href='../../loginout/logout.jsp'">
					</div>
				<%		
				}
				%>
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
						<span class="page_map">마이페이지 > 희망도서 신청</span>
					</div>
					<div class="content">
						<article class="article">
							<div class="contentPart">
								<h3><font color="orange">*</font>희망도서 신청 안내</h3>
								<ul class="info1">
									<li>신청일 포함 1주 3권 이내(권당 5만원 이하)</li>
									<li>신청대상 : 단행본(연속간행물, 비도서(전자책, 오디오북 등)은 신청 제외)</li>
									<li>희망도서 선정 : 도서관 운영위원회 심의를 거쳐 선정함</li>
								 	<li>희망도서 비치 알림 : SMS 전송(안내 문자 수신을 위해 개인정보수정에서 SMS 수신 체크 확인)</li>
									<li>우선대출기간 : 신청도서관 도서 비치일로부터 주말까지 </li>
								</ul>
							</div>
						</article>
						<div class="contentPart">
							<h3><font color="orange">*</font>희망도서 선정 제외기준</h3>
							<table class="wishInfoTable" border="1">
								<thead>
									<tr>
										<th scope="col">기 준</th>
										<th scope="col">내  용</th>
										<th scope="col">비 고 </th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="subTitle">가격</td>
										<td>5만원 이상인 도서</td>
										<td class="">&nbsp;</td>
									</tr>
									<tr>
										<td rowspan="11" class="subTitle">제외종류</td>
										<td>소장도서, 중복 신청도서, 신간 구입 예정도서</td>
										<td class="">&nbsp;</td>
									</tr>
									<tr>
										<td>문제집, 수험서, 참고서, 대학교재, 전문서적</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>서지사항이 불분명한 도서</td>
										<td>서명, 저자명, 출판사 등</td>
									</tr>
									<tr>
										<td>판타지,  로맨스, 무협지, 성인만화(학습만화 제외)</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>전집</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>미풍양속, 정서에 문제를 유발할 수 있는 유해도서</td>
										<td>음란서적, 폭력물 등</td>
									</tr>
									<tr>
										<td>영리 또는 정치 목적의 신청도서</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>간증 등 개인적 성향이 강한 종교 관련 도서</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>소장이 적합하지 않은 형태의 도서</td>
										<td>색칠, 스티커, 퍼즐, 컬러링북 등 교구가 많은 도서</td>
									</tr>
									<tr>
										<td>비슷한 주제를 여러 권 신청할 경우</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>정기간행물(잡지 등 연속간행물)</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td class="subTitle">입수가능성</td>
										<td>품절 및 절판 도서, 미출간도서</td>
										<td>희망도서 선정시점에 시중에 판매되지 않은 자료</td>
									</tr>
									<tr>
										<td class="subTitle">최신성</td>
										<td>발행된 지 5년 이상인 도서</td>
										<td>컴퓨터, 과학, 신학문 분야는 출판된 지 2년 이상인 자료</td>
									</tr>
								</tbody>
							</table>
						</div>
						<p class="tip"><font color="orange">※</font> 신청하신 자료는 자료선정위원회의 심의를 거쳐 구입, 정리 후 이용자에게 제공됩니다.</p>
						
						<div class="contentPart">
							<h3><font color="orange">*</font>희망도서 선정 확인</h3>
							<ul class="info2">
								<li>신청중 : 희망도서 담당자가 구입 타당성 검토 및 서지사항 확인 중인 상태</li>
								<li><font color="blue">처리중</font> : 희망도서를 구입에 반영하여 주문 중인 상태</li>
								<li><font color="red">취소됨</font> : 구입에서 제외된 상태(취소 사유 확인 가능)</li>
								<li><font color="green">소장중</font> : 희망도서를 자료실에 비치한 상태</li>
							</ul>
						</div>
						<div class="wishBtns">
							<input type="button" onclick="wishNeedLoginFn(0)" value="신청하기" class="wishBtn">
							<input type="button" onclick="wishNeedLoginFn(1)" value="신청확인" class="wishBtn">
						</div> 
					</div>
				</div>
			</section>
			<!-- section end -->
		
			<jsp:include page="../include/footer.jsp"/>
			<!-- footer end -->
			
		</div>
	</body>
</html>