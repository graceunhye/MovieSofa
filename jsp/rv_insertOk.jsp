<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File"%> 
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ include file="../include/openDB.jsp" %>  
<%
request.setCharacterEncoding("EUC-KR"); 
String id = (String)session.getAttribute("idKey");
if(id == null){ id = "";}


final String saveFolder = "D:\\������\\B��(������,������,�����,�ڼ���)\\07.�����ڷ�\\img\\upload";
final String encoding   = "EUC-KR";
final int maxSize       = 10*1024*1024; //10mb 

try{ 
	//������ ������ ���ε�Ǵ� ������ MultipartRequest ��ü ���� �����̴�. 
	MultipartRequest multi = null; 
	multi = new MultipartRequest (request, saveFolder, maxSize, encoding, new DefaultFileRenamePolicy());
	//request�� �Ǵ� ���� null�� ���Ѵ�. 
	//out.print("����"); 
	
	String fileName = multi.getFilesystemName("fname");
	//fileSelect.jsp ���Ͽ��� input �±� name 
	
	String original = multi.getOriginalFileName("fname"); 
	//filename�� �ߺ��̸��� ���� ��� �ڵ����� index�� �ٴµ�, index�Ǳ� ���� ������ 
	
	String type = multi.getContentType("fname"); 
	//� Ÿ���� �������� �˾Ƽ� �ؼ�����
	
	File f = multi.getFile("fname"); 
	//÷������ � ������ ���� ũ�� ������ 
	
	int len = 0; 
	if(f!=null) 
	{ 
		len = (int)f.length(); 
	} 

String rv_title = multi.getParameter("rv_title");    //��������
String rv_body  = multi.getParameter("rv_body");     //���䳻��
String rv_no    = multi.getParameter("rv_no");	     //�����ȣ
String mv_no    = multi.getParameter("mv_no");       //��ȭ��ȣ
String rv_file  = multi.getFilesystemName("fname");  //÷�����ϸ�
String sql="";									     



//rv_insert���� ������ ������ ���ο� ���� ����ϱ�
sql  = "insert into review ";
sql += "(id, mv_no , rv_title, rv_body, rv_date, rv_file) ";
sql += "values ";
sql += "(?, ?, ?, ?, now(), ?)";
mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );

mstmt.setString(1,id);           //���̵�
mstmt.setString(2,mv_no);        //��ȭ��ȣ
mstmt.setString(3,rv_title);     //��������
mstmt.setString(4,rv_body);      //���䳻��
mstmt.setString(5,rv_file);      //��������

mstmt.executeUpdate();
mstmt.close();



/**  ���� �ֱٿ� ��ϵ� �������� ��������  **/
sql = "select * from review where rv_no=last_insert_id()";
mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
rs = mstmt.executeQuery();
rs.next();



