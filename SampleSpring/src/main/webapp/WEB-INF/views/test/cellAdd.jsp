<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cell Add</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//필수값 체크 후 넘어가는 필터
	$("#addBtn").on("click", function() {
		if(checkEmpty("#addItem")){
			alert("제품명을 입력해 주세요.");
			$("#addItem").focus();
		}else if(checkEmpty("#addNum")){
			alert("수량을 입력해 주세요.");
			$("#addNum").focus();
		}else if(checkEmpty("#regDt")){
			alert("등록일을 입력해 주세요.");
			$("#regDt").focus();
		}else {
			$("#addForm").submit();
		}
	});
	
	
	//필수값 체크
	function checkEmpty(sel){
		if($.trim($(sel).val()) == "") {
			return true;
		}else {
			return false;
		}
	}
});
</head>
<body>
<!-- 뒤로가기용 폼 -->
<form action="cellList" id="backForm" type="post">
	<input type="hidden" name="gbn" value="${param.page}">
</form>

<!-- 등록하기용 폼 (cellAction으로 넘어감) -->
<form action="cellAction" id="addForm" type="post">
	<input type="hidden" name="gbn" value="i">
	제품명 : <input type="text" id="addItem" name="addItem">
	수량 : <input type="text" id="addNum" name="addNum">
	등록일 : <input type="date" id="regDt" name="regDt">
	<input type="button" id="addBtn" value="등록">
	<input type="button" id="cancelBtn" value="취소">
</form>
</body>
</html>