<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%
	String id 	= (String)session.getAttribute("idKey");
	String isbn = request.getParameter("isbn");
	
	String sql;

	Connection conn = null;	
	
	String m_DBMS     = "jdbc:mysql://127.0.0.1/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String m_UserID   = "root";
	String m_UserPass = "mySQL1234";
	
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
		
		pstmt1  = conn.prepareStatement("update book set rent=1, bcount=bcount+1 where isbn = ?");
		pstmt1.setString(1, isbn);
		int result1 = pstmt1.executeUpdate();
		
		/*
		String endd = "";
		Date d = new Date();
		endd = String.format("%04d-%02d-%02d",1900 + d.getYear(), d.getMonth() + 1 , d.getDate());
		System.out.println(endd);
		*/		
		
		sql = "insert into rent (id,isbn,startd,endd) ";
		sql += "values (?,?,now(),date_add(now(), interval 14 day)) ";
		
		pstmt2  = conn.prepareStatement(sql);
		pstmt2.setString(1, id);
		pstmt2.setString(2, isbn);
		
		//pstmt2.setString(3, endd);
		
		int result2 = pstmt2.executeUpdate();
		
		//select last_insert_id() as last
		

		pstmt2 = conn.prepareStatement("select id, isbn, startd, date(endd) as endd, no from rent where isbn = ?");
		pstmt2.setString(1, isbn);
		
		ResultSet rs = null;
		
		rs = pstmt2.executeQuery();
		
		JSONArray jsonArrList = new JSONArray();
		while(rs.next())
		{
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("id",rs.getString("id"));
			jsonObj.put("isbn",rs.getString("isbn"));
			jsonObj.put("startd",rs.getString("startd"));
			jsonObj.put("endd",rs.getString("endd"));
			jsonObj.put("no",rs.getString("no"));
			jsonArrList.add(jsonObj);
		}
		out.print(jsonArrList);

		
		
	} finally {
		if (pstmt1 != null) try { pstmt1.close(); } catch(SQLException ex) {}
		if (pstmt2 != null) try { pstmt2.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}	
%>
