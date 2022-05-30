<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lb List</title>
<style type="text/css">
#paging_wrap {
	width : 400px;
	text-align: center;
}
.table_wrap {
	width : 400px;
	height : 350px;
}
table {
	width : 400px;
	text-align: center;
	margin : 20px auto;
}

</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("tbody").on("click", "tr", function(){
		$("#no").val($(this).attr("no"));
		
		$("#actionform").attr("action", "lb");
		$("#actionform").submit();
	});
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
	
		$("#actionform").attr("action", "lbList");
		$("#actionform").submit();
	});
	
	////// 작성
	$("#writeBtn").on("click", function(){		
	
		$("#actionform").attr("action", "lbWrite");
		$("#actionform").submit();	
	});
	
});


</script>
</head>
<body>
<!-- 폼 태그 -->
<form action="#" id="actionform" method="post">
	<input type="hidden" name="no" id="no">
	<input type="hidden" name="page" id="page" value="${page}">
</form>


<div class="table_wrap">	
	<!-- 등록 버튼 -->
	<input type="button" id="writeBtn" class="writeBtn" value="등록">

	<!-- 목록 테이블 -->
	<table>
		<thead>
			<tr>
				<th>책번호</th>
				<th>책제목</th>
				<th>저자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${list}">
				<tr no="${data.BOOK_NO}">
					<td>${data.BOOK_NO}</td>
					<td>${data.BOOK_TITLE}</td>
					<td>${data.BOOK_AUTHOR}</td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
	
	
</div>

<!-- 페이징 -->
<div id="paging_wrap">
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