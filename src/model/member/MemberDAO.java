package model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.common.JDBC;

public class MemberDAO {
	
	
	public MemberVO getdata(MemberVO vo) {
		
		Connection conn = JDBC.connect();
		PreparedStatement pstmt = null;
		MemberVO data = null;
		
		try {
			String sql= "select * from member where mid=? and mpw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getMpw());
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				data = new MemberVO();
				data.setMid(rs.getString("mid"));
				data.setMpw(rs.getString("mpw"));
				data.setMnum(rs.getInt("mnum"));
			}
			
			rs.close();
			
			
				
				
			
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("MemverVO getdata() 메서드에서 발생한 오류");
		}finally {
			JDBC.disconnect(pstmt, conn);
		}
		return data;
		
	}

}
