<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%

	String no = request.getParameter("no"); //������ȣ
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	
	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	} catch(Exception e) {
			System.out.println("Error : ����̹� �ε� ����");
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	String sql = "delete from q where no="+no;
	
	pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE );
	pstmt.executeUpdate();
	pstmt.close();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<script>
		alert("������ �Ϸ�Ǿ����ϴ�.");
		location.href="qna.jsp";
	</script>
</head>
<body>
</body>
</html>