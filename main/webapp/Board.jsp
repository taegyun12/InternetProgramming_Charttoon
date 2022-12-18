<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.sql.*, javax.naming.*"%>
    
<!DOCTYPE html>
<!-- 웹툰 전체 리스트를 보는 게시판 -->
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>회자 목록</title>
<style>
table.detailTable{
	border-collapse:collapse;
	text-align:center;
	position:absolute;
	top:300px;
	left:500px;
	width:60%;
}
div.title{ /*ChartToon 타이틀 설정*/
	font-size:80px;
	font-family:Snap ITC;
	text-align:center;
	position:absolute;
	top:30px;
	left:80px;
}
#titleA{ /* 타이틀 a태그 밑줄 삭제*/
	text-decoration:none; 
		color:#5765BD;
}
#titleA:hover{
	color:black;
}

div.userInform{ /*검색창*/
	border:5px solid #569599;
	font-size:25px;
	width:250px;
	font-family:휴먼매직체;
	background-color:#e6e6e6;
	border-radius: 20px;
	height:220px;
	display:inline-block;
	position:absolute;
	left:90px;
	top:260px;

}


div.userInform input{ 
	position:relative;
	left:20px;
}

div.blockTitle{ /*바로가기 메뉴 타이틀*/
	border:0px;
	font-size:50px;
	width:400px;
	font-family:휴먼매직체;
	height:50px;
	position:absolute;
	left:20px;
	top:500px;
	text-align:center;
}

div.toGoBlock{ /*바로가기 메뉴 박스*/
	border:5px solid #569599;
	font-size:40px;
	width:300px;
	font-family:휴먼매직체;
	background-color:#e6e6e6;
	border-radius: 20px;
	height:50px;
	position:absolute;
	left:68px;
	text-align:center;
	cursor: pointer;
}
div.toGoBlock:hover{
	background-color:#999999;
	color:white;
}


div.rankTable{ /*웹툰 랭크 테이블 박스 태그*/
	border:5px solid #569599;
	font-size:25px;
	width:1200px;
	font-family:Snap ITC;
	background-color:#e6e6e6;
	border-radius: 20px;
	height:630px;
	display:inline-block;
	position:absolute;
	left:460px;
	top:250px;
}
div.enrollTitle{ /*웹툰 랭크 테이블 타이틀*/
	font-size:100px;
	text-align:center;
	position:absolute;
	font-family:휴먼매직체;
	color:black;
	top:140px;
	left:500px;
}
</style>
</head>

<body style="background-color:#D1E8E3;">
<header>
<div class="title"><a id="titleA" href="myHome.jsp">Chart<br>Toon</a></div> 

</header>
<nav>
<div class="userInform"> <!-- 검색창 -->
<form action="searchTitle.jsp" method="get"> 
<fieldset>
<legend>제목검색</legend>
<label for="title">제목:</label>
<input type="text" name="title" style="width:120px"><br>
<button type="submit"style="position:absolute; cursor: pointer;">
	제목 검색</button>
</fieldset>
</form>
<br>
<form action="searchAuthor.jsp" method="get">
<fieldset>
<legend>작가검색</legend>
<label for="author">작가명:</label>
<input type="text" name="author" style="width:110px"><br>
<button type="submit"style="position:absolute; cursor: pointer;">
	작가 검색</button>
</fieldset>
</form>
</div>
<div class="blockTitle">
-바로가기 메뉴-
</div>
<div class="toGoBlock" style="top:570px;" onclick="location.href='Board.jsp';">
웹툰 전체 리스트
</div>
<div class="toGoBlock" style="top:645px;" onclick="location.href='Enroll.jsp';">
웹툰 등록하기
</div>
<div class="toGoBlock" style="top:720px;" onclick="location.href='append.jsp';">
회차 등록하기
</div>
</nav>
<%

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
		

String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con= null;
Statement stmt = null;
ResultSet rs   = null;

try {
    
    con =  DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

    
    stmt = con.createStatement();
    
    String query = "select idx,title,genre,author,savedFileName from webtoonList"; 
    rs = stmt.executeQuery(query);
	//웹툰 리스트의 모든 웹툰의 정보를 가져옴
%>
<section>
<div class="enrollTitle">웹툰 리스트</div>
<div class="rankTable"></div>
<table border="1" class="detailTable">
<tr style="background-color:#dddddd">
	<th>썸네일</th>
	<th>제목</th>
	<th width="30%">장르</th>
	<th width="14%">저자</th>
</tr>
<%
    while(rs.next()) { //하나씩 정보 가져옴
    	//talbe 형식으로 출력
%><tr>
<td><img src="./upload/<%= rs.getString("savedFileName")%>" width="50" height="50" ></td>
<td  style="cursor:pointer;" onclick="location.href='detail.jsp?idx=<%= rs.getInt("idx")%>'"> <%=rs.getString("title") %> </td>
<td><%=rs.getString("genre") %></td>
<td><%=rs.getString("author") %></td>

</tr>
<%
    } 
%></table>
</section>
<%
 	
	rs.close();     

    stmt.close();    

    con.close(); 	

} catch (SQLException e) {
      out.println("err:"+e.toString());
      return;
} 
%>
</body>
</html>