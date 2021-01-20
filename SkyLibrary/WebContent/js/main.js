		function loadFn(){
			
			$.ajax({
				url: "mainOk.jsp",
				type: "post",
				data: {
					forWhat: "notice"
				},
				success: function(data){
					
					var result = JSON.parse(data.trim());
					var str = "";
					for(var i=0; i<result.length; i++){
						str += "<tr height='25px'>";
						str += "	<td align='center'>"+ result[i].no +"</td>";
						str += "	<td class='table_move'><a href='./User/intro/notice.jsp?no="+ result[i].no +"'><span class='point'></span>"+ result[i].title +"</a></td>";
						str += "	<td>"+ result[i].ndate +"</td>";
						str += "</tr>";
					}	
					$("#notice").html(str);
				}
			});
			
			$.ajax({
				url: "mainOk.jsp",
				type: "post",
				data: {
					forWhat: "book"
				},
				success: function(data){
					var result = JSON.parse(data.trim());
					var str = "";	
					
					for(var i=0; i<result.length; i++){
						str += "<li>";
						str += "	<div class='book_cover'><img src='"+ result[i].coverimg +"' class='books' alt='"+ result[i].subject +"' /></div>";
						str += "	<div class='book_title'><a href='./User/search/newView.jsp?isbn="+ result[i].isbn +"' class='bookSubject'>"+ result[i].subject +"</a></div>";
						str += "</li>";				
					}	
					$("#book").html(str);
				}
			})
		}