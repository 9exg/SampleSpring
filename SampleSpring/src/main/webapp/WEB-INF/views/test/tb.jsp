<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tb</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#actionForm").attr("action", "tbList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "tbUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			$("#actionForm").attr("action", "tbDeletes");
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
</form>
번호: ${data.TB_NO} <br/>
제목: ${data.TB_TITLE} <br/>
작성자: ${data.M_NM}<br/>
작성일: ${data.TB_DT}<br/>
조회수: ${data.TB_HIT}<br/>
- 내용 -<br/>
${data.TB_CON} <br/>
<input type="button" value="목록으로" id="listBtn"/>
<c:if test="${data.TB_WRITER eq sMNo}">
	<input type="button" value="수정" id="updateBtn"/>
	<input type="button" value="삭제" id="deleteBtn"/>
</c:if>
</body>
</html>