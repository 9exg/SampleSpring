<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TB Update</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	//취소 버튼 누르면 전 페이지로 이동
	$("#cancelBtn").on("click", function(){
		$("#backForm").submit();
	});
	
	//필수항목 체크
	$("#updateBtn").on("click", function() {
		if(checkEmpty("#book_title")){
			alert("책 제목을 입력하세요.");
			$("#book_title").focus();
		}else if(checkEmpty("#book_author")){
			alert("저자를 입력하세요.");
			$("#book_author").focus();
		}else if(checkEmpty("#book_co")){
			alert("출판사를 입력하세요.");
			$("#book_co").focus();
		}else if(checkEmpty("#book_dt")){
			alert("출판일을 입력하세요.");
			$("#book_dt").focus();
		}else{
			$("#updateForm").submit();
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
<!-- 뒤로가기 -->
<form action="lb" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
</form>

<!-- Updates로 가기 -->
<form action="lbUpdates" id="updateForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	
	책번호: ${data.BOOK_NO}<br/>
	책제목<input type="text" id="book_title" name="book_title" value="${data.BOOK_TITLE}" /><br/>
	저자<input type="text" id="book_author" name="book_author" value="${data.BOOK_AUTHOR}" /><br/>
	출판사<input type="text" id="book_co" name="book_co" value="${data.BOOK_CO}" /><br/>
	출판일<input type="date" id="book_dt" name="book_dt" value="${data.BOOK_DT}" /><br/> 
	<br/>
	<input type="button" value="수정" id="updateBtn" />
	<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>