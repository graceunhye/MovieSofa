
function rentFn(isbn, rent_cnt){
	if($("#session_id").val() != null) {
		if(rent_cnt < 10) {
			if(confirm("���� �Ͻðڽ��ϱ�?")){	
				$.ajax({
					url  : "bookViewRent.jsp?isbn="+isbn+"",
					type : "post",
					data : "",
					success : function(data){
						
						var json = JSON.parse(data);
						var str1 = "����Ұ� (������)";
						var str2 = json[0]["endd"];
						var str3 = "";
	
						$("#rent1").html(str1);
						$("#rent2").html(str2);
						$(".rentbtn").attr("disabled", true);
						$(".rentbtn").val("����Ϸ�");
						alert("������ �Ϸ� �Ǿ����ϴ�.");
					}	
				});
			}
		} else {
			alert("10�� �̻� �뿩�� �� �����ϴ�.");
		}	
	} else { 
		alert("�α��� �� �̿� ������ ���� �Դϴ�.");
	}	
}
