<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>M Add</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#cancelBtn").on("click", function() {
		history.back();
	});
	
	$("#addBtn").on("click", function() {
		if(checkEmpty("#id")){
			alert("아이디를 입력하세요.");
			$("#id").focus();
		}else if(checkEmpty("#pw")){
			alert("비밀번호를 입력하세요.");
			$("#pw").focus();
		}else if(checkEmpty("#name")){
			alert("이름을 입력하세요.");
			$("#name").focus();
		}else{
			$("#addForm").submit();
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
<form action="mAdds" id="addForm" method="post">
	아이디<input type="text" id="id" name="id" /><br>
	비밀번호<input type="text" id="pw" name="pw" /><br>
	이름<input type="text" id="name" name="name" /><br>
</form>
<input type="button" id="addBtn" value="추가"/>
<input type="button" id="cancelBtn" value="취소"/>
</body>
</html>