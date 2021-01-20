
function rentFn(isbn, rent_cnt){
	if($("#session_id").val() != null) {
		if(rent_cnt < 10) {
			if(confirm("대출 하시겠습니까?")){	
				$.ajax({
					url  : "bookViewRent.jsp?isbn="+isbn+"",
					type : "post",
					data : "",
					success : function(data){
						
						var json = JSON.parse(data);
						var str1 = "대출불가 (대출중)";
						var str2 = json[0]["endd"];
						var str3 = "";
	
						$("#rent1").html(str1);
						$("#rent2").html(str2);
						$(".rentbtn").attr("disabled", true);
						$(".rentbtn").val("대출완료");
						alert("대출이 완료 되었습니다.");
					}	
				});
			}
		} else {
			alert("10권 이상 대여할 수 없습니다.");
		}	
	} else { 
		alert("로그인 후 이용 가능한 서비스 입니다.");
	}	
}
