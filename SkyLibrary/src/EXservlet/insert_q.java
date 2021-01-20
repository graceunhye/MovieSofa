package EXservlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class insert_q {

	public static void main(String[] args) throws Exception {
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
			
			
			String sql = "insert into q ";
			sql += "(id,title,body,wdate)";
			sql += "value ";
			sql += "('skylibrary','이건 한글 질문 제목_"+i+"','한글 제목 내용입니다._"+i+"',now())";
		
			stmt = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
			stmt.executeUpdate();
			stmt.close();
		}
		con.close();
		System.out.println("완료!");
	}

}
