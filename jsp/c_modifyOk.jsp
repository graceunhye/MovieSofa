<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="../include/openDB.jsp" %>
<%

String no     = request.getParameter("no");
String c_body = request.getParameter("c_body");
String sql    = "";


//´ñ±Û ¼öÁ¤
sql   = "update comment set c_body=?, c_date=now() where c_no="+no;
mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
mstmt.setString(1,c_body);
mstmt.executeUpdate();
mstmt.close();


//¼öÁ¤µÈ ´ñ±Û Á¶È¸
sql   = "select * from comment where c_no="+no;
mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
rs    = mstmt.executeQuery();
rs.next();


JSONArray  jsonArrList = new JSONArray(); 
JSONObject jsonList    = new JSONObject();


String gc_body  = rs.getString("c_body");   //´ñ±Û³»¿ë
String gc_date  = rs.getString("c_date");  //´ñ±ÛÀÛ¼ºÀÏ
String gc_no    = rs.getString("c_no");	   //´ñ±Û¹øÈ£
String grv_no   = rs.getString("rv_no");   //¸®ºä¹øÈ£


jsonList.put("c_body",gc_body);
jsonList.put("c_date",gc_date);
jsonList.put("c_no",gc_no);
jsonList.put("rv_no",grv_no);
jsonArrList.add(jsonList);

out.println(jsonArrList);	
 	

rs.close();
mstmt.close();
conn.close();
%>