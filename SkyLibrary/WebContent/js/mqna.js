function searchFn() {
		var selectType    = document.getElementById("selectType").value;
		var startDate     = document.getElementById("startDate").value;
		var endDate       = document.getElementById("endDate").value;
		$.ajax({
			url: "qnaSearchOk.jsp",
			type: "post",
			data: {
				select : selectType,
				startDate : startDate,
				endDate : endDate
			},
			error: function(){
				var str = "<h2><font color='orange'>오류</font></h2>";
				$("#result").html(str);
			}
			,
			success: function(data) {
				var str = "";
				getData = JSON.parse(data);

				for(var i=0; i<getData.length; i++){
					
					str += "<tr id='tr_"+getData[i].no+"' onclick='viewFn("+getData[i].no+")'>";
					str += "	<td align='center' width='50'>"+getData[i].no+"</td>";
					str += "	<td width='600' style='padding-left: 8px;'><a href='javascript:viewFn("+getData[i].no+")'>"+getData[i].title+"</a></td>";
					str += "	<td align='center' width='150'>"+getData[i].id+"</td>";
					str += "	<td align='center' width='200'>"+getData[i].wdate+"</td>";
					str += "	<td align='center' width='200' id='okdate_"+getData[i].no+"'>"+getData[i].okdate+"</td>";
					str += "	<td align='center' width='200' id='atype_"+getData[i].no+"'>"+getData[i].atype+"</td>";
					str += "</tr>";
				}
					$("#result").html(str); 
			}
		})
	}
	
	function viewFn(no) {
		$.ajax({
			url: "qnaDetailOk.jsp",
			type: "post",
			data: {
				no : no,
			},
			error:function(){
				var str = "오류가 발생했습니다.";
			},
			success: function(data) {
				var qnaInfo = JSON.parse(data);
				var str = "";
				var type = "";
				
				str += "<table border='1' width='1300' class='viewTable'>";
				str += "	<thead><tr class='viewFixTable' height='40'><th colspan='8'>질문상세정보</th></tr></thead>";
				str += "	<tbody>";
				str += "	<tr height='40px;'>";
				str += "		<th style='background-color:#a8a8a8;'>질문번호</th>";
				str += "		<td align='center'>"+qnaInfo[0].no+"</td>";
				str += "		<th  style='background-color:#a8a8a8;'>질문자</th>";
				str += "		<td align='center'>"+qnaInfo[0].id+"</td>";
				str += "		<th  style='background-color:#a8a8a8;'>질문일</th>";
				str += "		<td align='center'>"+qnaInfo[0].wdate+"</td>";
				str += "		<th  style='background-color:#a8a8a8;'>답변일</th>";
				str += "		<td align='center' id='okdate'>"+qnaInfo[0].okdate+"</td>";
				str += "	</tr>";
				str += "	<tr height='40px;'>";
				str += "		<th style='background-color:#a8a8a8;'>질문제목</th>";
				str += "		<td colspan='5' align='center'>"+qnaInfo[0].title+"</td>";
				str += "		<th style='background-color:#a8a8a8;'>질문상태</th>";
				if(qnaInfo[0].atype == "0") { 
					str += "		<td align='center' id='atype'><font color='blue'>답변대기</font></td>";
				}else{
					str += "		<td align='center' id='atype'><font color='orange'>답변완료</font></td>";
				}
				str += "	</tr>";
				str += "	<tr height='40px;'>";
				str += "		<th colspan='8'>질문내용</th>";
				str += "	</tr>";
				str += "	<tr>";
				str += "		<td colspan='8' align='left' style='padding:15px'>"+qnaInfo[0].body+"</td>";
				str += "	</tr>";
				str += "	<tr><th colspan='8' height='40px;'>답변상세정보</th></tr>";
				if(qnaInfo[0].atype == "0") { 
					str += "	<tr height='40px;'>";
					str += "		<th width='150'>답변제목</th>";
					str += "		<td colspan='7' id='a_title'><input type='text' size='50' id='title' class='input_text' placeholder='답변 제목을 입력해주세요.'></td>";	
					str += "	</tr>";
					str += "	<tr height='40px;'>";
					str += "		<th colspan='8' height='40px;'>답변내용</th>";
					str += "	</tr>";
					str += "	<tr><td colspan='8' id='a_body'><textarea id='body' placeholder='답변 내용을 입력해주세요.'  cols='190' rows='5' style='resize: none;'></textarea></td></tr>";
				}else{
					str += "	<tr height='40px;'>";
					str += "		<th style='background-color:#a8a8a8;'>답변제목</th>";
					str += "		<td colspan='5' style='padding:15px' class='text' id='a_title'>"+qnaInfo[0].mtitle+"</td>";
					str += "		<th style='background-color:#a8a8a8;'>작성자</th>";
					str += "		<td>"+qnaInfo[0].mid+"</td>";
					str += "	</tr>";
					str += "	<tr height='40px;'>";
					str += "		<th colspan='8' height='40px;'>답변내용</th>";
					str += "	</tr>";
					str += "	<tr><td style='padding:15px' class='text' id='a_body' colspan='8'>"+qnaInfo[0].mbody+"</td></tr>";
				}
				str += "	</tr>";
				if(qnaInfo[0].atype == "0") { 
					str += "<tr>";
					str += "	<td colspan='8' align='right' class='input_box' id='a_btn'>";
					str += "		<input type='button' value='등록' class='a_button' onclick='aInsertFn("+qnaInfo[0].no+")'>";
					str += "	</td>";
					str += "</tr>";
				}else{
					str += "<tr>";
					str += "	<td colspan='8' align='right' class='input_box' id='a_btn'>";
					str += "		<input type='button' value='수정' class='a_button' onclick='aModifyFn("+qnaInfo[0].no+")'>";
					str += "	</td>";
					str += "</tr>";
				}
				str += "	</tbody>";
				str += "</table>";
				
				$("#userInfoView").html(str);
			}
		})
	}
	
	function aInsertFn(no) {
		var title = document.getElementById("title").value;
		var body  = document.getElementById("body").value;
	
		$.ajax({
			url: "aInsertOk.jsp",
			type: "post",
			data: {
				title: title,
				body : body,
				no : no
			},
			error: function(){
				alert("ajax 오류가 발생하였습니다.");
			},
			success: function(data){
				var data = JSON.parse(data);
				document.getElementById("okdate").innerText      = data[0].mwdate;
				document.getElementById("okdate_"+no).innerText  = data[0].mwdate;
				document.getElementById("atype").innerHTML       = "<font color='orange'>답변완료</font>";
				document.getElementById("atype_"+no).innerHTML   = "<font color='orange'>답변완료</font>";
				document.getElementById("a_title").innerHTML     = data[0].mtitle;
				document.getElementById("a_body").innerHTML      = data[0].mbody;
				document.getElementById("a_btn").innerHTML       = "<input type='button' value='수정' class='a_button' onclick='aModifyFn("+no+")'>";
				alert("등록이 완료되었습니다.");
			}
		})
		
	}
	
	function aModifyFn(no) {
		var title = document.getElementById("a_title").innerText;
		var body  = document.getElementById("a_body").innerText;
		

		document.getElementById("a_title").innerHTML     = "<input type='text' id='title' class='input_text' size='50' value='"+title+"'>";
		document.getElementById("a_body").innerHTML      = "<textarea id='body' cols='190' rows='5' style='resize: none;'>"+body+"</textarea>"; 
		document.getElementById("a_btn").innerHTML       = "<input type='button' value='등록' class='a_button' onclick='aUpdateFn("+no+")'>";
	}
	
	function aUpdateFn(no) {
		var title = document.getElementById("title").value;
		var body  = document.getElementById("body").value;

		
		$.ajax({
			url: "aUpdateOk.jsp",
			type: "post",
			data: {
				no: no,
				title: title,
				body : body
			},
			error: function(){
				alert("DB 오류가 발생하였습니다. 다시 시도해주세요.");
			},
			success: function(data){
				var data = JSON.parse(data);
				document.getElementById("a_title").innerHTML = data[0].title;
				document.getElementById("a_body").innerHTML  = data[0].body;
				document.getElementById("a_btn").innerHTML   = "<input type='button' value='수정' class='a_button' onclick='aModifyFn("+no+")'>";
				
				alert("수정이 완료되었습니다.");
				
			}
		})
	}