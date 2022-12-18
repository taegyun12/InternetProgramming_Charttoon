<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,myBean.*, javax.naming.*, java.io.*" %>
    
<%
request.setCharacterEncoding("utf-8");		

String idx = request.getParameter("idx");	
	//삭제할 웹툰의 idx값을 detail.jsp로부터 받아옴

try {
	ToonInformationDB db = new ToonInformationDB();

	//객체 생성하고,
	String oldSavedFileName= db.getOldSavedFileName(idx);
	//지우고자 할 파일 이름을 idx값으로부터 받아옴
	ServletContext context=getServletContext();
	String realFolder = context.getRealPath("upload");
	
	File file=new File(realFolder+File.separator+oldSavedFileName);
	file.delete(); //파일 삭제
	
	db.deleteRecord(Integer.parseInt(idx)); //db에서도 삭제
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