function returnFn(node, id, isbn){
			if(confirm("�ݳ��Ͻðڽ��ϱ�?")){
				$.ajax({
					url  : "bookReturn.jsp",
					type : "post",
					data : "isbn="+isbn+"&id="+id,
					success : function(data){
						$(node).parent().parent().remove();
					}	
				});			
			}
		}
		
		function extensionFn(node, isbn){
			if(confirm("�����Ͻðڽ��ϱ�?")){
				$.ajax({
					url : "bookExtension.jsp",
					type : "post",
					data : "isbn="+isbn,
					success : function(data){
						var json = JSON.parse(data);
						var str1 = json[0]["endd"];
						var str2 = "<input type='button' class='normalBtn' value='����Ұ�' disabled>";
						
						$(node).parent().find(".endd_td").html();
						$(node).parent().html(str2);
					}
				});
			}
		} 