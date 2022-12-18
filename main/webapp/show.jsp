<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.sql.*, javax.naming.*"%>
    
<!DOCTYPE html>
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
	width:50%;
}
div.title{ /*ChartToon 타이틀 설정*/
	font-size:80px;
	font-family:Snap ITC;
	text-align:center;
	position:absolute;
	top:30px;
	left:80px;
}

img.toon{
	position:absolute;
	top:280px;
	left:480px;
	
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

div.Search{ /*검색창*/
	border:5px solid #569599;
	font-size:25px;
	width:350px;
	background-color:#e6e6e6;
	border-radius: 20px;
	height:75px;
	display:inline-block;
	position:absolute;
	left:1250px;
	top:150px;
	font-family:휴먼매직체;
}

#toonboxNum{ /*순위 번호표시*/
	border:5px solid orange;
	font-size:25px;
	width:30px;
	height:30px;
	font-family:Snap ITC;
	outline:5px;
	position:absolute;
	text-align:center;
	background-color:white;
}

div.toonBox{ /*웹툰 사진 들어가는 곳*/
	border:5px solid black;
	width:180px;
	height:180px;
	outline:5px;
	position:absolute;
	text-align:enter;
	cursor: pointer;
}

a.toontitle{ /*웹툰 제목 들어가는 곳*/
	position:absolute;
	text-align:enter;
	cursor: pointer;
	text-align:center;
	font-family:휴먼매직체;
	font-size:25px;
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
	font-size:50px;
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
<div class="userInform">
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

    String detailTitle = request.getParameter("detailTitle");	//해당 회차의 detailTitle을 매개변수로 받아옴
    
    String query = "select detailTitle, toonSavedFileName, webtoonTitle from detailList where detailTitle= '"+detailTitle+"'"; //해당 회차의 웹툰 파일을 받아옴 
    rs = stmt.executeQuery(query);
    
	rs.next();
%>
<section>
<input type="button" value="회차 리스트로 돌아가기"
		onclick="location.href='detail_list.jsp?webtoonTitle=<%= rs.getString("webtoonTitle")%>'"
			style="position:absolute; top:220px; left:480px;"> <!-- 해당 웹툰의 회차로 돌아가는 버튼 -->
<div class="enrollTitle">회차 제목: <%= rs.getString("detailTitle") %></div> <!-- 회차의 제목을 출력함 -->
<div class="rankTable"></div>
<img class="toon" src="./upload/<%= rs.getString("toonSavedFileName")%>" > <!-- 해당 회차의 이미지 파일 출력 -->
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