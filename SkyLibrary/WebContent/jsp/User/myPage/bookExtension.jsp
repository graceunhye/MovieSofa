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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String m_DBMS     = "jdbc:mysql://127.0.0.1/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String m_UserID   = "root";
	String m_UserPass = "mySQL1234";
	
	
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
		pstmt  = conn.prepareStatement("update rent set endd = date_add(endd, interval 7 day) where isbn=?");
		pstmt.setString(1, isbn);
		int result = pstmt.executeUpdate();
		
		pstmt = conn.prepareStatement("select * from rent where isbn=" + isbn);
		
		rs = pstmt.executeQuery();
		
		//[{}, {}, {}] -> JSON 구조
		JSONArray jsonList = new JSONArray(); // json의 구조에서 [] (큰 그릇) 생성
		
		while(rs.next())
		{
			JSONObject jsonObj = new JSONObject(); // json 구조에서 {} (작은 그릇) 생성
			jsonObj.put("endd",rs.getString("endd"));
			jsonList.add(jsonObj); // [{}] json 구조에서 큰 그릇에 작은 그릇을 넣는 순간
		}
 		out.print(jsonList); //만들어진 json 데이터를 실제 화면에 뿌려주는 곳
	} finally {
		if (rs != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}		
%>