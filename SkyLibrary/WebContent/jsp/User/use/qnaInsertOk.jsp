<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%

	request.setCharacterEncoding("EUC-KR");
	String id    = (String)session.getAttribute("idKey");  //아이디
	String title = request.getParameter("title");          //제목
	String body  = request.getParameter("body");           //내용
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	String sql  = "insert into q ";
		   sql += "(id, title, body, wdate) ";
		   sql += "value ";
		   sql += "(?, ?, ?, now())";
				   
	pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	pstmt.setString(1, id);
	pstmt.setString(2, title);
	pstmt.setString(3, body);
	pstmt.executeUpdate();
	pstmt.close();
	
	sql = "select * from q where no=last_insert_id()";
	pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
	rs = pstmt.executeQuery();
	rs.next();
	String no = rs.getString("no");
	
	
	if(rs != null) {
		try {rs.close();} catch (SQLException e) {} 
	}
	if(pstmt != null) {
		try {pstmt.close();} catch (SQLException e) {} 
	}
	if(conn != null) {
		try {conn.close();} catch (SQLException e) {} 
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta charset="EUC-KR">
<title>질의응답</title>
<script>
	location.href="qnaView.jsp?no="+<%= no %>;
</script>
</head>
<body>
</body>
</html>