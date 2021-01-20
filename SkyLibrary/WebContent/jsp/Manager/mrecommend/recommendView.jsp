<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	String isbn = request.getParameter("isbn");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�缭 ��õ ��������</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<link rel="stylesheet" href="../../../css/mrecommendView.css" type="text/css"/>
<script src="../../../js/jquery-3.5.1.min.js"></script>
<script>
	function InsertFn(){	
		var textVal = $("#recommend").val();
		var data = {
				recommend : textVal
		}
		
		$.ajax({
			url : "recommendInsert.jsp?isbn="+<%= isbn %>+"",
			type : "post",
			data : $.param(data),
			success : function(result){
				var json = JSON.parse(result);
				var str = "";
				str += "<span id='titleSp_"+json[0]["no"]+"' style='display:inline-block;width:90%;'>" + json[0]["why"] + "</span><br><br>"
				str += "<span id='btnSp_"+json[0]["no"]+"'><button type='button' class='optionBox_btn_free'  onclick='modifyFn("+json[0]["no"]+")'>����</button> <button type='button' onclick='deleteFn("+json[0]["no"]+")'>����</button></span>"
				$("#recommend_box").html(str);
			}
		});	
	}
	
	
	function modifyFn(no){
		var titleVal = $("#titleSp_"+no).text();
		var str1 = "<textarea id='text_"+no+"' cols='100' rows='15'></textarea>";
		var str2 = "<button type='button' onclick='saveFn("+no+")'>����</button> <button  class='optionBox_btn_free' type='button' onclick='deleteFn("+no+")'>����</button>";
		$("#titleSp_"+no).html(str1);
		$("#btnSp_"+no).html(str2);
		$("#text_"+no).val(titleVal);
	}
	
	
	function saveFn(num){
		var textVal = $("#text_"+num).val();
		alert("!"+textVal);
		var data = {
				recommend : textVal,
				no    : num
		}
		$.ajax({
			url : "recommendUpdate.jsp?isbn="+<%= isbn %>+"",
			type : "get",
			data : $.param(data), //"title=tttt&no=17"ó�� �Ķ���� ���ڿ��� ��������, $("form").serialize() ���� �ִ� ������ ���ڿ���, $("form").serializeArray()
			success : function(result){
				var json = JSON.parse(result); //json ��ü �����͸� �ڹٽ�ũ��Ʈ ��ü�� �������ִ� ����
				$("#titleSp_"+num).html(json[0]["why"]);
				
				var str = "<button type='button'  class='optionBox_btn_free' onclick='modifyFn("+num+")'>����</button>";
				$("#btnSp_"+num).html(str);
			}
		});
	}
	
	function deleteFn(num){
		if(confirm("��õ������ �����Ͻðڽ��ϱ�?") == true) {
			$.ajax({
				url : "recommendDelete.jsp?isbn="+<%= isbn %>+"",
				type : "get",
				data : "no="+num,
				success : function(result){
					alert("�����Ͱ� �����Ǿ����ϴ�.");
					location.href = "recommendView.jsp?isbn="+<%= isbn %>+"";
				}
			});
		}	
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
				<span class="info_title"><span class="point">*</span>�缭 ��õ ����</span>				
				</div>
				<br>
				<br>	
							<div class="content">
			
			<%
			
			Connection conn;
			PreparedStatement mstmt;
			ResultSet rs;
			
			String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
			String     mUserID   = "root";
			String     mUserPass = "mySQL1234";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
			
			String sql = "";
			sql = "select * from book left join rbook ";
			sql += "on book.isbn = rbook.isbn ";
			sql += "where book.isbn = '" + isbn + "'" ;
			sql += "union ";
			sql += "select * from book right join rbook ";
			sql += "on book.isbn = rbook.isbn ";
			sql += "where book.isbn = '" + isbn + "'";			
					
			mstmt  = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = mstmt.executeQuery();
			rs.next();	
	
			
			/**  å���� ��������  **/
			String	gsubject    = rs.getString("subject");      //å����
			String	gstory      = rs.getString("story");	    //å �ٰŸ�		
			String	gpdate      = rs.getString("pdate");        //������
			String	gcoverimg   = rs.getString("coverimg");     //åĿ���̹���
			String	gcompany    = rs.getString("company");      //���ǻ�
			String	gwriter     = rs.getString("writer");       //����
			String	gisbn       = rs.getString("isbn");         //ISBN
			int 	grent       = rs.getInt("rent");            //�뿩����  0:���Ⱑ��, 1:������
			
			//String gstard = rs.getString("starrd");
			String gwhy = rs.getString("why");
			Integer gno = rs.getInt("no");
		
			rs.close();
			mstmt.close();		
			%> 
				<div class="searchview">
					<div class="searchview1">
						<table border="1" width="800px" style="border-collapse:collapse">
							<tr>
								<td colspan="3" align="center" height="50"><b><%= gsubject %></b></td>
							</tr>
							<tr>
								<td rowspan="6" width="15%" align="center">
									<img src="<%= gcoverimg %>" alt="<%= gsubject %>" width="82px">
								</td>
								<th>����</th>
								<td><%= gwriter %></td>
							</tr>
							<tr>
								<th>���ǻ�</th>
								<td><%= gcompany %></td>							
							</tr>
							<tr>
								<th>������</th>
								<td><%= gpdate %></td>							
							</tr>
							<tr>
								<th>ISBN</th>
								<td><%= gisbn %></td>							
							</tr>
							<tr>
								<th>������</th>
								<td>�ϴ� ������</td>							
							</tr>
						</table>
					</div>
					<br>
					<div class="searchview2">
					| ������
					<br>
					<br>
						<table border="1" width="800px" style="border-collapse:collapse">
							<tr>
								<td><%= gstory %>
								</td>
							</tr>
						</table>
					</div>
					<br>
					<div class="searchview3">
					| ��õ����
					<br>
					<br>
					<table border="1" width="800px" style="border-collapse:collapse">
						<% if (gwhy != null) {
						%>
						<tr>
							<td>
								<span id="titleSp_<%= gno %>"><%= gwhy %></span>
								<br>
								<br>
								<span id="btnSp_<%= gno %>"><input type="button"  class="optionBox_btn_free" id="modify_btn" name="modify_btn" value="����" onclick="modifyFn(<%= gno %>)">	
								<input type="button" id="delete_btn" name="delete_btn" value="����"  class="optionBox_btn_free" onclick="deleteFn(<%= gno %>)"></span>	
							</td>
						</tr>
						<% } else { %>
						<tr>
							<td id="recommend_box">
								<textarea id="recommend" name="recommend" cols="100" rows="15"></textarea>
								<input type="hidden" id="recommend_num" name="recommend_num" value="">
								<input type="button" id="insert_btn" name="insert_btn" value="���"  class="optionBox_btn_free" onclick="InsertFn()">
							</td>
						</tr>
						<% } %>								
					</table>
					</div>
				</div>
			</div>
			</div>
		</section>
	</div>
</body>
</html>