<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%@ include file="../include/openDB.jsp" %>
<%
	String c_no   = request.getParameter("no");
	String sql = "";
	
	sql = "delete from comment where c_no="+c_no;
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	mstmt.executeUpdate();
	mstmt.close();
	conn.close();
	
%>
