<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,myBean.*, javax.naming.*,java.util.*"%>
    
<%
request.setCharacterEncoding("utf-8");

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
String realFolder =	context.getRealPath("upload");

Collection<Part> parts = request.getParts();
MyMultiPart multiPart =  new MyMultiPart(parts,realFolder);

String originalFileName="";
String savedFileName="";

if(multiPart.getMyPart("thumbNail") != null) {  
	
	originalFileName = multiPart.getOriginalFileName("thumbNail");
	
	
	savedFileName =  multiPart.getSavedFileName("thumbNail");
}

ToonInformation toon = new ToonInformation();  
toon.setAuthor(author);	
toon.setShorts(shorts);
toon.setTitle(title);
toon.setIntroduce(introduce);
toon.setGenre(genre);
toon.setOriginalFileName(originalFileName);
toon.setSavedFileName(savedFileName);


try {
	ToonInformationDB db = new ToonInformationDB();	
	
		db.insertRecord(toon);
		db.close();
}catch(NamingException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

response.sendRedirect("myHome.jsp");

%>