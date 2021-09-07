package model.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.common.JDBC;

public class ProductDAO {
	
	public ArrayList<ProductVO> getDBList(ProductVO vo) {
		Connection conn = JDBC.connect();
		PreparedStatement pstmt=null;
		ArrayList<ProductVO> datas = new  ArrayList<ProductVO>();
		
		try {
			String sql= "select * from product where pname like '%' || ? || '%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPname());
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductVO data = new ProductVO();
				data.setPnum(rs.getInt("pnum"));
				data.setAccount(rs.getString("account"));
				data.setPname(rs.getString("pname"));
				data.setPrice(rs.getInt("price"));
				data.setStock(rs.getInt("stock"));
				
				datas.add(data);
				
			}
			rs.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAT getDBList() 메서드에서 할생한 오류");
		}finally {
			
			JDBC.disconnect(pstmt, conn);
		}
		
		return datas;
		
		
	}
	
	public ProductVO getDBData(ProductVO vo) {
		Connection conn = JDBC.connect();
		PreparedStatement pstmt =null;
		ProductVO data=null;
		
		try {
			String sql="select * from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getPnum());
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				data = new ProductVO();
				data.setAccount(rs.getString("account"));
				data.setPname(rs.getString("pname"));
				data.setPnum(rs.getInt("pnum"));
				data.setPrice(rs.getInt("price"));
				data.setStock(rs.getInt("stock"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAO getDBDate() 에서 발생한 오류");
		} finally {
			JDBC.disconnect(pstmt, conn);
			
		}
		return data;
		
	}
	public boolean addDBDate(ProductVO vo) {
		
		boolean result = false;
		Connection conn = JDBC.connect();
		PreparedStatement pstmt =null;
		try {
			String sql="insert into product values((select nvl(max(pnum),0)+1 from product), ?, ?, ? , ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPname());
			pstmt.setInt(2, vo.getPrice());
			pstmt.setInt(3, vo.getStock());
			pstmt.setString(4, vo.getAccount());
			pstmt.executeUpdate();
			result =true;
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAO addDBDate() 에서 발생한 오류");
			
		}finally {
			JDBC.disconnect(pstmt, conn);
			
		}
		
		return result;
		
		
		
		
		
	}
	public boolean deleteDate(ProductVO vo) {
		
		boolean result = false;
		Connection conn = JDBC.connect();
		PreparedStatement pstmt =null;
		try {
			String sql="delete from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getPnum());
			pstmt.executeUpdate();
			result =true;
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAO deleteDate() 에서 발생한 오류");
			
		}finally {
			JDBC.disconnect(pstmt, conn);
			
		}
		
		return result;
		
	}
	public boolean updateDate(ProductVO vo) {
		boolean result = false;
		Connection conn = JDBC.connect();
		PreparedStatement pstmt =null;
		try {
			String sql="update product set pname=?, price=? ,stock=? ,account=? where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getPname());
			pstmt.setInt(2, vo.getPrice());
			pstmt.setInt(3, vo.getStock());
			pstmt.setString(4, vo.getAccount());
			pstmt.setInt(5, vo.getPnum());
			pstmt.executeUpdate();
			result =true;
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAO deleteDate() 에서 발생한 오류");
			
		}finally {
			JDBC.disconnect(pstmt, conn);
			
		}
		
		return result;
		
		
	}
	public boolean minusStock(ProductVO vo) {
		boolean result = false;
		Connection conn = JDBC.connect();
		PreparedStatement pstmt =null;
		try {
			String sql="update product set stock = stock- ? where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getStock());
			pstmt.setInt(2, vo.getPnum());
			pstmt.executeUpdate();
			result =true;
			System.out.println("ProductDAO minusStock() 실행 중");
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("ProductDAO minusStock() 에서 발생한 오류");
			
		}finally {
			JDBC.disconnect(pstmt, conn);
			
		}
		
		return result;
		
		
	}

}
