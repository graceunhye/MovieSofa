function returnFn(node, id, isbn){
			if(confirm("반납하시겠습니까?")){
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
			if(confirm("연장하시겠습니까?")){
				$.ajax({
					url : "bookExtension.jsp",
					type : "post",
					data : "isbn="+isbn,
					success : function(data){
						var json = JSON.parse(data);
						var str1 = json[0]["endd"];
						var str2 = "<input type='button' class='normalBtn' value='연장불가' disabled>";
						
						$(node).parent().find(".endd_td").html();
						$(node).parent().html(str2);
					}
				});
			}
		} 