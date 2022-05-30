<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> LB Update </title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	switch('${res}') {
	case "success" :
		$("#actionform").submit();
		break;
	case "failed" :
		alert("수정에 실패하였습니다.");
		history.back();
		break;
	case "error" :
		alert("수정중 문제가 발생하였습니다.");
		history.back();
		break;
	}
});
</script>
</head>
<body>
<form action="lb" id="actionform" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
</form>
</body>
</html>