<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.sql.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹툰 세부 정보</title>
<script>

</script>
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
button.option{
display:inline-block;
	letter-spacing:0.2em;
	padding: 0.5px;
	border-radius: 15px;
	font-size:1.3em;
	color:black;
	background-color:#ffe6cc;
	border:2px solid;
	outline: 2px;
	cursor:pointer;
	font-family:휴먼매직체;
}
#titleA:hover{
	color:black;
}
div.userInform{ /*검색창 */
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

div.enrollTitle{ /*웹툰 등록하기 타이틀*/
	font-size:100px;
	text-align:center;
	position:absolute;
	font-family:휴먼매직체;
	color:black;
	top:140px;
	left:500px;
}

div.toonInform{ /*웹툰 등록 박스 태그*/
	border:5px solid #569599;
	font-size:25px;
	width:1200px;
	font-family:Snap ITC;
	background-color:#e6e6e6;
	border-radius: 20px;
	height:550px;
	display:inline-block;
	position:absolute;
	left:450px;
	top:300px;
}

div.enrollTable{
	font-size:25px;
	font-family:휴먼매직체;
	position:absolute;
	left:480px;
	top:330px;
	line-height:50px;
	
}

input.informSubmit{ /*등록 버튼*/
	letter-spacing:0.2em;
	padding: 0.5px;
	border-radius: 10px;
	color:black;
	background-color:#ffe6cc;
	border:5px solid;
	outline: 2px;
	cursor:pointer;
	font-family:휴먼매직체;
	position:absolute;
	left:950px;
	top:450px;
	font-size:30px;
	height:50px;
	width:100px;
}
</style>
</head>


<body style="background-color:#D1E8E3;">
<%
String idx = request.getParameter("idx"); //제목을 클릭할 시 idx값을 가져옴			
try {
	ToonInformationDB db = new ToonInformationDB();
	ToonInformation toon = db.getRecord(Integer.parseInt(idx));	  
%>
<div class="title"><a id="titleA" href="myHome.jsp">Chart<br>Toon</a></div> 

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
<section>
<div class="enrollTitle">웹툰 상세 정보</div> <!-- 웹툰의 세부정보를 나타내는 곳 -->
<div class="toonInform"></div>
<div class="enrollTable">
제목: <%=toon.getTitle() %> <br>
썸네일: <img src="./upload/<%= toon.getSavedFileName()%>" width="50" height="50" ><br>
저자: <%=toon.getAuthor() %> <br>
장르: <%=toon.getGenre() %> <br>
줄거리: <%=toon.getShorts() %> <br>
소개말: <%=toon.getIntroduce() %>
</div>
<button class ="option"type="submit"style="position:absolute; top:700px; left:1500px; 
		cursor: pointer;"onclick="location.href='modify.jsp?idx=<%= idx%>';">
	수정</button> <!-- 수정 페이지로 이동하면서 idx값을 넘겨줌 -->
	<button type="submit"class ="option"style="position:absolute; top:750px; left:1500px; 
		cursor: pointer;"onclick="location.href='delete_do.jsp?idx=<%= idx%>';">
	삭제</button> <!-- 삭제를 하면서 삭제를 수행하는 jsp파일에 idx값을 넘겨줌 -->
	<button type="submit"class ="option"style="position:absolute; top:800px; left:1500px; 
		cursor: pointer;"onclick="location.href='detail_list.jsp?webtoonTitle=<%= toon.getTitle()%>';">
	회차 보기</button> <!-- 회차를 보기위한 페이지로 넘어가면서 webtoontitle 값을 넘겨줌 -->
</section>
<%
	db.close();

}catch(SQLException e) {
	out.print(e);
	return;
}catch(NamingException e) {
	out.print(e);
	return;
}
%>
</body>
</html>