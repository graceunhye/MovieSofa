<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	try{
	JSONArray  jsonArrList = new JSONArray(); 

	request.setCharacterEncoding("EUC-KR");
	String select    = request.getParameter("select");      //구분값
	String startDate = request.getParameter("startDate");   //처리일자 처음값
	String endDate   = request.getParameter("endDate");     //처리일자 나중값
	System.out.println("date"+startDate);
	if(startDate.equals("")) 
	{
		System.out.println("1");
	}else if(startDate == null) 
	{
		System.out.println("2");
	}else 
	{
		System.out.println("3");
	}
	
	/** DB 연결  **/
	String m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?"
							+"useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	String m_UserID   = "root";
	String m_UserPass = "mySQL1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );	
	String sql = "";
	String where = "";
	
	sql = "select * from abook ";
	if(!select.equals("4")) 
	{
		where = "atype=" + select + " ";
	}
	//날짜를 입력 했을 때
	if(!startDate.equals("") && !endDate.equals(""))
	{
		//type을 설정했을 때
		if(!where.equals(""))
		{
			where += " and ";
		}
		where += "( okdate >= '" + startDate + "' and okdate <= '" + endDate + "')";
	}
	
	/* System.out.println("sql1:" + sql);
	System.out.println("where:" + where); */
	if( !where.equals(""))
	{
		sql += "where " + where + " ";
	}
	/* System.out.println("final sql :" + sql + " "); */
	
	pstmt = conn.prepareStatement(sql+" order by no desc");
	rs = pstmt.executeQuery();
	
	while(rs.next()) {
		
		JSONObject jsonList    = new JSONObject();
		
		String no      = rs.getString("no");      //신청번호
		String id      = rs.getString("id");      //신청자
		String writer  = rs.getString("writer");  //작가명
		String company = rs.getString("company"); //출판사
		String price   = rs.getString("price");   //가격
		String why     = rs.getString("why");     //이유
		String isbn    = rs.getString("isbn");    //책isbn
		String subject = rs.getString("subject"); //책이름
		String pdate   = rs.getString("pdate");   //책발행일
		String wdate   = rs.getString("wdate");   //신청일
		String atype   = rs.getString("atype");   //신청구분
		String okdate  = rs.getString("okdate");  //처리일

		jsonList.put("no",no);
		jsonList.put("id",id);
		jsonList.put("writer",writer);
		jsonList.put("company",company);
		jsonList.put("price",price);
		jsonList.put("isbn",isbn);
		jsonList.put("subject",subject);
		jsonList.put("wdate",wdate);
		jsonList.put("atype",atype);
		jsonList.put("okdate",okdate);
		jsonList.put("pdate",pdate);
		jsonList.put("why",why);
		jsonArrList.add(jsonList);

		
	}

	


	out.println(jsonArrList);
	rs.close();
	pstmt.close();
	conn.close();
	}catch(Exception e) {
		
		System.out.println("error");
		e.printStackTrace();
	}
%>