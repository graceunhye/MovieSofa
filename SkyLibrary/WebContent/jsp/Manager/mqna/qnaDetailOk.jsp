<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%

request.setCharacterEncoding("EUC-KR");
String            m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
		+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
String            m_UserID   = "root";
String            m_UserPass = "mySQL1234";
Connection        conn       = null;
PreparedStatement pstmt      = null;
ResultSet         rs         = null;
Class.forName("com.mysql.cj.jdbc.Driver");
conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	

String no = request.getParameter("no");
String sql = "select * from q where no="+no;
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
rs.next();

JSONArray  qArrList = new JSONArray(); 
JSONObject qList    = new JSONObject(); 

String id     = rs.getString("id");
String title  = rs.getString("title");
String body   = rs.getString("body");
String okdate = rs.getString("okdate");
if(okdate == null){ okdate = ""; }
String wdate  = rs.getString("wdate");
String atype  = rs.getString("atype");

qList.put("no",no);
qList.put("id",id);
qList.put("title",title);
qList.put("body",body);
qList.put("wdate",wdate);
qList.put("okdate",okdate);
qList.put("atype",atype);
rs.close();
if(atype.equals("1")){
	sql = "select * from a where no="+no;
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rs.next();
	qList.put("mid",rs.getString("mid"));
	qList.put("mtitle",rs.getString("title"));
	qList.put("mbody",rs.getString("body"));
	qList.put("mwdate",rs.getString("wdate"));
	rs.close();
}
qArrList.add(qList);
out.println(qArrList);
pstmt.close();
conn.close();


%>
