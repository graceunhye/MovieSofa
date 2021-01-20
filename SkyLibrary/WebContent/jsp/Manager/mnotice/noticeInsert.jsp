<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>공지사항 작성</title>
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
				str += "<button type='button' id='del'>삭제</button>";
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

	function logoutFn(){
		alert("로그아웃 되었습니다.");
		location.href='../../User/loginout/logout.jsp';
	}
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
				<div class="title_box"><span class="head_title">관리자 페이지 </span><span class="name">하늘도서관</span></div>
			</div>
		</header>
		<section>
			<jsp:include page="../include/nav.jsp" />
			<div class="section">
				<div class="user_info">
					<span class="info_title"><span class="point">*</span>공지사항 등록</span>
					<br>
					<br>
					<form name="frm" id="frm" method="post" action="noticeInsertOk.jsp" enctype="multipart/form-data">
						<table width="1300">
							<tr>
								<td>제목</td>
								<td><input type="text" size="128" id="title" name="title"></td>
							</tr>	
							<tr>
								<td>내용</td>
								<td><textarea name="ir1" id="ir1" rows="30" cols="130"></textarea></td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td>
									<div id="pic">
									</div> 									
									<input type="file" id="fname" name="fname">
								</td>
							</tr>	
						</table>
						<br>
						<br>
						<div class="insert_btn">
							<input type="submit" value="등록" id="ninsert">
							<input type="button" value="취소" onclick="location.href='notice.jsp'">
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
          elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#ninsert").click(function(){
          oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#frm").submit();
      });    
});
</script>
