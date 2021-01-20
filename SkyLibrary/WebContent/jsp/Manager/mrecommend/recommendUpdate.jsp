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
	
		pstmt  = conn.prepareStatement("update rbook set why=? where isbn=?");
		pstmt.setString(1, recommend);
		pstmt.setString(2, isbn);
		int result = pstmt.executeUpdate();
		
		pstmt = conn.prepareStatement("select * from rbook where isbn=" + isbn);
		
		ResultSet rs = null;
		rs = pstmt.executeQuery();
		
		//[{}, {}, {}] -> JSON 구조
		JSONArray jsonList = new JSONArray(); // json의 구조에서 [] (큰 그릇) 생성
		
		while(rs.next())
		{
			JSONObject jsonObj = new JSONObject(); // json 구조에서 {} (작은 그릇) 생성
			jsonObj.put("isbn",rs.getString("isbn"));
			jsonObj.put("why",rs.getString("why"));
			jsonList.add(jsonObj); // [{}] json 구조에서 큰 그릇에 작은 그릇을 넣는 순간
		}
 		out.print(jsonList); //만들어진 json 데이터를 실제 화면에 뿌려주는 곳
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>