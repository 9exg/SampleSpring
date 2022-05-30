<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OB</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 1000px;
	font-size: 10.5pt;
	text-align: center;
	margin: 20px 0px;
}
thead {
	background-color: #f2f2f2;
}
tbody tr{
		border-bottom: 1px solid #f2f2f2;
}
span {
	padding: 5px;
	margin: 5px 1px;
}
span:hover{
	cursor: pointer;
}
td:nth-child(3) {
	text-align: left;	
}
.pagingWrap {
	text-align: center;
}
.con{
	width: 500px;
}
#uBtn, #dBtn{
	border: none;
	background-color: white;
}
#uBtn:hover, #dBtn:hover {
	cursor: pointer;
	text-decoration: underline;
	color: blue;
}
#uBtn, #dBtn:action {
	font-weight : bold;
}

.write #updateBtn, .write #cancelBtn {
	display:none;
}
.update #writeBtn {
	display:none
}
</style>


<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	//등록
	$("#writeBtn").on("click", function() {
		if(checkEmpty("#writer")) {
			alert("작성자를 입력해주세요.")
			$("#writer").focus();
		}else if(checkEmpty("#con")) {
			alert("내용을 입력해주세요.")
			$("#con").focus();
		} else{
			$("#gbn").val("i");
			
			$("#actionForm").attr("action", "obAction");
			$("#actionForm").submit();
		}
	});
	
	//페이징
	$("#pagingWrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#actionForm").attr("action", "ob");
		$("#actionForm").submit();		
	});
	
	// 목록의 수정버튼
	$("tbody").on("click", "#uBtn", function() {
		//tr
		var tr = $(this).parent().parent();
		
		$("#no").val(tr.attr("no"));
		
		//tr의 첫번째 자식의 내용들 취득
		$("#writer").val(tr.children(":nth-child(1)").html());
		$("#con").val(tr.children(":nth-child(3)").html());
		
		//작성부분 버튼 변경
		$(".write").attr("class", "update");
	});
	
	// 수정영역 취소 버튼
	$("#actionForm").on ("click", "#cancelBtn", function() {
		$("#no").val("");
		$("#writer").val("");
		$("#con").val("");
		
		//수정 부분 버튼 변경
		$(".update").attr("class", "write");
	});
	
	// 수정영역 수정 버튼
	$("#actionForm").on("click", "#updateBtn", function() {
		if(checkEmpty("#writer")) {
			alert("작성자를 입력해주세요.")
			$("#writer").focus();
		}else if(checkEmpty("#con")) {
			alert("내용을 입력해주세요.")
			$("#con").focus();
		} else{
			$("#gbn").val("u");
			
			$("#actionForm").attr("action", "obAction");
			$("#actionForm").submit();
		}	
	});
	
	//목록의 삭제버튼
	$("tbody").on("click", "#dBtn", function() {
		if(confirm("삭제하시겠습니까?")) {
			//tr
			var tr = $(this).parent().parent();
			
			$("#no").val(tr.attr("no"));
			
			$("#gbn").val("d");
			
			$("#actionForm").attr("action", "obAction");
			$("#actionForm").submit();
		}
	});
});

//필수항목이 있는지 없는지 확인하는 함수
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
<!-- ************ -->
<!-- 작성 및 수정영역  -->
<form action="#" id="actionForm" method="post">
<input type="hidden" id="page" name="page" value="${page}" />	<!-- 페이징을 위한 페이지 -->
<input type="hidden" id="gbn" name="gbn" />						<!--  -->
<input type="hidden" id="no" name="no" />						<!-- 수정, 삭제시 필요한 글번호 -->
작성자 <input type="text" id="writer" name="writer" />
내용 <input type="text" id="con" name="con" class="con"/>
<span class="write"> 											<!-- 클래스만 바꾸면 버튼이 작성 / 수정취소 만 보이게 할 수 있다. -->
	<input type="button" value="작성" id="writeBtn" />
	<input type="button" value="수정" id="updateBtn" />
	<input type="button" value="취소" id="cancelBtn" />
</span>
</form>


<!-- ************ -->
<!-- **** 목록 ***-->
<table>
	<colgroup>
		<col width="100" />
		<col width="80" />
		<col width="420" />
		<col width="150" />
		<col width="150" />
	</colgroup>
	<thead>
		<tr>
			<th>작성자</th>
			<th></th>
			<th>내용</th>
			<th>작성일</th>
			<th>수정 / 삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr no="${data.OB_NO}">
				<td>${data.OB_WRITER}</td>
				<td></td>
				<td>${data.OB_CON}</td>
				<td>${data.OB_DT}</td>
				<td>
					<input type="button" value="수정" id="uBtn" />
					<input type="button" value="삭제" id="dBtn" />
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


<!-- ************ -->
<!-- *** 페이징 *** -->
<div id="pagingWrap" class="pagingWrap">
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