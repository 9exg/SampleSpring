<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A Sell</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#actionForm").attr("action", "aSellList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "aSellUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type: "post", 								// 전송 형태
				url : "aSellAction/delete", 					//통신 주소
				dataType : "json", 							//받을 데이터 형태
				data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
				success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
					if(res.res == "success"){
						location.href = "aSellList";
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
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
</form>
상품번호: ${data.SELL_NO} <br/>
상품명: ${data.ITEM_NAME} <br/>
수량: ${data.COUNT}<br/>
등록일: ${data.SELL_DT}<br/>
<input type="button" value="목록으로" id="listBtn"/>
<input type="button" value="수정" id="updateBtn"/>
<input type="button" value="삭제" id="deleteBtn"/>
</body>
</html>