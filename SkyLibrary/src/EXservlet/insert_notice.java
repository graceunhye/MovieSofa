package EXservlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class insert_notice {

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
			
			
			String sql = "insert into notice ";
			sql += "(mid,title,body,ndate)";
			sql += "value ";
			sql += "('manager','�ѱ� �����Դϴ�._"+i+"','�ѱ� ���� ���� �Դϴ�._"+i+"',now())";
		
			stmt = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
			stmt.executeUpdate();
			stmt.close();
		}
		con.close();
		System.out.println("�Ϸ�!");

	}

}
