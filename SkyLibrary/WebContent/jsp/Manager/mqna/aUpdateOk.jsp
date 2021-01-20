<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String body  = request.getParameter("body");
	String no    = request.getParameter("no");
	String mid   = "manager";
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
									+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";

	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	
	
	String sql = "update a set body='"+ body +"', title='"+ title +"', mid='"+ mid +"', wdate=now() where no="+ no +"";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	System.out.println("1");
	
	sql = "update q set okdate=now() where no="+no;
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	System.out.println("2");
	
	sql = "select * from a where no="+ no +"";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.next();
	System.out.println("3");
	
	String gbody  = rs.getString("body");
	String gmid   = rs.getString("mid");
	String gtitle = rs.getString("title");
	String gwdate = rs.getString("wdate");
	String gno    = rs.getString("no");
	
	JSONArray  jsonArrList = new JSONArray(); 
	JSONObject jsonList    = new JSONObject();
	
	
	jsonList.put("no",gno);
	jsonList.put("mid",gmid);
	jsonList.put("body",gbody);
	jsonList.put("title",gtitle);
	jsonList.put("wdate",gwdate);
	jsonArrList.add(jsonList);

	out.println(jsonArrList);	
	 	
	System.out.println("jsonArr::"+jsonArrList);
	rs.close();
	pstmt.close();
	conn.close();
	
%>