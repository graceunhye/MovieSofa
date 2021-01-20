var getData  ="";
	
	function checkedSaveFn() {

		var TypeSaveSelect = document.getElementById("TypeSaveSelect").value;
		var noValue = [];
		var noCheckedValue = [];

		for(var i=0; i<getData.length ; i++) {
			noValue[i] = getData[i].no;
			if($("#checked_"+noValue[i]).prop("checked")){
				noCheckedValue = noValue[i]
				$.ajax({
					url: "wishCheckedSave.jsp",
					type: "post",
					data: {
						checkNo : noCheckedValue ,
						selectChange : TypeSaveSelect
						},
					success: function(data){
						searchFn();
					}
					
				}) 
			}
		}		
	}
	
	function searchFn() {
		var selectType  = document.getElementById("selectType").value;
		var startDate   = document.getElementById("startDate").value;
		var endDate     = document.getElementById("endDate").value;
		$.ajax({
			url: "wishSearch.jsp",
			type: "post",
			data: {
				select : selectType,
				startDate : startDate,
				endDate : endDate
			},
			error: function(){
				var str = "<h2><font color='orange'>신청중</font></h2>";
				$("#result").html(str);
			}
			,
			success: function(data) {
				var str = "";
				getData = JSON.parse(data);

				for(var i=0; i<getData.length; i++){
					if(getData[i].okdate == null){ getData[i].okdate = ""; }
					str += "<tr id='tr_"+getData[i].no+"' onclick='viewFn("+getData[i].no+")'>";
					str += "<td  width='50px' align='center'>"+getData[i].no+"</td>";
					str += "<td width='150px' align='center'>"+getData[i].id+"</td>";
					str += "<td width='250px' align='center'>"+getData[i].isbn+"</td>";
					str += "<td width='700px'><a href='javascript:viewFn("+getData[i].no+")'>"+getData[i].subject+"</a></td>";
					str += "<td width='200px' align='center'>"+getData[i].wdate+"</td>";
					str += "<td width='200px' align='center'>"+getData[i].okdate+"</td>";
					if(getData[i].atype == "0"){
						str += "<td width='100px' align='center'><font color='blue'>신청중</font></td>";
					}else if(getData[i].atype == "1") {
						str += "<td width='100px' align='center'><font color='orange'>처리중</font></td>";
					}else if(getData[i].atype == "2") {
						str += "<td width='100px' align='center'><font color='gray'>취소됨</font></td>";
					}else if(getData[i].atype == "3") {
						str += "<td width='100px' align='center'>소장중</td>";
					}
					str += "<td width='50px' align='center'><input type='checkbox' name='check' id='checked_"+getData[i].no+"' value='1'></td>";
					str += "</tr>";
				}
				$("#result").html(str);
			}
		})
	}
	
	

	$(function(){
		$("#checkAll").click(function(){ 
			if($("#checkAll").prop("checked")) {  
				$("input[type='checkbox']").prop("checked",true); 

			}else {
				$("input[type='checkbox']").prop("checked",false);
			}
		})
	})

	

	function viewFn(no) {
		$.ajax({
			url: "wishDetailOk.jsp",
			type: "post",
			data: {
				no : no,
			},
			error:function(){
				var str = "오류가 발생했습니다.";
			},
			success: function(data) {
				var applyInfo = JSON.parse(data);
				var str = "";
				var type = "";
				if(applyInfo[0].atype == "1"){ type="<font color='orange'>처리중</font>";}
				else if(applyInfo[0].atype == "2"){ type="<font color='gray'>취소됨</font>";}
				else if(applyInfo[0].atype == "3"){ type="소장중";}
				else if(applyInfo[0].atype == "0"){ type="<font color='blue'>신청중</font>";}
				
				str += "<table border='1' width='1300' height='300' class='viewTable'>";
				str += "	<tr height='30'>";
				str += "		<th width='100'>번호</th>";
				str += "		<td width='100'>"+ applyInfo[0].no +"</td>";
				str += "		<th width='100'>ISBN</th>";
				str += "		<td width='150' ><span id='isbnValue'>"+ applyInfo[0].isbn +"</span><a href='javascript:copyToClipboard("+ applyInfo[0].isbn +")'>복사</a></td>";
				str += "		<th width='100'>제목</th>";
				str += "		<td colspan='5'>"+ applyInfo[0].subject +"</td>";
				str += "	</tr>";
				str += "	<tr height='30'>";
				str += "		<th width='100'>작가명</th>";
				str += "		<td>"+ applyInfo[0].writer +"</td>";
				str += "		<th width='100'>출판사</th>";
				str += "		<td>"+ applyInfo[0].company +"</td>";
				str += "		<th width='100'>출판일</th>";
				str += "		<td>"+ applyInfo[0].pdate +"</td>";
				str += "		<th width='100'>처리상태</th>";
				str += "		<td>"+ type +"</td>";
			    str += "	</tr>";
				str += "	<tr>";
				str += "		<td colspan='8'>"+ applyInfo[0].why +"</td>";
				str += "	</tr>";
				str += "</table>";
				
				$("#userInfoView").html(str);
			}
		})
	}
	
	
	function copyToClipboard(val) {
			
		  var t = document.createElement("textarea");
		  document.body.appendChild(t);
		  t.value = val;
		  t.select();
		  document.execCommand('copy');
		  document.body.removeChild(t);
		  alert("복사완료!");
	}
	
				