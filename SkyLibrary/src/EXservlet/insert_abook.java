package EXservlet;

import java.sql.*;


public class insert_abook {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		
		Connection con;
		PreparedStatement stmt;
		ResultSet rs;
		

		String DBURL = "jdbc:mysql://localhost:3306/skylibrary?"
						+"useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";                             
		String DBID  = "root";
		String DBPW  = "mySQL1234";
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection( DBURL ,DBID ,DBPW );
		
		for(int i=0; i<50; i++) {
			
			
			String sql = "insert into abook ";
			sql += "(id,isbn,subject,company,pdate,wdate,writer,price,why)";
			sql += "value ";
			sql += "('skylibrary','12345678910','this is subject_"+i+"','company_"+i+"','2020', now(),'writer_"+i+"','15000','이 책이 읽고싶기 때문입니다!!!!!!!!!!!!!!!!!')";
		
			stmt = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
			stmt.executeUpdate();
			stmt.close();
		}
		con.close();
		System.out.println("완료!");

	}

}
