//�α׾ƿ�
	function logoutFn(){
		alert("�α׾ƿ� �Ǿ����ϴ�.");
		location.href='../../User/loginout/logout.jsp';
	}

	//�������� ����
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
				alert("��Ž���!");
			}
			
		});	
		
	}
	
	
	//������ ���� ���� ����
	function user_modifyOK(SeletedId){
		
		Update_name = $("#Name_"+SeletedId).val();
		Update_num1 = $("#NUM1_"+SeletedId).val();
		Update_num2 = $("#NUM2_"+SeletedId).val();
		Update_num3 = $("#NUM3_"+SeletedId).val();
		Update_e1	= $("#E1_"+SeletedId).val();
		Update_e2	= $("#E2_"+SeletedId).val();
		
		
		
		if(Update_name==""){
			alert("�̸��� �ʼ� �׸��Դϴ�.");
		}else if(Update_num2=="" && Update_num3==""){
			alert("����ó�� �ʼ� �׸� �Դϴ�.");
		}else if(isNaN(Update_num2)){ //isNaN() true==���� �ƴϴ�. false== ���ڴ�.
			alert("�ùٸ� ������ ��ȭ��ȣ�� �Է����ּ���");
		}else if(isNaN(Update_num3)){
			alert("�ùٸ� ������ ��ȭ��ȣ�� �Է����ּ���");
		}else if(Update_num2=="" || $("#num3").val()==""){
			alert("�ùٸ� ������ ��ȭ��ȣ�� �Է����ּ���");
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
					alert("��Ž���!");
				}
				
			});	
			
			$("#btnModify").toggle();
			$("#btnSave").toggle();
			alert("�����߽��ϴ�!");

		}
		
		
	}
	
	//���õ� ���� ����
	function user_Delete(){
		
		if($(".ckd:checked").length < 1){
			alert("ȸ���� �������ּ���");
			
		}else if($(".ckd:checked").length > 0){
		
			var SelectedIds = "";
			
			$(".ckd:checked").each(function(){
				//������ ������ ���̵� �����ϰڴ�.	
				var selectedId = $(this).val(); //������ ���̵� (1��)
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
					alert("�����Ǿ����ϴ� :D");
					window.location.reload();
				},
				error:function(xhr, status, error){
					alert("��Ž���!");
				}
			});	
		}
		
	}
	
	//�����˻�
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
						str += '<td style="width:5%">����</td>';
						str += '<td style="width:15%">���̵�</td>';
						str += '<td style="width:15%">�̸�</td>';
						str += '<td style="width:20%">����ó</td>';
						str += '<td style="width:40%">�̸���</td>';
						str += '<td style="width:5%">����</td>';
						str += '</tr>'; 
						
						for(var i = 0; i < json.length; i++){
							
							str += '<tr class="mid_tr">';
							str += "<td><input type='checkbox' style='zoom:1.5;' name='check' class='ckd' value='"+json[i]["id"]+"'></td>";
							str += "<td id='userId_"+json[i]["id"]+"'>"+json[i]["id"]+"</td>";
							str += "<td id='userName_"+json[i]["id"]+"'>"+json[i]["name"]+"</td>";
							str += "<td id='userNum_"+json[i]["id"]+"'>"+json[i]["num"]+"</td>";
							
							var email2 ;
							
							EMAIL_str =""; //�ʱ�ȭ
							BUTTON_str =""; //�ʱ�ȭ
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
							BUTTON_str	+= '<button type="button" id="btnModify_'+json[i]["id"]+'" name="btnModify" onclick="user_modify('+jsonId+')">����</button>';
							BUTTON_str	+= '<button type="button" id="btnSave_'+json[i]["id"]+'" name="btnSave" style="display:none" onclick="user_modifyOK('+jsonId+')">����</button>';
							BUTTON_str	+= '</td>';	
							
							
							str += BUTTON_str;	
							
						}

								str += "</tr>";
							
						}
						
						$(".content_table").html(str);
						alert("�˻��Ǿ����ϴ� :D");
					
				},
				error:function(xhr, status, error){
					alert("��Ž���!");
				}
			});	
			

	}
	