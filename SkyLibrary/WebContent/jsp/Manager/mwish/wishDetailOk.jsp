<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
try{
		String no   = request.getParameter("no"); //±Û¹øÈ£
		String sql  = "";
		
		String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		String     m_UserID   = "root";
		String     m_UserPass = "mySQL1234";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	
		
		
		sql = "select * from abook where no="+no+"";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		
		JSONArray  jsonArrList = new JSONArray(); 
		JSONObject jsonList    = new JSONObject();
		
		jsonList.put("no",rs.getString("no"));
		jsonList.put("pdate",rs.getString("pdate"));
		jsonList.put("subject",rs.getString("subject"));
		jsonList.put("writer",rs.getString("writer"));
		jsonList.put("price",rs.getString("price"));
		jsonList.put("company",rs.getString("company"));
		jsonList.put("isbn",rs.getString("isbn"));
		jsonList.put("why",rs.getString("why"));
		jsonList.put("atype",rs.getString("atype"));
		jsonArrList.add(jsonList);
		
		
		out.println(jsonArrList);	
		System.out.println("wishDetailOk.jsp complete!");
		
		rs.close();
		pstmt.close();
		conn.close();

}catch(Exception e) {
	
		System.out.println("error");
		e.printStackTrace();
		
}
%>