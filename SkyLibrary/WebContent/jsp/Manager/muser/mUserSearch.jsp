<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*"%>
    
<%
		request.setCharacterEncoding("UTF-8");
		String select = request.getParameter("searchType");
		String keyword = request.getParameter("searchText");

		
		if(select == null){ select = "typeId"; } ////�˻��ɼ� ���� �� �� �� �⺻�� "typeID"
		if(keyword == null){ keyword = ""; } //null������

		
		String     m_DBMS     = "jdbc:mysql://localhost:3306/skylibrary?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
		String     m_UserID   = "root";
		String     m_UserPass = "mySQL1234";
		String sql = "";
		
		JSONArray  jsonArrList = new JSONArray(); 
		JSONObject jsonList    = new JSONObject();

	try{
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );

		
		if(keyword == ""){
			
			sql = "select * from user ";
			
		}else{
		
			switch(select){	
			
				case "typeId": 
					sql = "select * from user where id like '%"+keyword+"%'";
					break;
				
				case "typeName" : 
					sql = "select * from user where name like '%"+keyword+"%'";
					break;
					
	
			}		
		}
		System.out.println(sql);

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
				

			String user_id;
			String user_name;
			String user_num;
			String user_email1;
			String user_email2;
			
		if(rs != null){
			while(rs.next()) {
					// user_id  		= rs.getString("id");   	//���̵�
					//user_name  	= rs.getString("name");   	//�̸�
					 //user_num    	= rs.getString("num");     	//����ó
					//user_email1    = rs.getString("email1");   //�̸���1
					// user_email2    = rs.getString("email2");  //�̸���2
	
					jsonList    = new JSONObject();
					 
					jsonList.put("id",rs.getString("id"));
					jsonList.put("name",rs.getString("name"));
					jsonList.put("num",rs.getString("num"));
					jsonList.put("email1",rs.getString("email1"));
					jsonList.put("email2",rs.getString("email2"));
					
					jsonArrList.add(jsonList);
		
			}
		}
	
		
		out.println(jsonArrList);
		rs.close();
		pstmt.close();
		conn.close();	
		

	}catch(Exception e){
%>		
	<script>
		alert("�˻��� �����Ͽ����ϴ�. �ٽ� �õ����ּ���.");
		window.location = "mUser.jsp";
	</script>	
<%		
	}


%>