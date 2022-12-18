<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.io.*, java.sql.*, javax.naming.NamingException, java.util.*"%>

<%
//detail_modify.jsp로 부터 수정하고자 하는 회차의 정보를 가져옴
request.setCharacterEncoding("utf-8");
String oldDetailTitle = request.getParameter("oldDetailTitle"); //기존의 회차 제목
String detailTitle=request.getParameter("detailTitle"); //수정된 회차 제목
String webtoonTitle=request.getParameter("webtoonTitle");
	


ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts(); //새로운 파일을 가져옴
MyMultiPart multiPart = new MyMultiPart(parts,realFolder);
%>

<%
try {
	
	DetailInformationDB db = new DetailInformationDB();
	//객체를 만들고
	String oldDetailSavedFileName=db.getOldDetailSavedFileName(oldDetailTitle);
	String oldDetailOriginalFileName=db.getOldDetailOriginalFileName(oldDetailTitle);
	//기존의 썸네일 파일 정보
	String oldToonSavedFileName=db.getOldToonSavedFileName(oldDetailTitle);
	String oldToonOriginalFileName=db.getOldToonOriginalFileName(oldDetailTitle);
	//기존의 웹툰 파일 정보를 가져옴
	DetailInformation detail=new DetailInformation();
	// 새로운 객체를 생성
	if(multiPart.getMyPart("thumbNail") != null && multiPart.getMyPart("webtoonFile") != null) { 
		//새로운 썸네일 파일과 웹툰파일을 사용자가 업로드하면
		
		File oldFile1= new File(realFolder+File.separator+oldDetailSavedFileName);
		File oldFile2= new File(realFolder+File.separator+oldToonSavedFileName);
	
		oldFile1.delete();
		oldFile2.delete();
		//기존의 파일을 지우고
		
		detail.setWebtoonTitle(webtoonTitle);
		detail.setDetailTitle(detailTitle);	
		detail.setDetailOriginalFileName(multiPart.getOriginalFileName("thumbNail"));
		detail.setDetailSavedFileName(multiPart.getSavedFileName("thumbNail"));
		detail.setToonOriginalFileName(multiPart.getOriginalFileName("webtoonFile"));
		detail.setToonSavedFileName(multiPart.getSavedFileName("webtoonFile"));
		//새로운 정보를 바탕으로 새로운 객체의 정보를 채움
	}else if(multiPart.getMyPart("thumbNail") == null && multiPart.getMyPart("webtoonFile") != null){
		//만약 웹툰 파일만 업로드되면
		File oldFile2= new File(realFolder+File.separator+oldToonSavedFileName);
		
		
		oldFile2.delete();
		//기존의 웹툰 파일만 삭제
		
		detail.setWebtoonTitle(webtoonTitle);
		detail.setDetailTitle(detailTitle);	
		detail.setDetailOriginalFileName(oldDetailOriginalFileName);
		detail.setDetailSavedFileName(oldDetailSavedFileName);
		detail.setToonOriginalFileName(multiPart.getOriginalFileName("webtoonFile"));
		detail.setToonSavedFileName(multiPart.getSavedFileName("webtoonFile"));
		//새로운 정보를 바탕으로 새로운 객체의 정보를 채움
	}else if(multiPart.getMyPart("thumbNail") != null && multiPart.getMyPart("webtoonFile") == null){
		File oldFile1= new File(realFolder+File.separator+oldDetailSavedFileName);
		//만약 썸네일 파일만 업로드되면
		oldFile1.delete();
		//기존의 썸네일 파일만 삭제
		
		detail.setWebtoonTitle(webtoonTitle);
		detail.setDetailTitle(detailTitle);	
		detail.setDetailOriginalFileName(multiPart.getOriginalFileName("thumbNail"));
		detail.setDetailSavedFileName(multiPart.getSavedFileName("thumbNail"));
		detail.setToonOriginalFileName(oldToonOriginalFileName);
		detail.setToonSavedFileName(oldToonSavedFileName);
		//새로운 정보를 바탕으로 새로운 객체의 정보를 채움
	}else { 
		//새로운 파일을 사용자가 업로드 하지 않으면
		detail.setWebtoonTitle(webtoonTitle);
		detail.setDetailTitle(detailTitle);	
		detail.setDetailOriginalFileName(oldDetailOriginalFileName);
		detail.setDetailSavedFileName(oldDetailSavedFileName);
		detail.setToonOriginalFileName(oldToonOriginalFileName);
		detail.setToonSavedFileName(oldToonSavedFileName);
		//기존의 파일정보와 새로운 입력값들을 이용하여 객체 정보를 채움
	}
	
	
	db.updateRecord(detail,oldDetailTitle);
	//db에서 정보 업데이트
	db.close();	
}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}
response.sendRedirect("myHome.jsp");

%>