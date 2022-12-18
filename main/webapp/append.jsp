<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 회차 정보를 등록시키기 위한 홈페이지 -->
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>웹툰 회차 등록</title>
<script>

function Webtoon(name,th,fi){
	this.title=name;
	this.thumbNail=th;
	this.toonFile=fi;
}

function show(){
	var title=document.getElementsByName("title")[0].value;
	var thumbNail=document.getElementsByName("thumbNail")[0].files[0].name;
	var webtoonFile=document.getElementsByName("webtoonFile")[0].files[0].name;
	var webtoon=new Webtoon(title,thumbNail,webtoonFile);
	var str="";
	for(var i in webtoon){
		str+=(i+" : "+webtoon[i]+"\n");
	}
	alert(str);
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
	font-size:35px;
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
<div class="title"><a id="titleA" href="myHome.jsp">Chart<br>Toon</a></div> <!-- 페이지 제목 -->

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
<div class="blockTitle"> <!-- 바로가기 메뉴 -->
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
<div class="enrollTitle">웹툰 회차 등록하기</div> <!--회차를 등록하기 위해 정보 입력하는 칸-->
<div class="toonInform"></div>
<div class="enrollTable">
<form action="append_do.jsp" method="post" enctype="multipart/form-data">
	웹툰 제목:<input type="text" name="webtoonTitle" value="웹툰 제목를 정확히 입력해주세요" style="width:300px"><br><br> <!-- 웹툰제목이 일치해야 그에 해당하는 웹툰의 회차로 추가될 수 있기 때문 -->
	회차 제목:<input type="text" name="detailTitle" style="width:300px"><br><br><br>
	회차 썸네일:<input type="file" accept="image/jpg,image/gif" name="thumbNail"><br><br><br>
	웹툰 파일:<input type="file" accept="image/jpg,image/gif" name="webtoonFile"><br><br>
	<div>
	<input type="submit" class="informSubmit" value="등 록">
	</div>
</form>
</div>
</section>
</body>
</html>