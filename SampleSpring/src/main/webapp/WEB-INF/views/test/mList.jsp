<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>M List</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#addBtn").on("click", function(){
		$("#addForm").submit();
	});
});
</script>
</head>
<body>
<form action="mAdd" id="addForm" method="post">
<input type="button" id="addBtn" value="등록"/> 
<br/>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr no="${data.M_NO}">
				<td>${data.M_NO}</td>
				<td>${data.M_ID}</td>
				<td>${data.M_PW}</td>
				<td>${data.M_NM}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
</body>
</html>