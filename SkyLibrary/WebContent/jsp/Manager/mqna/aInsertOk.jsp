<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	String id = (String)session.getAttribute("idKey");
	if(id == null){
		id = "";
	}
	
	String no    = request.getParameter("no");     //��ȣ
	String title = request.getParameter("title");  //�亯����
	String body  = request.getParameter("body");   //�亯����

	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";

	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	

	
	/** �۹�ȣ�� no�� ������ �亯 �߰��ϱ� **/
	String sql =  "insert into a ";
		   sql += "(no, mid, title, body, wdate) ";
		   sql += "values ";
		   sql += "(?,?,?,?,now());";
		   
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,no);
	pstmt.setString(2,id);
	pstmt.setString(3,title);
	pstmt.setString(4,body);
	pstmt.executeUpdate();
	pstmt.close();
	
	/** �۹�ȣ no�� ������ (�亯���->�亯�Ϸ�) �����ϱ�  **/
	sql = "update q set atype=1, okdate=now() where no="+ no +"";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	pstmt.close();
	
	

	JSONArray  qArrList = new JSONArray(); 
	JSONObject qList    = new JSONObject(); 

	
	sql = "select * from a where no="+no;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.next();
	
	
	qList.put("mid",rs.getString("mid"));
	qList.put("mtitle",rs.getString("title"));
	qList.put("mbody",rs.getString("body"));
	qList.put("mwdate",rs.getString("wdate"));
	rs.close();

	qArrList.add(qList);
	out.println(qArrList);
	pstmt.close();
	conn.close();
%>