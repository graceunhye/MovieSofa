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
		
		<title>��� ���� ��û</title>
		
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
						<a href="#section"><span class="rightnow_click">���� �ٷΰ���</span></a>
					</div>
					<div class="head_btns">
						<span class="head_id"><%= id %> ��</span>
						<input class="head_btn" type="button" value="�α׾ƿ�" onclick="location.href='../../loginout/logout.jsp'">
					</div>
				</div>
				<div class="head_banner">
					<div class="banner_option">
						<a href="../../main.jsp"><img class="logoImg" src="../../../img/homePage/logo.png" width="400" alt="�ΰ�"></a>
					</div>
					<nav class="top_menu">
						<ul>
							<li><a href="../search/total.jsp">�����˻�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../use/useTime.jsp">������ �̿�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="../intro/notice.jsp">������ �Ұ�</a></li>
							<li class="rain"><img src="../../../img/homePage/rain.png" width="20px" alt="�����"></li>
							<li><a href="javascript:needLoginFn('<%= id %>')" class="myPage">����������</a></li>
						</ul>
					</nav>
				</div>
			</header>
			<!-- header end -->
		
			<section id="section">
				<nav class="left_menu">
					<ul>
						<li class="left_menu_title">����������</li>
						<a href="userInfo.jsp"><li class="left_menu_sub">ȸ������</li></a>
						<a href="wish.jsp"><li class="on left_menu_sub">������� ��û</li></a>
						<a href="renting.jsp"><li class="left_menu_sub last_sub">���⵵�� ��ȸ</li></a>
					</ul>
				</nav>
				<!-- nav end -->
				
				<div class="section">
					<div class="section_top">
						<span class="top_title">������� ��û</span>
						<span class="page_map">���������� > ������� ��û > ��û�ϱ�</span>
					</div>
					<div class="content">
						<form method="post" action="wishApplyOk.jsp">
						<p class="tip"><span class="point">*</span> ǥ�õ� �׸��� �ʼ� �Է� �׸��Դϴ�</p>
						<table class="wish_table" >
							<tbody>
								<tr>
									<th scope="row"><label for="subject">������<span class="point">*</span></label></th>
									<td><input type="text" id="subject" name="subject" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="isbn">isbn <span class="point">*</span></label>
										</th>
									<td><input type="text" id="isbn"  name="isbn"/></td>
								</tr>
								<tr>
									<th scope="row"><label for="pdate">����⵵ <span class="point">*</span></label></th>
									<td><input type="text" id="pdate" name="pdate" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="price">����<span class="point">*</span></label></th>
									<td><input type="text" name="price" id="price" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="writer">���ڸ�</label></th>
									<td><input type="text" name="writer" id="writer" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="company">������</label></th>
									<td><input type="text" id="company" name="company" /></td>
								</tr>
								<tr>
									<th class="last" scope="row"><label for="why">��û����</label></th>
									<td class="last"><textarea id="why" name="why" class="textarea" cols="85" rows="10"></textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="btns"><input class="btn" type="submit" value="��û"/><input class="btn" type="button" value="���" onclick="wishCancelFn()"/></div>
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