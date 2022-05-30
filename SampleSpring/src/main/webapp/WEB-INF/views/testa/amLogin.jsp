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
			var params = $("#loginForm").serialize();
			
			$.ajax({
				type: "post", 								// 전송 형태
				url : "amLoginAjax", 						//통신 주소
				dataType : "json", 							//받을 데이터 형태
				data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
				success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
					if(res.res == "success") {
						location.href ="atbList" ;
					} else {
						alert("아이디나 비밀번호가 틀립니다.");
					}
				},
				error : function (request, status, error) {	//문제 발생 시 실행 함수
					console.log(request.requestText);		//결과 텍스트
				}
			});
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
<form action="#" id="loginForm" method="post">
	아이디<input type="text" id="id" name="id" /><br>
	비밀번호<input type="password" id="pw" name="pw" /><br>
	<input type="button" value="로그인" id="loginBtn"/>	
</form>
</body>
</html>