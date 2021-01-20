<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%

	request.setCharacterEncoding("EUC-KR");
	String selectType = request.getParameter("select");   //구분값
	String startDate  = request.getParameter("startDate");    //작성일 처음값
	String endDate    = request.getParameter("endDate");      //작성일 나중값
	
	
	String            m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
											+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String            m_UserID   = "root";
	String            m_UserPass = "mySQL1234";
	Connection        conn       = null;
	PreparedStatement pstmt      = null;
	ResultSet         rs         = null;
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	
	
	String sql = "select * from q ";
	String where = "";
	
	if(!selectType.equals("2")) 
	{
		where = "where atype="+ selectType;
	}
	if(!startDate.equals("") && !endDate.equals("")) 
	{
		if(!where.equals(""))
		{
			where = " where atype="+ selectType + " and ";
		}else {
			where = " where ";
		}
		where +=  " wdate between '"+ startDate +"' and '"+ endDate +"' ";
	}
	sql += where + " order by no desc";
	
	System.out.println("final sql::" + sql);
	
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	
	JSONArray  jsonArrList = new JSONArray(); 
	while(rs.next())
	{	
		JSONObject jsonList = new JSONObject();
		
		String no     = rs.getString("no");
		String id     = rs.getString("id");
		String title  = rs.getString("title");
		title = "<a href='javascript:qViewFn("+ no +")'>"+ title +"</a>";
		String okdate = rs.getString("okdate");
		if(okdate == null){ okdate = ""; }
		
		String wdate  = rs.getString("wdate");
		String atype  = rs.getString("atype");
		
		if     (atype.equals("0")){ atype = "<font color='blue'>답변대기</font>"; }
		else if(atype.equals("1")){ atype = "<font color='orange'>답변완료</font>"; }
		
		jsonList.put("no",no);
		jsonList.put("id",id);
		jsonList.put("title",title);
		jsonList.put("wdate",wdate);
		jsonList.put("okdate",okdate);
		jsonList.put("atype",atype);
		
		jsonArrList.add(jsonList);
	}
	
	out.println(jsonArrList);

	rs.close();
	pstmt.close();
	conn.close();
%>