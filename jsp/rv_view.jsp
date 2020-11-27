<!-- 오류: 댓글 추가 후 새로고침시 같은 내용의 댓글이 추가로 등록됨. -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../include/openDB.jsp" %>  
<% 


	//이전 페이지로부터 받은 파라메터값 및 인코딩정보
	request.setCharacterEncoding("EUC-KR");
	String mv_no    = request.getParameter("mv_no");     //영화 번호
	String rv_no    = request.getParameter("rv_no");     //리뷰 번호
	String c_no     = request.getParameter("c_no");  	 //리뷰 번호
	String c_body   = request.getParameter("insert_r_body");
	String sql = "";	

	//세션 아이디값
	String id = (String)session.getAttribute("idKey");
	
	
	//null값일때 ""로 기본 셋팅해 오류를 줄임. null값은 다양한 오류가 생기기 쉬움.
	//sql구문에  null을 집어넣을 순 없기 때문에 ""를 넣는다.
	if(id       == null) { id       = ""; }
	if(rv_no    == null) { rv_no    = ""; }
	if(c_no     == null) { c_no     = ""; }
	if(c_body   == null) { c_body   = ""; }
	
	
	
	
	/** 조회수 증가  **/
	sql  = "update review ";
	sql += "set rv_hit=rv_hit+1 ";
	sql += "where rv_no="+rv_no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	mstmt.executeUpdate();
	mstmt.close();
	
	
	
	/** 리뷰번호로 리뷰의 정보를 조회함. **/
	sql = "select * from review where rv_no="+rv_no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();

	/** 리뷰정보 가져오기  g=get **/
	String gmv_no     = rs.getString("mv_no");    //영화번호 
	String grv_no     = rs.getString("rv_no");    //리뷰번호 
	String grv_writer = rs.getString("id");       //리뷰작성자
	String grv_title  = rs.getString("rv_title"); //리뷰제목
	String grv_body   = rs.getString("rv_body");  //리뷰내용
	String grv_date   = rs.getString("rv_date");  //리뷰작성일
	String grv_hit    = rs.getString("rv_hit");   //리뷰조회수
	String grv_file   = rs.getString("rv_file");  //첨부파일

	rs.close();
	mstmt.close();
	//리뷰정보 종료
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title></title>
		<meta http-equiv="Content-type" content="text/html; charset=utf-8">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
		<script type="text/javascript" src="../js/alert_login.js"></script>
			
		<!-- css -->
	    <link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="stylesheet" type="text/css" href="../css/rv_view.css">
		<link rel="stylesheet" type="text/css" href="../css/rv_comment.css">
		
	</head>
	<!-- head end -->
	
	<body style="background-color:#2E2D2C;margin:0;">
		<div class="wrap">
			<header style="align: center;">
				<div style="text-align:right;">
				
					<% 
					if( !id.equals("") )
					{
					%>	
						<font style="font-weight:bold;"><%= id %> 님</font>
						<a class="a" href="sessionLogout.jsp">LOGOUT</a> 
					<% 
					} else {
					%> 
						<a class="a" href="sessionLogin.jsp">LOGIN</a>
						<a class="a" href="mv_join.jsp">JOIN</a>	
					<% 	
					}
					%>  
					
				</div>
				<div style="margin-left: 470px">
					<a class="a" href="home.jsp">
						<img src="../img/page/logo.png" name="logo" id="logo" width="300px">
					</a>
				</div>
			</header>
			<!-- header end -->
		
			<nav style="width: 1280px;height: 48px; background-color: #2E2D2C;position: sticky;top:0;">
			   <ul class="menu">
					<li class="menu_li"><a class="menu_a" href="mv_main.jsp">BOXOFFICE</a></li>
					<li class="menu_li"><a class="menu_a" href="mv_list.jsp">REVIEW</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">NEWS</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('준비중인 서비스입니다.')">TALK</a></li>
					<form name="frm" id="frm" method="post" action="mv_search.jsp">
						<li class="menu_li">
							<select class="search_type" id="select" name="select">
								<option value="1">전체</option>
								<option value="2">한국영화</option>
								<option value="3">해외영화</option>
							</select>
						</li>
						<li class="menu_li">
							<input class="search_text" type="text" id="key" name="key" placeholder="검색어를 입력하세요.">
						</li>
						<li class="menu_li">
							<input class="search_btn" type="submit" value="search">
						</li>
					</form>
				</ul>				
			</nav>	
			<!-- nav end -->
			
			<section>
				<div style="padding-top:10px; padding-bottom:30px;"> 
					<form>
						<h2 id="title" style="color:#2e2d2c; text-align:center;"></h2> 
						<table class="reviewTable" align="center" width="1000px">
							<tr height="30px">
								<th width="12.5%" >작성자</th>
								<td><%= grv_writer %></td>
								<th width="17.5%" >작성일</th>
								<td><%= grv_date %></td>
								<th width="17.5%" >조회수</th>
								<td><%= grv_hit %></td>
							</tr>
							<tr height="30px">
								<th>제목</th>
								<td colspan="5" style="text-align:left"><%= grv_title %></td>
							</tr>
							<tr height="350px">
								<th>내용</th>
								<td colspan="5" style="text-align:left"><%= grv_body %></td>
							</tr>
							<tr height="30px">
								<th>첨부파일</th>
								<td colspan="5" style="text-align:left;"> 
								<img src="mv_filedown.jsp?rv_file=<%= grv_file %>" width="300px">
								</td>
							</tr>
						</table>
					</form>	
					<div class="view_btn">
						<form action="rv_list.jsp" style="padding-left:10px;">
							<%
								if(id.equals(grv_writer)){ //id는 primary key로 중복될 수 없음. 따라서 본인 확인 시 값 대조에 용이하다.
							%>
								<input onclick="location.href='rv_modify.jsp?rv_no=<%= grv_no %>&mv_no=<%= gmv_no %>'" class="view_btn_list" type="button" value="수정">
								<input onclick="location.href='rv_deleteOk.jsp?rv_no=<%= grv_no %>&mv_no=<%= gmv_no %>'" class="view_btn_list" type="button" value="삭제">
								<input type="hidden" id="mv_no" name="mv_no" value="<%= gmv_no %>">
								<input class="view_btn_list" type= "submit" value="목록">
							<%		
								}else{
							%>
								<input type="hidden" id="mv_no" name="mv_no" value="<%= gmv_no %>">
								<input class="view_btn_list" type= "submit" value="목록" style="margin-left:200px;">
							<%
								}
							%>
				
						</form>
					</div>
				</div>
			</section>
			<!-- section end -->
			
			<section>
				<div class="comment_box">
					<hr class="hr">
					<div class="comment_option">
						<div class="comment_title"><h2 class="comment_span" >Comment</h2></div>
					</div>
						<%		
						if(id.equals("")){ //로그인이 되어있지 않은 경우
						%>
							<div class="comment">
								<table width="1000">
									<tr height="100px" class="comment_body">
										<td colspan="5" class="comment_body">
											<div style="padding-left:20px;">로그인이 필요한 서비스입니다.</div>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<input class="comment_btn" type="button" onclick="login()" value="등록">
										</td>
									</tr>
								</table>
							</div>					
					<%
					}else{ //로그인이 되어있는 경우
						%>
						<div class="comment">
							<form method="post" action="rv_commentOk.jsp">
								<table width="1000">
									<tr height="100px" class="comment_body">
										<td colspan="5" class="comment_body">
											<input type="hidden" id="rv_no" value="<%= grv_no %>">
											<textarea cols="138" rows="7" id="ic_body" name="ic_body" style="border:none;scroll:none;resize:none;" ></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<button class="comment_btn" type="button" onclick="c_insertFn()" >등록</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
						
						<%		
						}//if문 종료


					/** 리뷰번호로 댓글 정보를 조회함. **/
					sql = "select * from comment where rv_no="+rv_no+" order by c_no desc";
					mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
					rs = mstmt.executeQuery();
					
					
					
					/** 댓글 정보를 뿌림  g=get  **/
					while(rs.next()){
						String gc_no     = rs.getString("c_no");     //댓글번호
						String gc_body   = rs.getString("c_body");   //댓글내용
						String gc_writer = rs.getString("id");       //댓글작성자
						String gc_date   = rs.getString("c_date");   //댓글작성일
						
					%>
					
					
						<div class="comment" width="1200" height="300">
							<table width="1000">
								<tr>
									<td width="80" colspan="2" style="padding-left: 10px">
										<b>
										
											작성자:&nbsp;<%= gc_writer %>
											
											
											<%
												if(id.equals(gc_writer)){ //작성자와 아이디가 일치할 경우
											%>
												<div id="cbtns_<%= gc_no %>" style="display:inline">
													<button class="comment_btns" id="cbtn_<%= gc_no %>" onclick='c_updateFn(<%= gc_no %>,<%= grv_no %>)'>수정</button>
													<button class="comment_btns" id="cdbtn_<%= gc_no %>" onclick='c_deleteFn(<%= gc_no %>,<%= grv_no %>)'>삭제</button>
												</div>
											<%
											} //if문 종료
											%>
											
											
										</b>
									</td>
									<td colspan="3" align="right" style="color:gray;padding-right: 10px;" id="c_date_<%= gc_no%>"><%= gc_date %></td>
								</tr>
								<tr height="100px" class="comment_body">
									<td colspan="5" style="padding: 10px;" class="comment_body" id="c_body_<%= gc_no %>">
										<div id="comment_<%= gc_no %>"><%= gc_body %></div>
									</td>
								</tr>
							</table>
						</div>
						
					<%
					}//while문 종료			
					%>
					
				</div>
			</section>
			<!-- comment end -->
			
			<footer style="background-color:#2e2d2c;height:100px;">
				<div class="footer">
					<ul>
						<li class="footer_title">       Crew member</li>
						<li class="footer_content">     Kang GoEun</li>
						<li class="footer_content">     Park SuJin</li>
						<li class="footer_content">     Bae MinJu</li>
						<li class="footer_content">     Song EunHye</li>
						<li class="footer_title">&copy; moviesofa</li>
					</ul>
				</div>
			</footer>
			<!-- footer end -->
			
		</div>
	</body>
	<!-- body end -->		
