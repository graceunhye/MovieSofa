//로그아웃
	function logoutFn(){
		alert("로그아웃 되었습니다.");
		location.href='../../User/loginout/logout.jsp';
	}

	//유저정보 수정
	function user_modify(SeletedId){
		$("#btnModify_"+SeletedId).toggle();
		$("#btnSave_"+SeletedId).toggle();
		
		$.ajax({
			url:"mUserModify.jsp",
			type:"POST",
			data:"id="+SeletedId,
			success: function(data)
			{
					var json = JSON.parse(data);
				
					var NAME_str 		= '<input type="text" id="Name_'+SeletedId+'" value="'+json[0]["name"]+'" style="width:100px; height:25px">' ;
				
					var NUM_str ="";
					
					if(json[0]["num1"] == ''||json[0]["num1"] == '010'){
						NUM_str =	'<select id="NUM1_'+SeletedId+'" name="num1" style="width:50px; height:25px">' ;
						NUM_str +=		'<option value="010" selected>010' ;
						NUM_str +=		'<option value="011" >011' ;
						NUM_str +=		'<option value="016" >016'	;									
						NUM_str +=	'</select>-' ; 
					}else if(json[0]["num1"] == '011'){
						
						NUM_str =	'<select id="NUM1_'+SeletedId+'" name="num1" style="width:50px; height:25px">' ;
						NUM_str +=		'<option value="010">010' ;
						NUM_str +=		'<option value="011" selected>011' ;
						NUM_str +=		'<option value="016">016'	;									
						NUM_str +=	'</select>-'
					}else if(json[0]["num1"] == '016'){
						
						NUM_str =	'<select id="NUM1_'+SeletedId+'" name="num1" style="width:50px; height:25px">';
						NUM_str +=		'<option value="010" >010' ;
						NUM_str +=		'<option value="011" >011';
						NUM_str +=		'<option value="016" selected>016'	;									
						NUM_str +=	'</select>-';
					}
				
						NUM_str    +=  '<input type="text" id="NUM2_'+SeletedId+'" value="'+json[0]["num2"]+'" style="width:50px; height:25px">-' ;
						NUM_str	   +=  '<input type="text" id="NUM3_'+SeletedId+'" value="'+json[0]["num3"]+'" style="width:50px; height:25px">'	;
					
					var EMAIL_str = "";
				
						EMAIL_str +=	'<input type="text" id="E1_'+SeletedId+'" value="'+json[0]["email1"]+'" style="width:200px; height:25px">@' ;
				
					if(json[0]["email1"] == ''||json[0]["email2"] == 'e1'){
						EMAIL_str +=	'<select id="E2_'+SeletedId+'" name="email2" style="width:100px; height:25px">' ;
						EMAIL_str +=		'<option value="e1" selected>naver.com' ;
						EMAIL_str +=		'<option value="e2" >nate.com' ;
						EMAIL_str +=		'<option value="e3">gmail.com' ;
						EMAIL_str +=		'</select>';
					}else if(json[0]["email2"] == 'e2'){
						EMAIL_str +=	'<select id="E2_'+SeletedId+'" name="email2" style="width:100px; height:25px">';
						EMAIL_str +=		'<option value="e1" >naver.com';
						EMAIL_str +=		'<option value="e2" selected>nate.com';
						EMAIL_str +=		'<option value="e3">gmail.com';
						EMAIL_str +=		'</select>'	;
					}else if(json[0]["email2"] == 'e3'){
						EMAIL_str +=	'<select id="E2_'+SeletedId+'" name="email2" style="width:100px; height:25px">';
						EMAIL_str +=		'<option value="e1" >naver.com';
						EMAIL_str +=		'<option value="e2" >nate.com';
						EMAIL_str +=		'<option value="e3"selected>gmail.com';
						EMAIL_str +=		'</select>';			
					}
				
					
					
				$("#userName_"+SeletedId).html(NAME_str);
				$("#userNum_"+SeletedId).html(NUM_str);
				$("#userE_"+SeletedId).html(EMAIL_str);

			
			},
			error:function(xhr, status, error){
				alert("통신실패!");
			}
			
		});	
		
	}
	
	
	//수정된 유저 정보 저장
	function user_modifyOK(SeletedId){
		
		Update_name = $("#Name_"+SeletedId).val();
		Update_num1 = $("#NUM1_"+SeletedId).val();
		Update_num2 = $("#NUM2_"+SeletedId).val();
		Update_num3 = $("#NUM3_"+SeletedId).val();
		Update_e1	= $("#E1_"+SeletedId).val();
		Update_e2	= $("#E2_"+SeletedId).val();
		
		
		
		if(Update_name==""){
			alert("이름은 필수 항목입니다.");
		}else if(Update_num2=="" && Update_num3==""){
			alert("연락처는 필수 항목 입니다.");
		}else if(isNaN(Update_num2)){ //isNaN() true==숫자 아니다. false== 숫자다.
			alert("올바른 형식의 전화번호를 입력해주세요");
		}else if(isNaN(Update_num3)){
			alert("올바른 형식의 전화번호를 입력해주세요");
		}else if(Update_num2=="" || $("#num3").val()==""){
			alert("올바른 형식의 전화번호를 입력해주세요");
		}else{

			$.ajax({
				url:"mUserModifyOK.jsp",
				type:"POST",
				data: {
					id:		SeletedId,
					name :  Update_name,
					num1 :  Update_num1,
					num2 :  Update_num2,
					num3 :  Update_num3,
					email1: Update_e1,
					email2: Update_e2
				},
				success: function(data)
				{
					var json 		= JSON.parse(data);
					
					var NAME_str 	= json[0]["name"];
					
					var NUM_str 	= json[0]["num1"] +"-" + json[0]["num2"] +"-"+ json[0]["num3"];

					var EMAIL_str	= "";
				

					if(json[0]["email1"] ==''){
						
						EMAIL_str = "";
						
					}else if(json[0]["email2"] == 'e1'){
						
						EMAIL_str += json[0]["email1"] +"@";
						EMAIL_str += "naver.com";

					}else if(json[0]["email2"] == 'e2'){	
						
						EMAIL_str += json[0]["email1"] +"@";
						EMAIL_str += "nate.com";
	
					}else if(json[0]["email2"] == 'e3'){
						
						EMAIL_str += json[0]["email1"] +"@";
						EMAIL_str += "gmail.com";
					}
					
					$("#userName_"+SeletedId).html(NAME_str);
					$("#userNum_"+SeletedId).html(NUM_str);
					$("#userE_"+SeletedId).html(EMAIL_str);
				
				},
				error:function(xhr, status, error){
					alert("통신실패!");
				}
				
			});	
			
			$("#btnModify").toggle();
			$("#btnSave").toggle();
			alert("수정했습니다!");

		}
		
		
	}
	
	//선택된 유저 삭제
	function user_Delete(){
		
		if($(".ckd:checked").length < 1){
			alert("회원을 선택해주세요");
			
		}else if($(".ckd:checked").length > 0){
		
			var SelectedIds = "";
			
			$(".ckd:checked").each(function(){
				//가져온 각각의 아이디에 접근하겠다.	
				var selectedId = $(this).val(); //가져온 아이디 (1개)
				SelectedIds+=","+selectedId;
			});
			
			
			$.ajax({
				url:"mUserDeleteOk.jsp",
				type:"POST",
				data: {
					"SelectedIds" : SelectedIds
				},
				success: function(data)
				{
					alert("삭제되었습니다 :D");
					window.location.reload();
				},
				error:function(xhr, status, error){
					alert("통신실패!");
				}
			});	
		}
		
	}
	
	//유저검색
	function user_Search(){		

		var searchText = $("#User_searchT").val();
		var searchType = $("#search_type").val();


			$.ajax({
				url:"mUserSearch.jsp",
				type:"GET",
				data: {


					"searchType" : searchType,
					"searchText" : searchText
				},
				success: function(data)
				{
					var json 		= JSON.parse(data);
					var str			= "";
					var EMAIL_str	= "";
					var BUTTON_str	= "";
					var jsonId		= "";
					
					if(json){
						
						str  = '<tr class="top_tr">';
						str += '<td style="width:5%">선택</td>';
						str += '<td style="width:15%">아이디</td>';
						str += '<td style="width:15%">이름</td>';
						str += '<td style="width:20%">연락처</td>';
						str += '<td style="width:40%">이메일</td>';
						str += '<td style="width:5%">수정</td>';
						str += '</tr>'; 
						
						for(var i = 0; i < json.length; i++){
							
							str += '<tr class="mid_tr">';
							str += "<td><input type='checkbox' style='zoom:1.5;' name='check' class='ckd' value='"+json[i]["id"]+"'></td>";
							str += "<td id='userId_"+json[i]["id"]+"'>"+json[i]["id"]+"</td>";
							str += "<td id='userName_"+json[i]["id"]+"'>"+json[i]["name"]+"</td>";
							str += "<td id='userNum_"+json[i]["id"]+"'>"+json[i]["num"]+"</td>";
							
							var email2 ;
							
							EMAIL_str =""; //초기화
							BUTTON_str =""; //초기화
							email2 =""
							
							email2 += json[i]["email2"];
							
							if(json[i]["email1"] == ""){
							
										EMAIL_str += '<td id="userE_'+json[i]["id"]+'"> </td>';
										str += EMAIL_str ;
								
							}else if(json[i]["email1"] != null){
										
									
									if(json[i]["email2"] == 'e1'){
										
										EMAIL_str += '<td id="userE_'+json[i]["id"]+'">';
										EMAIL_str += json[i]["email1"] +"@";
										EMAIL_str += "naver.com";
										EMAIL_str += "</td>";

		
									}else if(json[i]["email2"] == 'e2'){	
										
										EMAIL_str += '<td id="userE_'+json[i]["id"]+'">';
										EMAIL_str += json[i]["email1"] +"@";
										EMAIL_str += "nate.com";
										EMAIL_str += "</td>";

					
									}else if(json[i]["email2"] == 'e3'){
										
										EMAIL_str += '<td id="userE_'+json[i]["id"]+'">';
										EMAIL_str += json[i]["email1"] +"@";
										EMAIL_str += "gmail.com";
										EMAIL_str += "</td>";

									}	
									
							}	
							
							str += EMAIL_str ;
							
							jsonId = "'"+json[i]["id"]+"'";
							
							BUTTON_str	+= '<td id="userM_'+jsonId+'">';
							BUTTON_str	+= '<button type="button" id="btnModify_'+json[i]["id"]+'" name="btnModify" onclick="user_modify('+jsonId+')">수정</button>';
							BUTTON_str	+= '<button type="button" id="btnSave_'+json[i]["id"]+'" name="btnSave" style="display:none" onclick="user_modifyOK('+jsonId+')">저장</button>';
							BUTTON_str	+= '</td>';	
							
							
							str += BUTTON_str;	
							
						}

								str += "</tr>";
							
						}
						
						$(".content_table").html(str);
						alert("검색되었습니다 :D");
					
				},
				error:function(xhr, status, error){
					alert("통신실패!");
				}
			});	
			

	}
	