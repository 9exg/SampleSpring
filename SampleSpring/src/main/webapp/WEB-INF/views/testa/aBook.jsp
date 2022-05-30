<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A Book</title>
<style type="text/css">
.btn:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function () {
		$("#actionForm").attr("action", "aBookList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "aBookUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type: "post", 								 
				url : "aBookAction/delete",  					 
				dataType : "json", 							 
				data : params,								 
				success : function (res) {					 
					if(res.res == "success"){
						location.href = "aBookList";
					}else{
						alert("삭제중 문제가 발생하였습니다.");						
					}
				},
				error : function (request, status, error) {	//문제 발생 시 실행 함수
					console.log(request.requestText);		//결과 텍스트
				}
			});
			
		}
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
</form>

<h3>상세 보기</h3>
<hr>
책번호 : ${data.BOOK_NO} <br>
책제목 : ${data.BOOK_TITLE} <br>
저자 : ${data.BOOK_AUTHOR} <br>
출판사 : ${data.BOOK_CO} <br>
출판일 : ${data.BOOK_DT} <br>
등록일 : ${data.REG_DT} <br>
<br>
<input type="button" value="목록으로" id="listBtn" class="btn" />
<input type="button" value="수정" id="updateBtn" class="btn" />
<input type="button" value="삭제" id="deleteBtn" class="btn" />
</body>
</html>