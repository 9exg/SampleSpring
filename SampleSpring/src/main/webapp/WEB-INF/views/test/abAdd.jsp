<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ab Add</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 350px;
	font-size: 10.5pt;
	text-align: left;
	margin: 20px 20px;
}

tbody tr td {
		border: 1px solid #d7d7d7;
}
td {
	height: 25px;
}
tr td:nth-child(1) {
	background-color: #f2f2f2;
	font-weight: bold;
	text-align: center;
}
tr td:nth-child(2) {
	margin-left: 20px;
}
.button_wrap {
	width: 370px;
	text-align: right;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	
	//취소 버튼 누르면 전 페이지로 이동
	$("#cancelBtn").on("click", function(){
		$("#backForm").submit();
	});
	
	//필수항목 체크
	$("#addBtn").on("click", function() {
		
		if(checkEmpty("#amount")){
			alert("금액을 입력하세요.");
			$("#amount").focus();
		}else if(!$("#type0").is(":checked") && !$("#type1").is(":checked")){
			alert("유형을 입력하세요.");
			$("#type0").focus();
		}else if(checkEmpty("#activeDate")){
			alert("적용일을 입력하세요.");
			$("#activeDate").focus();
		}else if(checkEmpty("#con")){
			alert("내용을 입력하세요.");
			$("#con").focus();
		}else{
			$("#addForm").submit();
		}
	});
});

// 필수항목이 있는지 없는지 확인하는 함수
function checkEmpty(sel){
	if($.trim($(sel).val()) == "" || $.trim($(sel).val()) == null ) {
		return true;
	}else{
		return false;
	}
}

</script>
</head>
<body>
<form action="abList" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
	<input type="hidden" name="searchMon" value="${param.searchMon}" /> 
</form>

<form action="abAdds" id="addForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
	<input type="hidden" name="writer" value="${sMNo}" />
	<table>
		<colgroup>
			<col width=100>
			<col width=250>
		</colgroup>
		<tbody>
			<tr>
				<td>작성자</td>
				<td>&nbsp; ${sMNm}</td>
			</tr>
			<tr>
				<td>유형</td>
				<td>&nbsp;
					<input type="radio" name="type" id="type0" value="0"/><lavel for="type0" >입금</lavel>
		  			<input type="radio" name="type" id="type1" value="1"/><lavel for="type1" >출금</lavel>
				</td>
			</tr>
			<tr>
				<td>금액</td>
				<td>&nbsp; <input type="number" id="amount" name="amount" /></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>&nbsp; <input type="text" id="con" name="con"></td>
			</tr>
			<tr>
				<td>적용일</td>
				<td>&nbsp; <input type="date" id="activeDate" name="activeDate" /></td>
			</tr>
	
		</tbody>
	</table>
	<div class="button_wrap">
		<input type="button" value="작성" id="addBtn" />
		<input type="button" value="취소" id="cancelBtn" />
	</div>
</form>

</body>
</html>