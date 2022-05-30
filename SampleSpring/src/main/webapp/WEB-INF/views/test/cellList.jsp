<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cell List</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//페이징
	$("#pagingWrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#actionForm").attr("action", "cellList");
		$("#actionForm").submit();
	});
});
</script>
</head>
<body>

<!-- 페이징용 폼 태그 -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="no" id="no" />
	<input type="hidden" name="page" id="page" value="${page}"/>
</form>

<!-- head -->
<h2>  Cell List  </h2>
총 (${cnt}) 개의 글
<hr/>

<!-- 작성 -->
<input type="button" value="작성">
<br/>

<!-- search -->
<select id="searchGbn">
	<option value="0">제품명</option>
	<option value="1">제품번호</option>
</select>
<input type="text" id="searchTxt" />
<input type="button" value="검색" id="searchBtn"/>
<br/>
<br/>

<!-- list table -->
<table>
	<thead>
		<tr>
			<td>제품번호</td>
			<td>제품명</td>
			<td>수량</td>
			<td>등록일</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr>
				<td>${data.SELL_NO}</td>
				<td>${data.ITEM_NAME}</td>
				<td>${data.COUNT}</td>
				<td>${data.SELL_DT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- paging -->
<div id="pagingWrap">
	<span page="1">처음</span>
	<c:choose>
		<c:when test="${page eq 1}">
			<span page="1">이전</span>
		</c:when>
		<c:otherwise>
			<span page="${page - 1}">이전</span>
		</c:otherwise>
	</c:choose>
	<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
		<c:choose>
			<c:when test="${page eq i}">
				<span page="${i}"><b>${i}</b></span>
			</c:when>
			<c:otherwise>
				<span page="${i}">${i}</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${page eq pb.maxPcount}">
			<span page="${pb.maxPcount}">다음</span>
		</c:when>
		<c:otherwise>
			<span page="${page + 1}">다음</span>
		</c:otherwise>
	</c:choose>
	<span page="${pb.maxPcount}">마지막</span>
</div>

</body>
</html>