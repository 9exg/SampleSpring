<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	$("#sendBtn").on("click", function () {
		// sereialize : 전송될 데이터들을 문자열로 변환
		var params = $("#actionForm").serialize();
	
		console.log(params);
		
		$.ajax({
			type: "post", 								// 전송 형태
			url : "testa1Ajax", 						//통신 주소
			dataType : "json", 							//받을 데이터 형태
			data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
			success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
				console.log(res);
				$("body").append(res.msg);
			},
			error : function (request, status, error) {	//문제 발생 시 실행 함수
				console.log(request.requestText);		//결과 텍스트
				console.log(status);					//상태 코드
				console.log(error);						//에러 메시지
			}
		});
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="text" name="msg" />
	<input type="button" value="전송" id="sendBtn" />
</form>
</body>
</html>