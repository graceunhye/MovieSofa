
	function PostOpen(){
		new daum.Postcode({
		    oncomplete: function(data) {
		        //data�� ����ڰ� ������ �ּ� ������ ��� �ִ� ��ü
		    	$("#postnum").val(data.zonecode);
				$("#addr1").val(data.address);
		    }
		}).open();
	}
	
	function Submit(){

		if($("#name").val()==""){
			alert("�̸��� �ʼ� �׸��Դϴ�.");
		}else if($("#email1").val()==""){
			alert("�̸����� �ʼ� �׸��Դϴ�.");
		}else if($("#num2").val()=="" && $("#num3").val()==""){
			alert("����ó�� �ʼ� �׸� �Դϴ�.");
		}else if($("#num2").val()==""){
			alert("�ùٸ� ������ ��ȭ��ȣ�� �Է����ּ���");		
		}else if($("#num3").val()==""){
			alert("�ùٸ� ������ ��ȭ��ȣ�� �Է����ּ���");
		}else{
			document.modifyfrm.submit();
		}
 
	}
	
	function userDelete(rentcount,id){
			var Rentcount  = rentcount;
			
			if(Rentcount >0){
				
				alert("�뿩���� ������ �ֽ��ϴ�. å�� �ݳ����ּ���.");
				return false;
				
			}
		
		
			 var seletedId = id; 
			 var text = 	'Ż���Ͻðڽ��ϱ�?';
			 var result = confirm(text);
				if(result){ 
					userDeleteOk(seletedId); 
					//confirm ���� Ȯ���� ������ture��  ��ȯ�մϴ�.
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
				alert("��Ž���!");
			}
		});	
				
		
	}
	