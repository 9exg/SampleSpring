<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>M Login</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//엔터 쳤을 경우 대비
	$("#id, #pw").on("keypress", function(event) {
		if(event.keyCode == 13) {
			$("#loginBtn").click();
			return false;
		}
	});
	
	//로그인 버튼 누를 시
	$("#loginBtn").on("click", function() {
		if(checkEmpty("#id")){
			alert("아이디를 입력하세요.");
			$("#id").focus();
		}else if(checkEmpty("#pw")){
			alert("비밀번호를 입력하세요.");
			$("#pw").focus();
		}else{
			$("#loginForm").submit();
		}		
	});
});

//필수항목 체크 함수
function checkEmpty(sel){
	if($.trim($(sel).val()) == ""){
		return true;
	}else{
		return false;
	}
}
</script>
</head>
<body>
<form action="mLogins" id="loginForm" method="post">
	아이디<input type="text" id="id" name="id" /><br>
	비밀번호<input type="password" id="pw" name="pw" /><br>
	<input type="button" value="로그인" id="loginBtn"/>	
</form>
</body>
</html>