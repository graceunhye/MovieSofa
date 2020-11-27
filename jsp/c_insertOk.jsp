<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ include file="../include/openDB.jsp" %>
<%	

	String id = (String)session.getAttribute("idKey");


	String rv_no    = request.getParameter("rv_no");
	String mv_no    = request.getParameter("mv_no");
	String ic_body  = request.getParameter("ic_body");

	String sql = "";

	sql  = "insert into comment ";
	sql += "(id, c_body, rv_no, c_date) ";
	sql += "value ";
	sql += "(?,?,?,now()) ";
	mstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	mstmt.setString(1, id);
	mstmt.setString(2, ic_body);
	mstmt.setString(3, rv_no);
	mstmt.executeUpdate();
	mstmt.close();
	conn.close();
 %>