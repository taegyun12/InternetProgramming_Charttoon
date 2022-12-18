package myBean;

import java.sql.*;
import javax.naming.NamingException;
import myBean.DsCon;

public class ToonInformationDB {//webtoon DB의 webtoonList 테이블을 관리하기 위한 클래스
	private Connection con;	
	private PreparedStatement pstmt;
	private ResultSet rs;

	
	public ToonInformationDB() throws SQLException, NamingException{
		con=DsCon.getConnection();
		
	}
	
	public void insertRecord(ToonInformation toon) throws SQLException { //새로운 정보를 삽입하기 위한 메소드
		String sql = "INSERT INTO webtoonList(title, genre, author, introduce, shorts, originalFileName, savedFileName) VALUES(?, ?, ?, ?, ?, ?, ?)";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, toon.getTitle());
		pstmt.setString(2, toon.getGenre());
		pstmt.setString(3, toon.getAuthor());
		pstmt.setString(4, toon.getIntroduce());
		pstmt.setString(5, toon.getShorts());
		pstmt.setString(6, toon.getOriginalFileName());
		pstmt.setString(7, toon.getSavedFileName());
		pstmt.executeUpdate();
	}	
	
	public String getOldSavedFileName(String idx) throws SQLException{ //수정시 필요한 기존의 파일 이름을 가져오는 메소드
		String sql="select savedFileName from webtoonList where idx=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(idx));
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("savedFileName");
	}
	
	public String getOldOriginalFileName(String idx) throws SQLException{ //수정시 필요한 기존의 파일 이름을 가져오는 메소드
		String sql="select originalFileName from webtoonList where idx=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(idx));
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		return rs.getString("originalFileName");
	}



	public void updateRecord(ToonInformation toon) throws SQLException { //기존의 정보를 수정하는 메소드
		String sql="update webtoonList set title=?, genre=?, author=?, introduce=?, shorts=?, originalFileName=?, savedFileName=? where idx=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, toon.getTitle());
		pstmt.setString(2, toon.getGenre());
		pstmt.setString(3, toon.getAuthor());
		pstmt.setString(4, toon.getIntroduce());
		pstmt.setString(5, toon.getShorts());
		pstmt.setString(6, toon.getOriginalFileName());
		pstmt.setString(7, toon.getSavedFileName());
		pstmt.setInt(8, toon.getIdx());
		pstmt.executeUpdate();
	
	}


	public ToonInformation getRecord(int idx) throws SQLException{ //기존의 정보를 가져오는 메소드
		String sql="select title, genre, author, introduce, shorts, savedFileName, originalFileName from webtoonList where idx=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs=pstmt.executeQuery();
		rs.next();
		ToonInformation toon =new ToonInformation();
		toon.setTitle(rs.getString("title"));
		toon.setGenre(rs.getString("genre"));
		toon.setAuthor(rs.getString("author"));
		toon.setIntroduce(rs.getString("introduce"));
		toon.setShorts(rs.getString("shorts"));
		toon.setSavedFileName(rs.getString("savedFileName"));
		toon.setOriginalFileName(rs.getString("originalFileName"));
		return toon;
	}
	
	
	
	

	public void deleteRecord(int idx) throws SQLException{ //기존의 정보를 삭제하는 메소드(웹툰 삭제시 detailList 테이블에서 관련된 회차도 같이 삭제)
		String sql1="select title from webtoonList where idx=?";
		PreparedStatement pstmt1=con.prepareStatement(sql1);
		pstmt1.setInt(1, idx);
		rs=pstmt1.executeQuery();
		rs.next();
		String title=rs.getString("title");
		
		String sql2="delete from webtoonList where idx=?";
		pstmt=con.prepareStatement(sql2);
		pstmt.setInt(1, idx);
		pstmt.executeUpdate();
		
		String sql3="delete from detailList where webtoonTitle=?";
		PreparedStatement pstmt2=con.prepareStatement(sql3);
		pstmt2.setString(1, title);
		pstmt2.executeUpdate();
	}
	
	
	
	
	
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
