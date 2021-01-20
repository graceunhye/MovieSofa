<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>    
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){ id = ""; }

	String isbn 		= request.getParameter("isbn");
	String recommend    = request.getParameter("recommend");

	String sql;

	Connection conn = null;	
	
	
	String m_DBMS     = "jdbc:mysql://127.0.0.1/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String m_UserID   = "root";
	String m_UserPass = "mySQL1234";
	
	PreparedStatement pstmt = null;
	
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
			
		
		sql = "insert into rbook (isbn,mid, why) ";
		sql += "values (?,?,?) ";
		
		pstmt  = conn.prepareStatement(sql);
		pstmt.setString(1, isbn);
		pstmt.setString(2, id);
		pstmt.setString(3, recommend);
		
		int result = pstmt.executeUpdate();
		
		pstmt = conn.prepareStatement("select isbn,mid,why,no from rbook where isbn = ? order by no desc ");
		pstmt.setString(1, isbn);
		
		ResultSet rs = null;
		
		rs = pstmt.executeQuery();
		
		JSONArray jsonArrList = new JSONArray();
		while(rs.next())
		{
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isbn",rs.getString("isbn"));
			jsonObj.put("mid",rs.getString("mid"));
			jsonObj.put("why",rs.getString("why"));
			jsonObj.put("no",rs.getString("no"));
			jsonArrList.add(jsonObj);
		}
		out.print(jsonArrList);
	
		
		
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}	
%>