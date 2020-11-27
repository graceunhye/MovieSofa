function c_updateFn(no,rv_no) {
			var text = $("#comment_"+no).text();
			str = "";
			str += "<div id='cbtns_"+no+"' style='display:inline'>"
			str += "	<button class='comment_btns' onclick='c_saveFn("+no+","+rv_no+")'>저장</button>";
			str += "	<button class='comment_btns' onclick='c_deleteFn("+no+","+rv_no+")'>삭제</button>";
			str += "</div>"
			
			str2 = "";
			str2 += "<textarea cols='120' rows='5' placeholder='"+text+"' id='ic_body"+no+"' name='ic_body' style='border:none;scroll:none;resize:none;'></textarea>";
			
			$("#cbtns_"+no).html(str);
			$("#comment_"+no).html(str2);
		}
		
		
function c_saveFn(no,rv_no) {
	var text = $("#ic_body"+no).val();
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
			
	});
}
		
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