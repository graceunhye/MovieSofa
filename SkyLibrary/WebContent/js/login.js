
 	//회원 로그인
 	function login(){
 		
 		if($("input:text").val() == ""){
			alert("아이디를 입력하세요.");
			$("input:text").focus();
			return false;
		}else if($("input:password").val() == ""){
			alert("비밀번호를 입력하세요.");
			$("input:password").focus();
			return false;
		}else{
			document.login_frm.submit();
		}
 		
 	}
 	
 	//사서 로그인
 	function login2(){
 		
 		if($("input:text").val() == ""){
			alert("아이디를 입력하세요.");
			$("input:text").focus();
			return false;
		}else if($("input:password").val() == ""){
			alert("비밀번호를 입력하세요.");
			$("input:password").focus();
			return false;
		}else{
			document.login_frm2.submit();
		}
 		
 	}
 
 	
 	//사서 로그인 화면으로 전환
	var m_LoginStr ='<h2 class="login_title">사서 로그인</h2>                                                                                         '
		+'<div class="login_input_box">                                                                                                               '
		+'	<form action="../../Manager/mloginout/loginProc.jsp" method="post" name="login_frm2">                                                      '
		+'		<table>                                                                                                                               '
		+'			<tr height="50" class="login_txt">                                                                                                '
		+'				<td width="100" align="right" class="login_input"><span class="point id">*</span><span class="id_title">아이디</span>:</td>     '
		+'				<td width="300"><input type="text" class="input" name="id" size="38" placeholder=" 아이디를 입력해주세요."></td>                    '
		+'			</tr>                                                                                                                             '
		+'			<tr height="50" class="login_txt">                                                                                                '
		+'				<td align="right" class="login_input"><span class="point">*</span>비밀번호:</td>                                                '
		+'				<td><input type="password" name="pw"  class="input" size="38" placeholder=" 비밀번호를 입력해주세요."></td>                         '
		+'			</tr>                                                                                                                             '
		+'			<tr class="login_option">                                                                                                         '
		+'				<td colspan="2" align="center">                                                                                               '
		+'					<a href="#">아이디/비밀번호찾기</a>                                                                                       	  '
		+'					<font color="#2C78D7">&nbsp;|&nbsp;</font>                                                                                '
		+'					<a href="../join/join.jsp">회원가입</a>                                                                                      '
		+'					<font color="#2C78D7">&nbsp;|&nbsp;</font>                                                                                '
		+'					<a href="javascript:u_login()">회원 로그인</a>                                                                               '
		+'				</td>                                                                                                                         '
		+'			</tr>                                                                                                                             '
		+'			<tr height="70">                                                                                                                  '
		+'				<td colspan="2" align="center">                                                                                               '
		+'					<button type="button" class="login_btn" onclick="login2()" >로그인</button>                                                '
		+'				</td>                                                                                                                         '
		+'			</tr>                                                                                                                             '
		+'		</table>                                                                                                                              '
		+'	</form>                                                                                                                                   '
		+'</div>                                                                                                                                      '
		
		function m_login(){
			$(".login_box").html(m_LoginStr);
		}
		
		
		//회원 로그인 화면으로 전환
		var u_LoginStr ='<h2 class="login_title">로그인</h2>                                                                                         '
			+'<div class="login_input_box">                                                                                                               '
			+'	<form action="loginProc.jsp" method="post" name="login_frm">                                                      '
			+'		<table>                                                                                                                               '
			+'			<tr height="50" class="login_txt">                                                                                                '
			+'				<td width="100" align="right" class="login_input"><span class="point id">*</span><span class="id_title">아이디</span>:</td>     '
			+'				<td width="300"><input type="text" class="input" name="id" size="38" placeholder=" 아이디를 입력해주세요."></td>                    '
			+'			</tr>                                                                                                                             '
			+'			<tr height="50" class="login_txt">                                                                                                '
			+'				<td align="right" class="login_input"><span class="point">*</span>비밀번호:</td>                                                '
			+'				<td><input type="password" name="pw"  class="input" size="38" placeholder=" 비밀번호를 입력해주세요."></td>                         '
			+'			</tr>                                                                                                                             '
			+'			<tr class="login_option">                                                                                                         '
			+'				<td colspan="2" align="center">                                                                                               '
			+'					<a href="#">아이디/비밀번호찾기</a>                                                                                       	  '
			+'					<font color="#2C78D7">&nbsp;|&nbsp;</font>                                                                                '
			+'					<a href="../join/join.jsp">회원가입</a>                                                                                      '
			+'					<font color="#2C78D7">&nbsp;|&nbsp;</font>                                                                                '
			+'					<a href="javascript:m_login()">사서 로그인</a>                                                                                       '
			+'				</td>                                                                                                                         '
			+'			</tr>                                                                                                                             '
			+'			<tr height="70">                                                                                                                  '
			+'				<td colspan="2" align="center">                                                                                               '
			+'					<button type="button" class="login_btn" onclick="login()" >로그인</button>                                                    '
			+'				</td>                                                                                                                         '
			+'			</tr>                                                                                                                             '
			+'		</table>                                                                                                                              '
			+'	</form>                                                                                                                                   '
			+'</div>      																																'
			
			function u_login(){
				$(".login_box").html(u_LoginStr);
			}