function ID_check(){				
			var id = document.joinfrm.id.value;
		
			$.ajax({
				url:"joinCheck.jsp?id=" + id,
				type:"post",
				success: function(data)
				{
					if(data.trim() == "result1"){
						$("#id_message").html("<br>아이디를 입력해주세요.");
						document.joinfrm.id.value = "";
					}else if(data.trim() == "result4"){
						$("#id_message").html("<br>아이디는 5~20자의 영어와 숫자만 사용하실 수 있습니다.");
					}else if(data.trim() == "result2"){
						$("#id_message").html("<br>이미 사용중인 아이디 입니다.");
					}else{
						$("#id_message").html("<br>멋진 아이디네요 *^▽^*");
					}
				}
			});	
		}
	
		/* Password_check */
		function Password_check(){
			 var pw 	= $("#pw1").val().trim();
			 
			  
			 var pattern1 = /[0-9]/;
	
	         var pattern2 = /[a-zA-Z]/;
	
	         var pattern3 = /[~!@\#$%<>^&*]/; 
			 
			 
			if(!pw){
				 
				 $("#pw1").val("");	//비밀번호 초기값으로 초기화
				 $("#password_message").html("<br>비밀번호를 입력해주세요.");
				 return false;
			 
			 }else if(pw.length < 8 || pw.length > 20){
				 $("#password_message").html("<br>비밀번호는 8자리 이상 20자리 이하입니다.");
				 $("#pw1").val("");
				 $("#pw1").focus();
				 return false;
			 
			 }else if(pw.search(/\s/) != -1){
				  alert("비밀번호는 공백 없이 입력해주세요.");
				  return false;
				  
			}else if(!pattern1.test(pw)||!pattern2.test(pw)||!pattern3.test(pw)){
				 
				 $("#password_message").html("<br>비밀번호는 영어, 숫자, 특수문자 1개씩은 포함하여야 합니다.");
				 $("#pw1").val("");
				 $("#pw1").focus();
				 return false;
				 
			 }else{
				 
				 $("#password_message").html(" ");
				 return true;
			 }
		}
		
		/* Password_check2 */	 
		function Password_check2(){
			 var pw 	= $("#pw1").val().trim();
			 var pw2 	= $("#pw2").val().trim();
			 
			 if(!(pw==pw2)){
				 
				 $("#pw2").val("");	//비밀번호 초기값으로 초기화
				 $("#password_message2").html("<br>비밀번호가 일치하지 않습니다.");
				 return false;
				 
			}else{
				
				 $("#password_message2").html(" ");
				 return true;
			}
		}
		
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
			
			var numCheck1 = $('#num2').val();
			var numCheck2 = $('#num3').val();
			var postCheck = $('#postnum').val();
			var emailCheck = $("#email1").val();
			
			if($("#id").val()==""){
				alert("아이디는 필수 항목입니다.");
			}else if($("#pw1").val()==""){
				alert("비밀번호는 필수 항목입니다.");
			}else if($("#pw2").val()==""){
				alert("비밀번호 확인은 필수 항목입니다.");
			}else if($("#name").val()==""){
				alert("이름은 필수 항목입니다.");
			}else if($("#email1").val()==""){
				alert("이메일은 필수 항목입니다.");
			}else if(emailCheck.trim()==""){
				alert("공백 넣지마세요ㅋㅋ 필수 항목입니다.");
			}else if($("#num2").val()=="" && $("#num3").val()==""){
				alert("연락처는 필수 항목 입니다.");
			}else if(isNaN(numCheck1)){ //isNaN() true==숫자 아니다. false== 숫자다.
				alert("올바른 형식의 전화번호를 입력해주세요");
			}else if(isNaN(numCheck2)){
				alert("올바른 형식의 전화번호를 입력해주세요");
			}else if($("#num2").val()=="" || $("#num3").val()==""){
				alert("올바른 형식의 전화번호를 입력해주세요");
			}else if(postCheck!=""&&isNaN(postCheck)){
				alert("우편번호는 숫자만 올 수 있습니다.");
			}else{
				document.joinfrm.submit();
			}
	
		}