<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATB Write</title>
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
		// instance[이름] : 해당 이름으로 CKEDITOR객체 취득
		// getData() : 입력된 데이터 취득
		if(checkEmpty("#itemName")){
			alert("상품명을 입력하세요.");
			$("#itemName").focus();
		}else if(checkEmpty("#sellCnt")){
			alert("수량을 입력하세요.");
			$("#sellCnt").focus();
		}else if(checkEmpty("#sellDt")){
			alert("등록일을 입력하세요.");
			$("#sellDt").focus();
		}else{
			var params = $("#writeForm").serialize();
			
			$.ajax({
				type: "post", 								// 전송 형태
				url : "aSellAction/insert", 					//통신 주소
				dataType : "json", 							//받을 데이터 형태
				data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
				success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
					if(res.res == "success"){
						location.href = "aSellList";
					}else{
						alert("작성중 문제가 발생하였습니다.");						
					}
				},
				error : function (request, status, error) {	//문제 발생 시 실행 함수
					console.log(request.requestText);		//결과 텍스트
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
<form action="aSellList" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
</form>

<form action="#" id="writeForm" method="post">
상품명<input type="text" id="itemName" name="itemName" /><br/>
수량<input type="text" id="sellCnt" name="sellCnt" /><br/>
등록일<input type="date" id="sellDt" name="sellDt" /><br/>
<input type="button" value="작성" id="writeBtn" />
<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>