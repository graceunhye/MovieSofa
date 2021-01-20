<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %> 
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	String no = request.getParameter("no");	
	
	Connection conn;
	PreparedStatement mstmt;
	ResultSet rs;
	
	String     mDBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     mUserID   = "root";
	String     mUserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( mDBMS ,mUserID ,mUserPass );
	
	/** �������� �� ��ȣ�� �������� ��ȸ **/
	String sql = "select * from notice where no="+no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = mstmt.executeQuery();
	rs.next();
	
	/** �������� ���� �������� **/
	//String gno        = rs.getString("no");    //�������׹�ȣ
	//String vMid       = rs.getString("mid");   //�缭���̵�
	String gtitle     = rs.getString("title"); //������������ 
	String gbody      = rs.getString("body");  //�������׳���
	String gnfile     = rs.getString("nfile"); //��������÷������
	
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ����</title>
<link rel="stylesheet" href="../../../css/mCommon.css" type="text/css"/>
<script type="text/javascript" src="../mnotice/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script src="../mnotice/js/jquery-3.5.1.min.js"></script>
<script>
	var value = "";
	
	function readInputFile(input)
	{
		if(input.files && input.files[0])
		{
			var reader = new FileReader();
			reader.onload = function(e)
			{
				var str = "";
				str += "<img src="+ e.target.result +" width='300px'>";
				str += "<button type='button' id='del'>����</button>";
				$("#pic").html(str);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$(document).ready(function(){
		$("input[type=file]").on('change', function()
		{
			readInputFile(this);
		});
		
		$(document).on('click', "#del", function()
		{
			$("#pic").html("");
			$("input:file").val("");
		});
	});

</script>
<style>
	/** noticeInsert.jsp css **/
	.insert_btn{
		width : 100px;
		positon : relative;
		margin-left : 63%;
	}
</style>
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
					<span class="info_title"><span class="point">*</span>�������� ���</span>
					<br>
					<br>
					<form name="frm" id="frm" method="post" action="noticeModifyOk.jsp?no=<%= no %>" enctype="multipart/form-data">
						<table width="1300px">
							<tr>
								<td>����</td>
								<td><input type="text" size="128" id="title" name="title" value="<%= gtitle %>"></td>
							</tr>	
							<tr>
								<td>����</td>
								<td><textarea name="ir1" id="ir1" rows="30" cols="130"><%= gbody %></textarea></td>
							</tr>
							<tr>
								<td>÷������</td>
								<td>
								<%
									if(gnfile != null){
										%>
										<div id="pic">
											<img src="noticeFileDown.jsp?nfile=<%= gnfile %>" width="300px">
										</div>	
										<input type="file" id="fname" name="fname">
										<%
									} else {
										%><%
									}
								%>	
								</td>
							</tr>	
						</table>
						<br>
						<br>
						<div class="insert_btn">
							<input type="submit" value="���" id="nmodify">
							<input type="button" value="���" onclick="location.href='noticeView.jsp?no=<%= no %>'">
						</div>	
					</form>	
				</div>
			</div>
		</section>
	</div>
</body>
</html>
<script type="text/javascript">
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "ir1", //textarea���� ������ id�� ��ġ�ؾ� �մϴ�. 
          //SmartEditor2Skin.html ������ �����ϴ� ���
          sSkinURI: "SmartEditor2Skin.html",  
          htParams : {
              // ���� ��� ���� (true:���/ false:������� ����)
              bUseToolbar : true,             
              // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
              bUseVerticalResizer : true,     
              // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //���� ����� ������ text ������ �����ͻ� �ѷ��ְ��� �Ҷ� ���
          },
          fCreator: "createSEditor2"
      });
      
      //�����ư Ŭ���� form ����
      $("#nmodify").click(function(){
          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
</script>