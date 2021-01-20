<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   <%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("EUC-KR");

	String id      = (String)session.getAttribute("idKey");  //아이디
	String keyword = request.getParameter("keyword");        //검색어
	String select  = request.getParameter("select");         //검색옵션
	int    pageno;
	
	if(request.getParameter("pageno")==null)
	{
		 pageno = 1;
	}else 
	{
		pageno  = Integer.parseInt(request.getParameter("pageno"));
	}

	if(keyword==null || select == null)
	{
		keyword = "";
		select  = "";
	}
	
	
	String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
									+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String     m_UserID   = "root";
	String     m_UserPass = "mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection        conn  = null;
	PreparedStatement pstmt = null;
	ResultSet         rs    = null;
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
	
	
	
	
	String sql = "select * from q ";
	String where = "";
	
	if(!keyword.equals("")){
		
		switch(select){
		case "0" :
			where = "where title like '%"+keyword+"%' or body like '%"+keyword+"%' ";
			break;
		case "1" :
			where  = "where title like '%"+keyword+"%' ";
			break;
		case "2" :
			where  = "where body like '%"+keyword+"%' ";
			break;
		}	
	}
	
	sql += where + " order by no desc limit "+ (15*pageno) +",15";
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	JSONArray  jsonArrList = new JSONArray(); 
	
	
	while(rs.next()){
		
		JSONObject jsonList    = new JSONObject();
		jsonList.put("pageno",pageno);
		jsonList.put("no",rs.getString("no"));
		jsonList.put("id",rs.getString("id"));
		jsonList.put("title",rs.getString("title"));
		jsonList.put("body",rs.getString("body"));
		jsonList.put("wdate",rs.getString("wdate"));
		jsonList.put("okdate",rs.getString("okdate"));
		jsonList.put("hit",rs.getString("hit"));
		
		if(rs.getString("atype").equals("0")){
			jsonList.put("atype","<font color='blue'>답변대기</font>");
		}else{
			jsonList.put("atype","<font color='orange'>답변완료</font>");
		}
		
		jsonArrList.add(jsonList);
	}
	out.println(jsonArrList);
	System.out.println("qnaSearchOk.jsp complete!");
	rs.close();
	pstmt.close();
	conn.close();

%>