
	function PostOpen(){
		new daum.Postcode({
		    oncomplete: function(data) {
		        //data는 사용자가 선택한 주소 정보를 담고 있는 객체
		    	$("#postnum").val(data.zonecode);
				$("#addr1").val(data.address);
		    }
		}).open();
	}
	
	function Submit(){

		if($("#name").val()==""){
			alert("이름은 필수 항목입니다.");
		}else if($("#email1").val()==""){
			alert("이메일은 필수 항목입니다.");
		}else if($("#num2").val()=="" && $("#num3").val()==""){
			alert("연락처는 필수 항목 입니다.");
		}else if($("#num2").val()==""){
			alert("올바른 형식의 전화번호를 입력해주세요");		
		}else if($("#num3").val()==""){
			alert("올바른 형식의 전화번호를 입력해주세요");
		}else{
			document.modifyfrm.submit();
		}
 
	}
	
	function userDelete(rentcount,id){
			var Rentcount  = rentcount;
			
			if(Rentcount >0){
				
				alert("대여중인 도서가 있습니다. 책을 반납해주세요.");
				return false;
				
			}
		
		
			 var seletedId = id; 
			 var text = 	'탈퇴하시겠습니까?';
			 var result = confirm(text);
				if(result){ 
					userDeleteOk(seletedId); 
					//confirm 에서 확인을 누르면ture를  반환합니다.
				} 
		
	}
	
	function userDeleteOk(id){
			
		
		var seletedId = id;
		
		$.ajax({
			url:"userDeleteOk.jsp",
			type:"POST",
			data: {
				"SelectedIds" : seletedId
			},
			success: function(data)
			{
				window.location.href = "userDeleted.jsp";
			},
			error:function(xhr, status, error){
				alert("통신실패!");
			}
		});	
				
		
	}
	