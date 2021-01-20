<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
<%
	try{
	JSONArray  jsonArrList = new JSONArray(); 

	request.setCharacterEncoding("EUC-KR");
	String select    = request.getParameter("select");      //���а�
	String startDate = request.getParameter("startDate");   //ó������ ó����
	String endDate   = request.getParameter("endDate");     //ó������ ���߰�
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
	
	/** DB ����  **/
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
	//��¥�� �Է� ���� ��
	if(!startDate.equals("") && !endDate.equals(""))
	{
		//type�� �������� ��
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
		
		String no      = rs.getString("no");      //��û��ȣ
		String id      = rs.getString("id");      //��û��
		String writer  = rs.getString("writer");  //�۰���
		String company = rs.getString("company"); //���ǻ�
		String price   = rs.getString("price");   //����
		String why     = rs.getString("why");     //����
		String isbn    = rs.getString("isbn");    //åisbn
		String subject = rs.getString("subject"); //å�̸�
		String pdate   = rs.getString("pdate");   //å������
		String wdate   = rs.getString("wdate");   //��û��
		String atype   = rs.getString("atype");   //��û����
		String okdate  = rs.getString("okdate");  //ó����

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