<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LB Write</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	
	//취소 버튼 누르면 전 페이지로 이동
	$("#cancelBtn").on("click", function(){
		$("#backForm").submit();
	});
	
	//필수항목 체크
	$("#writeBtn").on("click", function() {
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
			var params = $("#writeForm").serialize();
			
			$.ajax({
				type: "post", 								
				url : "aBookAction/insert", 			  
				dataType : "json", 							
				data : params,								
				success : function (res) {					
					if(res.res == "success"){
						location.href = "aBookList";
					}else{
						alert("작성중 문제가 발생하였습니다.");						
					}
				},
				error : function (request, status, error) {
					console.log(request.requestText);		
				}
			});
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
<h3>등록 하기</h3>
<hr>
<!-- 뒤로가기 -->
<form action="aBookList" id="backForm" method="post"> 
		<input type="hidden" name="no" value="${param.no}" />
		<input type="hidden" name="page" value="${param.page}" />
</form>

<!-- writes로 가기 -->
<form action="#" id="writeForm" method="post">
	책제목<input type="text" id="book_title" name="book_title" /><br/>
	저자<input type="text" id="book_author" name="book_author" /><br/>
	출판사<input type="text" id="book_co" name="book_co" /><br/>
	출판일<input type="date" id="book_dt" name="book_dt" /><br/> 
	<br/>
	<input type="button" value="작성" id="writeBtn" />
	<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>