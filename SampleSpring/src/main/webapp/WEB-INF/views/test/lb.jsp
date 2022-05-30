<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lb</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function () {
		$("#actionform").attr("action", "lbList");
		$("#actionform").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionform").attr("action", "lbUpdate");
		$("#actionform").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			$("#actionform").attr("action", "lbDeletes");
			$("#actionform").submit();
		}
	});
});
</script>
</head>
<body>
<form action="#" id="actionform" method="post">
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
<input type="button" value="목록으로" id="listBtn"/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
</body>
</html>