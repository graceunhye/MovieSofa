package MovieSofa;
import java.sql.*;

public class RegisterMgr 
{
	private final String     m_DBMS     = "jdbc:mysql://localhost:3306/moviesofa?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	private final String     m_UserID   = "root";
	private final String     m_UserPass = "mySQL1234";
	
	public RegisterMgr() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch(Exception e) {
			System.out.println("Error : 드라이버 로딩 실패");
		}
	}
	
	public boolean loginRegister(String id, String pw) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		boolean loginCon = false;
		try {
			conn = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
			String sql = "select count(*) from user where id = ? and pw = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(rs.next() && rs.getInt(1)>0)
			{
				loginCon = true;
			}
				
		} catch(Exception e) {
			System.out.println("Exception");
		} finally {
			if(rs != null) {
				try {rs.close();} catch (SQLException e) {} 
			}
			if(pstmt != null) {
				try {pstmt.close();} catch (SQLException e) {} 
			}
			if(conn != null) {
				try {conn.close();} catch (SQLException e) {} 
			}
		}
		return loginCon;
	}
}
