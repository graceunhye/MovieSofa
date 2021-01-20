<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>   
<%@ page import="org.json.simple.*"%>

<%
	//request.setCharacterEncoding("EUC-KR");
	String id    = request.getParameter("id");
	String user_name = request.getParameter("name"); //새로 입력한 이름
	String user_num = request.getParameter("num1")+"-"+request.getParameter("num2")+"-"+request.getParameter("num3");
	String user_email1 = request.getParameter("email1"); //새로  입력한 이메일 아이디
	String user_email2 = request.getParameter("email2"); //새로  입력한 이메일 url	
	
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	PreparedStatement mstmt;
	Connection        conn;
	ResultSet         rs;
	
	try{
	
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
		
		String sql = "";
		sql += "update user ";
		sql += "set name=?, num=?, email1=?, email2=? ";
		sql += "where id='" + id +"'";
	
		mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		mstmt.setString(1,user_name);
		mstmt.setString(2,user_num);
		mstmt.setString(3,user_email1);
		mstmt.setString(4,user_email2);
		mstmt.executeUpdate();
		
		mstmt.close();
		
			
		sql = 	"select * from user ";
		sql += 	"where id = '" + id +"'";
		mstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs = mstmt.executeQuery();	
		
		rs.next();
		
		String	name 		= rs.getString("name");
		String num			= rs.getString("num");
	   	String email1 	    = rs.getString("email1");
	   	String email2 	    = rs.getString("email2");
	   	 
	
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
	
		mstmt.close();
		conn.close();	
		
	  	}catch(Exception e){
	   		
	   		System.out.println("Error : 드라이버 로딩 실패");
	   		
	   		
	   	}

%> 