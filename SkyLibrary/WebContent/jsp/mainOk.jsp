<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>   
<%
	request.setCharacterEncoding("EUC-KR");
	String forWhat = request.getParameter("forWhat");
	
	String sql = "";
	Connection con;
	PreparedStatement stmt;
	ResultSet rs;
	

	String DBURL = "jdbc:mysql://localhost:3306/skylibrary?"
					+"useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
	String DBID  = "root";
	String DBPW  = "mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	con = DriverManager.getConnection( DBURL ,DBID ,DBPW );
	
	if(forWhat.equals("notice")) 
	{
		sql = "select * from notice order by no desc limit 0,5";
	}
	if(forWhat.equals("book"))
	{
		sql = "select coverimg, subject, isbn from book order by pdate desc limit 0,6";
	}
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();
	System.out.println("sql::" + sql);
	
	JSONArray jsonArrList = new JSONArray();
	
	
	/** 공지사항 **/
	if(forWhat.equals("notice")) 
	{
		while(rs.next()){
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("title", rs.getString("title"));
			jsonObj.put("body", rs.getString("body"));
			jsonObj.put("mid", rs.getString("mid"));
			jsonObj.put("no", rs.getString("no"));
			jsonObj.put("ndate", rs.getString("ndate"));
			
			jsonArrList.add(jsonObj);
		}
	}
	
	
	/** 신간도서 **/
	if(forWhat.equals("book"))
	{
		while(rs.next()){
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("coverimg", rs.getString("coverimg")); //커버이미지
			jsonObj.put("isbn", rs.getString("isbn"));         //isbn
			jsonObj.put("subject", rs.getString("subject"));   //책제목
			
			jsonArrList.add(jsonObj);
			
		}
	}
	
	
	out.print(jsonArrList);
	System.out.println("jsonArrList::"+jsonArrList);
	rs.close();
	stmt.close();
	con.close();
	System.out.println("mainOk.jsp 완료");
%>