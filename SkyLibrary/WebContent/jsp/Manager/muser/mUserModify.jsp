<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String id    = request.getParameter("id");
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String	   name 	;		
	String	   num 		;	
	String	   postNum 	;  	
   	String	   addr1    ; 	
   	String	   addr2 	;   
   	String	   email1 	;   
   	String	   email2 	;  
   	
   	
   	try{


		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );

		String sql;
   		
		sql = 	"select * from user ";
		sql += 	"where id = '" + id +"'";
		pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = pstmt.executeQuery();	
		
		rs.next();
		
		 name 			= rs.getString("name");
		 num 			= rs.getString("num");
		 postNum 	   	= Integer.toString(rs.getInt("postNum"));
	   	 addr1       	= rs.getString("addr1");
	   	 addr2 	  		= rs.getString("addr2");
	   	 email1 	    = rs.getString("email1");
	   	 email2 	    = rs.getString("email2");
	   	 

		String num1 ="";
		String num2 ="" ;
		String num3 ="";
		
		if(num!= null || num.equals("")){
			//int num_idx = num.indexOf("-"); 
			String[] numArr = num.split("-");
			num1 = numArr[0];
			num2 = numArr[1];
			num3 = numArr[2];

		}
		
		if(postNum.equals("0")){postNum = "";}
		
	   	JSONArray  jsonArrList = new JSONArray(); 
	   	JSONObject jsonList    = new JSONObject();
		
		jsonList.put("name",name);
		jsonList.put("num1",num1);
		jsonList.put("num2",num2);
		jsonList.put("num3",num3);
		jsonList.put("email1",email1);
		jsonList.put("email2",email2);
		
		jsonArrList.add(jsonList);
		out.println(jsonArrList);	
		
		rs.close();
		pstmt.close();
		conn.close();	
		
		
   	}catch(Exception e){
   		
   		System.out.println("Error : 드라이버 로딩 실패");
   		
   		
   	}

%>