</html>

<script language="javaScript" charset="EUC-KR">


	function c_updateFn(no,rv_no) { 
		var text = $("#comment_"+no).text();
		str = "";
		str += "<div id='cbtns_"+no+"' style='display:inline'>"
		str += "	<button class='comment_btns' onclick='c_saveFn("+no+","+rv_no+")'>저장</button>";
		str += "	<button class='comment_btns' onclick='c_deleteFn("+no+","+rv_no+")'>삭제</button>";
		str += "</div>"
		
		str2 = "";
		str2 += "<textarea cols='120' rows='5' id='ic_body"+no+"' name='ic_body' style='border:none;scroll:none;resize:none;'>"+text+"</textarea>";
		
		$("#cbtns_"+no).html(str);
		$("#comment_"+no).html(str2);
	}
	
		
	function c_saveFn(no,rv_no) {
		var text = $("#ic_body"+no).val();
		
		if(text == null || text == "") {
			alert("내용을 입력해주세요.");
			$("#ic_body"+no).focus();
			
		}else {
			$.ajax ({
				url: "c_modifyOk.jsp",
				type: "post",
				data: {
					c_body : $("#ic_body"+no).val(),
					no : no
				},
				success: function(data) {
					var json = JSON.parse(data);
					var str = "";
					str += "<div id='comment_"+json[0]["c_no"]+"'>"+json[0]["c_body"]+"</div>";
					
					var str2 = "";
					str2 += "<div id='cbtns_"+json[0]["c_no"]+"' style='display:inline'>";
					str2 += "	<button class='comment_btns' id='cbtn_"+json[0]["c_no"]+"' onclick='c_updateFn("+json[0]["c_no"]+","+json[0]["rv_no"]+")'>수정</button>";
					str2 += "	<button class='comment_btns' id='cdbtn_"+json[0]["c_no"]+"' onclick='c_deleteFn("+json[0]["c_no"]+","+json[0]["rv_no"]+")'>삭제</button>";
					str2 += "</div>"
					
					$("#ic_body"+json[0]["c_no"]).remove();
					$("#c_body_"+json[0]["c_no"]).html(str);
					$("#cbtns_"+no).html(str2);
					alert("저장되었습니다.");
				}
						
			});//ajax 종료
		}//if문 종료
	}//saveFn 종료

	function c_deleteFn(no,rv_no) {
		$.ajax({
			url: "c_deleteOk.jsp",
			type: "get",
			data: {no:no},
			success: function(){
				
				alert("삭제되었습니다.");
				location.href="rv_view.jsp?rv_no="+rv_no;
			}
		});
	}

	function c_insertFn(){
	var c_body = $("#ic_body").val();
	var rv_no = $("#rv_no").val();
	
	if(c_body == null || c_body=="") {
		alert("내용을 입력해주세요.");
		$("#ic_body").focus();
		
	}else {
		$.ajax({
			url: "c_insertOk.jsp",
			type:"post",
			data: {ic_body : c_body,
			rv_no : rv_no},
			success:function(){
				alert("등록되었습니다.")
				location.href="rv_view.jsp?rv_no="+rv_no;
			}
		});
	}
	}
</script>
<%
if(mstmt != null) try{ mstmt.close(); } catch(Exception e){ e.printStackTrace(); }
if(rs    != null) try{ rs.close();    } catch(Exception e){ e.printStackTrace(); }
if(conn  != null) try{ conn.close();  } catch(Exception e){ e.printStackTrace(); }
%>