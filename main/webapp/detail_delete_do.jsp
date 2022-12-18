<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,myBean.*, javax.naming.*, java.io.*" %>
    
<%
request.setCharacterEncoding("utf-8");		
//detail_list에서 삭제버튼을 누를 시 해당 회차가 삭제되는 기능을 하는 jsp 파일
String detailTitle = request.getParameter("detailTitle");	
//삭제할 회차의 제목을 받아옴
try {
	DetailInformationDB db = new DetailInformationDB();
	//객체 생성
	String oldDetailSavedFileName= db.getOldDetailSavedFileName(detailTitle);
	String oldToonSavedFileName=db.getOldToonSavedFileName(detailTitle);
	//지우고자 하는 웹툰 파일과 회차 썸네일 파일의 이름을 가져와서 저장
	ServletContext context=getServletContext();
	String realFolder = context.getRealPath("upload");
	
	File file1=new File(realFolder+File.separator+oldDetailSavedFileName);
	File file2=new File(realFolder+File.separator+oldToonSavedFileName);
	file1.delete();
	file2.delete(); //웹툰 파일과 회차 썸네일 파일 삭제
	db.deleteRecord(detailTitle);//db에서도 삭제

	db.close();
}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}


response.sendRedirect("myHome.jsp"); //삭제 후 홈페이지로 이동
%>
