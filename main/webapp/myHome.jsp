<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chart Toon!</title>
<style>
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
div.toGoBlock:hover{ /*바로가기 메뉴 박스*/
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
<div class="title"><a id="titleA" href="myHome.jsp">Chart<br>Toon</a></div> <!-- 페이지 타이틀 -->

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

<div class="blockTitle"> <!-- 바로가기 메뉴판  -->
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
ResultSet rs1   = null;
ResultSet rs2   = null;

try {
    
    con =  DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);

    
    stmt = con.createStatement();

    String query1 = "SELECT idx, title, savedFileName FROM webtoonList LIMIT "+ 4*k + ",4"; //webtoonList 테이블에 있는 상위 4개의 웹툰 정보를 가져옴
    String query2 = "SELECT idx, title, savedFileName FROM webtoonList LIMIT "+ 4*(k+1) + ",4"; //webtoonList 테이블에 있는 5~8까지의 웹툰 정보를 가져옴
    rs1 = stmt.executeQuery(query1);
    rs2 = stmt.executeQuery(query2);

%>
<section>
<div class="enrollTitle">이번주 전체 top8</div>
<div class="rankTable"></div>
<div id="toonboxNum" style="top:280px;left:500px;">1</div>
<div id="toonboxNum" style="top:280px;left:800px;">2</div>
<div id="toonboxNum" style="top:280px;left:1100px;">3</div>
<div id="toonboxNum" style="top:280px;left:1400px;">4</div>
<div id="toonboxNum" style="top:580px;left:500px;">5</div>
<div id="toonboxNum" style="top:580px;left:800px;">6</div>
<div id="toonboxNum" style="top:580px;left:1100px;">7</div>
<div id="toonboxNum" style="top:580px;left:1400px;">8</div>

<%!  static int k=0; %>
<%
	int i=0;
	int j=0;
    while(rs1.next()) {
    	
%>
<!-- 반복문을 통해 화면에 배치 -->
<a class="toontitle" style="top:530px;left:<%= 575+300*i%>px;" href="detail.jsp?idx=<%= rs1.getInt("idx")%>"><%=rs1.getString("title")%></a>

	<img style="top:330px;left:<%= 550+(300*i)%>px;position:absolute" src="./upload/<%=rs1.getString("savedFileName") %>" width="120" height="160" >
<%
    	i=i+1;
    }
%>
<!-- 반복문을 통해 화면에 배치 -->
<% 
    while(rs2.next()) {
    	
%>
<a class="toontitle" style="top:830px;left:<%= 575+(300*j)%>px;" href="detail.jsp?idx=<%= rs2.getInt("idx")%>"><%=rs2.getString("title")%></a>

	<img style="top:630px;left:<%= 550+(300*j)%>px;position:absolute" src="./upload/<%=rs2.getString("savedFileName") %>" width="120" height="160">
<%
		j++;
    } 
%>
<%

	rs1.close();   
	rs2.close(); 
    stmt.close();     

    con.close(); 	

} catch (SQLException e) {
      out.println("err:"+e.toString());
      return;
} 
%>



</section>
</body>
</html>