<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TB Write</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("con", {
		//옵션
		resize_enabled: false, //크기변경
		language : "ko",	//언어
		enterMode : 2,	//엔터 <br/> 처리
		width : "700",	//가로
		height : "300"	//세로
	});
	
	//취소 버튼 누르면 전 페이지로 이동
	$("#cancelBtn").on("click", function(){
		$("#backForm").submit();
	});
	
	//필수항목 체크
	$("#writeBtn").on("click", function() {
		// instance[이름] : 해당 이름으로 CKEDITOR객체 취득
		// getData() : 입력된 데이터 취득
		$("#con").val(CKEDITOR.instances['con'].getData());
		if(checkEmpty("#title")){
			alert("제목을 입력하세요.");
			$("#title").focus();
		}else if(checkEmpty("#con")){
			alert("내용을 입력하세요.");
			$("#con").focus();
		}else{
			$("#writeForm").submit();
		}
	});
});

// 필수항목이 있는지 없는지 확인하는 함수
function checkEmpty(sel){
	if($.trim($(sel).val()) == "") {
		return true;
	}else{
		return false;
	}
}

</script>
</head>
<body>
<form action="tbList" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
</form>

<form action="tbWrites" id="writeForm" method="post">
제목<input type="text" id="title" name="title" /><br/>
작성자 : ${sMNm}<input type="hidden" name="writer" value="${sMNo}" /><br/>
내용<br/>
<textarea rows="20" cols="50" id="con" name="con"></textarea><br/>
<input type="button" value="작성" id="writeBtn" />
<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>