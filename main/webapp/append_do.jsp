<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,myBean.*, javax.naming.*,java.util.*"%>
<%
//회차 정보를 등록시키는 jsp파일
request.setCharacterEncoding("utf-8");
//append.jsp에서 매개변수 두개 받기
String webtoonTitle=request.getParameter("webtoonTitle");
String detailTitle=request.getParameter("detailTitle");

ServletContext context = getServletContext();
String realFolder =	context.getRealPath("upload");
//파일 업로드 준비
Collection<Part> parts = request.getParts();
MyMultiPart multiPart =  new MyMultiPart(parts,realFolder);

String detailOriginalFileName="";
String detailSavedFileName="";
String toonOriginalFileName="";
String toonSavedFileName="";

if((multiPart.getMyPart("thumbNail") != null) && (multiPart.getMyPart("webtoonFile") != null)) {  

	detailOriginalFileName = multiPart.getOriginalFileName("thumbNail"); //회차 썸네일
	
	
	detailSavedFileName =  multiPart.getSavedFileName("thumbNail"); //저장할 회차 썸네일 이름
	
	toonOriginalFileName = multiPart.getOriginalFileName("webtoonFile"); //웹툰 파일
	

	toonSavedFileName =  multiPart.getSavedFileName("webtoonFile"); //저장할 웹툰 파일 이름
}

DetailInformation detail = new DetailInformation();  //자바빈즈를 활용하여 detail에 웹툰 회차 정보를 저장
detail.setWebtoonTitle(webtoonTitle);	
detail.setDetailTitle(detailTitle);
detail.setDetailOriginalFileName(detailOriginalFileName);
detail.setDetailSavedFileName(detailSavedFileName);
detail.setToonOriginalFileName(toonOriginalFileName);
detail.setToonSavedFileName(toonSavedFileName);



try {
	DetailInformationDB db = new DetailInformationDB();	
	
		db.insertRecord(detail);
		db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

response.sendRedirect("myHome.jsp"); //다 처리 후 바탕화면으로 넘김

%>