 function needLoginFn(id) {
	 if(id==null || id==""){

		if(confirm("로그인이 필요한 서비스입니다. 로그인창으로 이동하시겠습니까?") == true){
			location.href="../loginout/login.jsp";
		}else{
			return;
		}			
	 }else {
		 location.href="../myPage/userInfo.jsp";
	 }
	 
 } 

 
 function qnaInsertCancelFn() {
	 if(confirm("정말 취소하시겠습니까?") == true){
			location.href="qna.jsp";
		}else{
			return;
		}			 
 }
 
function qnaDeleteFn(no) {
	
	 if(confirm("정말 삭제 하시겠습니까?")) {
		 
		 //확인 버튼 클릭 시 동작
		 location.href="qnaDeleteOk.jsp?no="+no;
		 
	 } else {
		 
		 //취소 버튼 클릭 시 동작
		 alert("취소하였습니다.");
	 }
}

function qnaNeedLogin(id) {
	if(id == null || id == "")
	{
		if(confirm("로그인이 필요한 서비스입니다. 로그인창으로 이동하시겠습니까??") == true)
		{
			//확인
			location.href="../loginout/login.jsp";
		}else
		{
			//취소
		}			
	}else
	{
		location.href="qnaInsert.jsp";
	}	
}

function wishCancelFn(){
	if(confirm("취소하시겠습니까?")){
		// 확인 버튼 클릭 시 동작
		location.href='wish.jsp';
	}else {
		//취소 버튼 클릭 시 동작
	}
}


function wishNeedLoginFn(value){
	if(value == "0" ){

		location.href="wishApply.jsp";
				
	}else if(value == "1" )
	{
		location.href="wishCheck.jsp";		
	}
}

