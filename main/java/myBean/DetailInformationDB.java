package myBean;

import java.sql.*;
import javax.naming.NamingException;
import myBean.DsCon;

public class DetailInformationDB { //쿼리문을 이용하여 webtoon DB의 detailList 테이블의 정보들을 조작하기 위한 클래스
	private Connection con;	
	private PreparedStatement pstmt;
	private ResultSet rs;

	
	public DetailInformationDB() throws SQLException, NamingException{
		con=DsCon.getConnection();
		
	}
	
	public String getOldDetailSavedFileName(String detailTitle) throws SQLException{ //수정시 필요한 기존 파일 이름을 가져오는 메소드
		String sql="select detailSavedFileName from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, detailTitle);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("detailSavedFileName");
	}
	
	public String getOldDetailOriginalFileName(String detailTitle) throws SQLException{ //수정 시 필요한 기존 파일 이름을 가져오는 메소드
		String sql="select detailOriginalFileName from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, detailTitle);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("detailOriginalFileName");
	}
	public String getOldToonSavedFileName(String detailTitle) throws SQLException{ //수정시 필요한 기존 파일의 이름을 가져오는 메소드
		String sql="select toonSavedFileName from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, detailTitle);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("toonSavedFileName");
	}
	
	public String getOldToonOriginalFileName(String detailTitle) throws SQLException{ //수정시 필요한 기존 파일의 이름을 가져오는 메소드
		String sql="select toonOriginalFileName from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, detailTitle);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("toonOriginalFileName");
	}
	
	
	public void insertRecord(DetailInformation detail) throws SQLException { //새로운 정보를 삽입하는 메소드
		String sql = "INSERT INTO detailList(webtoonTitle, detailTitle, releaseDay, detailOriginalFileName, detailSavedFileName, toonOriginalFileName, toonSavedFileName) VALUES(?, ?, NOW(), ?, ?, ?, ?)";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, detail.getWebtoonTitle());
		pstmt.setString(2, detail.getDetailTitle());
		pstmt.setString(3, detail.getDetailOriginalFileName());
		pstmt.setString(4, detail.getDetailSavedFileName());
		pstmt.setString(5, detail.getToonOriginalFileName());
		pstmt.setString(6, detail.getToonSavedFileName());
		
		pstmt.executeUpdate();
	}	

	

	public void updateRecord(DetailInformation detail,String a) throws SQLException { //정보를 수정하는 메소드
		String sql="UPDATE detailList SET detailTitle=?, releaseDay=NOW(), detailOriginalFileName=?, detailSavedFileName=?, toonSavedFileName=?, toonOriginalFileName=? where detailTitle=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, detail.getDetailTitle());
		pstmt.setString(2, detail.getDetailOriginalFileName());
		pstmt.setString(3, detail.getDetailSavedFileName());
		pstmt.setString(4, detail.getToonSavedFileName());
		pstmt.setString(5, detail.getToonOriginalFileName());
		pstmt.setString(6, a);
		
		pstmt.executeUpdate();
	
	}

	
	public DetailInformation getRecord(String detailTitle) throws SQLException{ //기존의 정보들을 가져오는 메소드
		String sql="select webtoonTitle, detailTitle, releaseDay, detailOriginalFileName, detailSavedFileName, toonOriginalFileName, toonSavedFileName from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, detailTitle);
		rs=pstmt.executeQuery();
		rs.next();
		DetailInformation detail =new DetailInformation();
		detail.setWebtoonTitle(rs.getString("webtoonTitle"));
		detail.setDetailTitle(rs.getString("detailTitle"));
		detail.setReleaseDay(rs.getString("releaseDay"));
		detail.setDetailOriginalFileName(rs.getString("detailOriginalFileName"));
		detail.setDetailSavedFileName(rs.getString("detailSavedFileName"));
		detail.setToonOriginalFileName(rs.getString("toonOriginalFileName"));
		detail.setToonSavedFileName(rs.getString("toonSavedFileName"));
		return detail;
	}
	
	
	
	
	public void deleteRecord(String a) throws SQLException{ //기존의 정보를 삭제하는 메소드
		String sql="delete from detailList where detailTitle=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, a);
		pstmt.executeUpdate();
	}
	
	
	
	
	
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
