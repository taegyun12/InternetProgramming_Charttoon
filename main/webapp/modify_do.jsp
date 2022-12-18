<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.sql.*, javax.naming.NamingException, java.util.*,java.io.*"%>

<%
request.setCharacterEncoding("utf-8");
//modify.jsp에서 정보들을 받아옴
String idx = request.getParameter("idx");
String title=request.getParameter("title");
String author=request.getParameter("author");
String shorts=request.getParameter("shorts");
String[] sgenre=request.getParameterValues("genre");
String introduce=request.getParameter("introduce");	

String genre ="";
for(int i=0;i<sgenre.length;i++){
	if(i<sgenre.length-1){
		genre=genre+sgenre[i]+", ";
	}
	else{
		genre=genre+sgenre[i];
	}
}

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

Collection<Part> parts = request.getParts(); //파일을 처리하기 위함
MyMultiPart multiPart = new MyMultiPart(parts,realFolder);



try {
	ToonInformationDB db = new ToonInformationDB(); //쿼리문 처리를 위한 객체 생성
	
	String oldSavedFileName=db.getOldSavedFileName(idx); //수정에 필요한 파일의 기존 이름을 가져움
	String oldOriginalFileName=db.getOldOriginalFileName(idx); //수정에 필요한 파일의 기존 이름을 가져옴
	
	ToonInformation toon = new ToonInformation();
	if(multiPart.getMyPart("thumbNail") != null) { //썸네일 파일이 잘 입력되었는지 확인 
		
		
		File oldFile= new File(realFolder+File.separator+oldSavedFileName);
		oldFile.delete();
		
		
		  
		toon.setAuthor(author);	
		toon.setShorts(shorts);
		toon.setTitle(title);
		toon.setIntroduce(introduce);
		toon.setGenre(genre);
		toon.setIdx(Integer.parseInt(idx));
		toon.setOriginalFileName(multiPart.getOriginalFileName("thumbNail"));
		toon.setSavedFileName(multiPart.getSavedFileName("thumbNail"));
		
		
	} else { //입력되지 않았다면 기존의 파일을 유지
		
		toon.setAuthor(author);	
		toon.setShorts(shorts);
		toon.setTitle(title);
		toon.setIntroduce(introduce);
		toon.setGenre(genre);
		toon.setIdx(Integer.parseInt(idx));
		toon.setOriginalFileName(oldOriginalFileName);
		toon.setSavedFileName(oldSavedFileName);
			
		
	}

	
	db.updateRecord(toon); //쿼리문 실행

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