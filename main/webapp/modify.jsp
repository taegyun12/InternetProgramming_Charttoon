<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.*, java.sql.*, javax.naming.*"%>
<!DOCTYPE html>
<html>
<head>
<%
String idx = request.getParameter("idx"); //수정할 파일의 idx값을 가져옴			
try {
	//수정에 필요한 자바빈즈 객체를 생성
	ToonInformationDB db = new ToonInformationDB();
	ToonInformation toon = db.getRecord(Integer.parseInt(idx));	 
%>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹툰 등록</title>
<script>
function Cartoon(title,author,thumbNail,genre,shorts,introduce){
	this.title=title;
	this.author=author;
	this.thumbNail=thumbNail;
	this.genre=genre;
	this.shorts=shorts;
	this.introduce=introduce;
}

function show(){
	var title=document.getElementsByName("title")[0].value;
	var author=document.getElementsByName("author")[0].value;
	var thumbNail=document.getElementsByName("thumbNail")[0].files[0].name;
	var genreArr=document.getElementsByName("genre");
	var str="";
	for(var j in genreArr){
		if(genreArr[j].checked){
			str+=genreArr[j].value+", ";
		}
	}
	var genre=str;
	
	var shorts=document.getElementsByName("shorts")[0].value;
	var introduce=document.getElementsByName("introduce")[0].value;
	var cartoon=new Cartoon(title,author,thumbNail,genre,shorts,introduce);
	var total="";
	for(var i in cartoon){
		total+=(i+" : "+cartoon[i]+"\n");
	}
	alert(total);
}
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
<div class="enrollTitle">웹툰 정보 수정하기</div>
<div class="toonInform"></div>
<div class="enrollTable"> 
<!-- 사용자가 수정을 할 때 기존의 정보를 알면 더 편하기 때문에 기존의 정보를 DB에서 가져와 사용자에게 출력함 -->
<form action="modify_do.jsp?idx=<%= idx%>" method="post" enctype="multipart/form-data">
	제목:<input type="text" name="title" value="<%=toon.getTitle()%>"><br>
	작가명:<input type="text" name="author" value="<%=toon.getAuthor()%>"><br>
	웹툰 썸네일:<img src="./upload/<%= toon.getSavedFileName()%>" width="50" height="50" >
	<input type="file" accept="image/jpg,image/gif" name="thumbNail"><br>
	장르:<input type="checkbox" name="genre" value="daily" checked>일상
	<input type="checkbox" name="genre" value="gag">개그
	<input type="checkbox" name="genre" value="fantasy" >판타지
	<input type="checkbox" name="genre" value="action" checked>액션
	<input type="checkbox" name="genre" value="drama">드라마
	<input type="checkbox" name="genre" value="romance">로맨스
	<input type="checkbox" name="genre" value="thriller">스릴러
	<input type="checkbox" name="genre" value="sports">스포츠
	<input type="checkbox" name="genre" value="history">무협,사극<br>
	<div>
	줄거리<br>
	<input type="text" name="shorts" value="<%=toon.getShorts()%>" style="height:85px; width:650px;font-size:10px;"><br>
	</div>
	<div>
	작가의 소개글<br>
	<input type="text" name="introduce" value="<%=toon.getIntroduce()%>" style="height:85px; width:650px;font-size:10px;"><br>
	</div>
	<div>
	<input type="submit" class="informSubmit" value="등 록">
	</div>
</form> <!-- 입력된 정보를 modify_do.jsp로 넘김 -->
</div>
</section>
</body>
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
</html>