<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AB</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 300px;
	font-size: 10.5pt;
	text-align: center;
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
}
.button_wrap {
	width: 320px;
	text-align: right;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#actionForm").attr("action", "abList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "abUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			$("#actionForm").attr("action", "abDeletes");
			$("#actionForm").submit();
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
	<input type="hidden" name="searchMon" value="${param.searchMon}" /> 
</form>
<table>
	<colgroup>
		<col width=100>
		<col width=200>
	</colgroup>
	<tbody>
		<tr>
			<td>번호</td>
			<td>${data.AB_NO}</td>
		</tr>
		<tr>
			<td>금액</td>
			<td>${data.PRICE}</td>
		</tr>
		<tr>
			<td>유형</td>
			<td>
				<c:choose>
					<c:when test="${data.AB_TYPE eq 0}">
						입금
					</c:when>
					<c:otherwise>
						출금
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${data.AB_CON}</td>
		</tr>
		<tr>
			<td>적용일</td>
			<td>${data.AB_DT}</td>
		</tr>
		<tr>
			<td>등록일</td>
			<td>${data.REG_DT}</td>
		</tr>
	</tbody>
</table>
<div class="button_wrap">
	<input type="button" value="목록으로" id="listBtn"/>
	<c:if test="${data.M_NO eq sMNo}">
		<input type="button" value="수정" id="updateBtn"/>
		<input type="button" value="삭제" id="deleteBtn"/>
	</c:if>
</div>
</body>
</html>