/**  �������� ��������  g=get **/
String gmv_no     = rs.getString("mv_no");     //��ȭ��ȣ 
String grv_no     = rs.getString("rv_no");     //�����ȣ 
String grv_writer = rs.getString("id");        //�����ۼ���
String grv_title  = rs.getString("rv_title");  //��������
String grv_body   = rs.getString("rv_body");   //���䳻��
String grv_date   = rs.getString("rv_date");   //�����ۼ���
String grv_hit    = rs.getString("rv_hit");    //������ȸ��
			
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- page info -->
		<title>���� ����ϱ�</title>
		<meta http-equiv="Content-type" content="text/html; charset=EUC-KR">
		
		<!-- script -->
	    <script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>

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
					if(!id.equals(""))
					{
					%>	
						<font style="font-weight:bold;"><%= id %> ��</font>
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
					<li class="menu_li"><a class="menu_a" onclick="alert('�غ����� �����Դϴ�.')">NEWS</a></li>
					<li class="menu_li"><a class="menu_a" onclick="alert('�غ����� �����Դϴ�.')">TALK</a></li>
					<form name="frm" id="frm" method="post" action="mv_search.jsp">
						<li class="menu_li">
							<select class="search_type" id="select" name="select">
								<option value="1">��ü</option>
								<option value="2">�ѱ���ȭ</option>
								<option value="3">�ؿܿ�ȭ</option>
							</select>
						</li>
						<li class="menu_li">
							<input class="search_text" type="text" placeholder="�˻�� �Է��ϼ���." id="key" name="key">
						</li>
						<li class="menu_li">
							<input class="search_btn" onclick="location.href='mv_search.jsp'" type="submit" value="search">
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
								<th width="12.5%" >�ۼ���</th>
								<td><%= grv_writer %></td>
								<th width="17.5%" >�ۼ���</th>
								<td><%= grv_date %></td>
								<th width="17.5%" >��ȸ��</th>
								<td><%= grv_hit %></td>
							</tr>
							<tr height="30px">
								<th>����</th>
								<td colspan="5" style="text-align:left"><%= grv_title %></td>
							</tr>
							<tr height="350px">
								<th>����</th>
								<td colspan="5" style="text-align:left"><%= grv_body %></td>
							</tr>
							<tr height="30px">
								<th>÷������</th>
								<td colspan="5" style="text-align:left;">
								<img src="mv_filedown.jsp?rv_file=<%= rv_file %>" width="300px">
								</td>
							</tr>
						</table>
					</form>	
					<div class="view_btn">
						<form action="mv_view.jsp" style="padding-left:10px;">
						
						
							<%
								if(id.equals(grv_writer)){ //id�� primary key�� �ߺ��� �� ����. ���� ���� Ȯ�� �� �� ������ �����ϴ�.
							%>
								<input onclick="location.href='rv_modify.jsp?rv_no=<%= grv_no %>&mv_no=<%= gmv_no %>'" class="view_btn_list" type="button"  value="����">
								<input onclick="location.href='rv_deleteOk.jsp?rv_no=<%= grv_no %>&mv_no=<%= gmv_no %>'" class="view_btn_list" type="button" value="����">
							<%		
								}
							%>
							
							
							<input type="hidden" id="mv_no" name="mv_no" value="<%= gmv_no %>">
							<input class="view_btn_list" type= "submit" value="���">
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
						if(id.equals("")){ //�α����� �Ǿ����� ���� ���
						%>
							<div class="comment">
								<table width="1000">
									<tr height="100px" class="comment_body">
										<td colspan="5" class="comment_body">
											<div style="padding-left:20px;">�α����� �ʿ��� �����Դϴ�.</div>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<input class="comment_btn" type="button" onclick="login()" value="���">
										</td>
									</tr>
								</table>
							</div>					
					<%
					}else{ //�α����� �Ǿ��ִ� ���
						%>
						<div class="comment">
							<form method="post" action="rv_commentOk.jsp">
								<table width="1000">
									<tr height="100px" class="comment_body">
										<td colspan="5" class="comment_body">
											<textarea cols="138" rows="7" id="ic_body" name="ic_body" style="border:none;scroll:none;resize:none;" ></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<button class="comment_btn" type="button" onclick="c_insertFn(<%= grv_no %>)" >���</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
						
						<%		
						}//if�� ����


					//�����ȣ�� ��� ������ ��ȸ��.
					sql = "select * from comment where rv_no="+rv_no+" order by c_no desc";
					mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
					rs = mstmt.executeQuery();
					
					
					
					//��� ������ �Ѹ�
					while(rs.next()){
						String gc_no     = rs.getString("c_no");     //��۹�ȣ
						String gc_body   = rs.getString("c_body");   //��۳���
						String gc_writer = rs.getString("id");       //����ۼ���
						String gc_date   = rs.getString("c_date");   //����ۼ���
					%>
					
					
					
						<div class="comment" width="1200" height="300">
							<table width="1000">
								<tr>
									<td width="80" colspan="2" style="padding-left: 10px">
										<b>
										
											�ۼ���:&nbsp;<%= gc_writer %>
											
											
											<%
												if(id.equals(gc_writer)){
											%>
												<div id="cbtns_<%= gc_no %>" style="display:inline">
													<button class="comment_btns" id="cbtn_<%= gc_no %>" onclick='c_updateFn(<%= gc_no %>,<%= grv_no %>)'>����</button>
													<button class="comment_btns" id="cdbtn_<%= gc_no %>" onclick='c_deleteFn(<%= gc_no %>,<%= grv_no %>)'>����</button>
												</div>
											<%
											} //if�� ����
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
					}//while�� ����
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
		str += "	<button class='comment_btns' onclick='c_saveFn("+no+","+rv_no+")'>����</button>";
		str += "	<button class='comment_btns' onclick='c_deleteFn("+no+","+rv_no+")'>����</button>";
		str += "</div>"
		
		str2 = "";
		str2 += "<textarea cols='120' rows='5' id='ic_body"+no+"' name='ic_body' style='border:none;scroll:none;resize:none;'>"+text+"</textarea>";
		
		$("#cbtns_"+no).html(str);
		$("#comment_"+no).html(str2);
	}//updateFn ����
	
		
	function c_saveFn(no,rv_no) {
		var text = $("#ic_body"+no).val();
		
		if(text == null || text == "") {
			alert("������ �Է����ּ���.");
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
					str2 += "	<button class='comment_btns' id='cbtn_"+json[0]["c_no"]+"' onclick='c_updateFn("+json[0]["c_no"]+","+json[0]["rv_no"]+")'>����</button>";
					str2 += "	<button class='comment_btns' id='cdbtn_"+json[0]["c_no"]+"' onclick='c_deleteFn("+json[0]["c_no"]+","+json[0]["rv_no"]+")'>����</button>";
					str2 += "</div>"
					
					$("#ic_body"+json[0]["c_no"]).remove();
					$("#c_body_"+json[0]["c_no"]).html(str);
					$("#cbtns_"+no).html(str2);
					alert("����Ǿ����ϴ�.");
				}
						
			});//ajax ����
		}//if�� ����
	}//saveFn ����

	function c_deleteFn(no,rv_no) {
		$.ajax({
			url: "c_deleteOk.jsp",
			type: "get",
			data: {no:no},
			success: function(){
				
				alert("�����Ǿ����ϴ�.");
				location.href="rv_view.jsp?rv_no="+rv_no;
			}
		});
	}//deleteFn ����

	function c_insertFn(){
		var c_body = $("#ic_body").val();
		var rv_no = $("#rv_no").val();
		
		if(c_body == null || c_body=="") {
			alert("������ �Է����ּ���.");
			$("#ic_body").focus();
			
		}else {
			$.ajax({
				url: "c_insertOk.jsp",
				type:"post",
				data: {ic_body : c_body,
				rv_no : rv_no},
				success:function(){
					alert("��ϵǾ����ϴ�.")
					location.href="rv_view.jsp?rv_no="+rv_no;
				}
			});
		}//if�� ����
	}//insertFn ����
</script>
<%


	if(mstmt != null) try{ mstmt.close(); } catch(Exception e){ e.printStackTrace(); }
	if(rs    != null) try{ rs.close();    } catch(Exception e){ e.printStackTrace(); }
	if(conn  != null) try{ conn.close();  } catch(Exception e){ e.printStackTrace(); }

}catch(Exception e){
	
	e.printStackTrace();
}
%>