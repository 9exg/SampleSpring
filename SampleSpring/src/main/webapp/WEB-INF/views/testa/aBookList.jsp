<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A Book List</title>
<style type="text/css">
.table_wrap {
	width : 500px;
	height : 150px;
}
.btn_wrap{
	width : 500px;
	text-align: right;
	margin-top : 20px;
}
#paging_wrap {
	width : 500px;
	text-align: center;
}
#paging_wrap span {
	margin : 3px;
}
.writeBtn {
	margin-right: 15px;
}
table {
	width : 500px;
	text-align: center;
	margin : 20px auto;
	border-collapse: collapse;
}
thead tr {
	height : 40px;
 	border-bottom: 1px solid black;
}
tbody tr {
	height : 30px;
 	border-bottom: 1px solid #d7d7d7;
}

tbody tr td:nth-child(2) {
	text-align: left;
}
.writeBtn, tbody tr td:nth-child(2), #paging_wrap span:hover {
	cursor: pointer;
}

tbody tr td:nth-child(2):hover {
	text-decoration: underline;
	color: purple;
}

</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//////목록조회
	reloadList();
	
	
	////// 상세보기
	$("tbody").on("click", "tr", function(){
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").attr("action", "aBook");
		$("#actionForm").submit();
	});
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
	
		reloadList();		//목록조회
	});
	
	////// 작성
	$("#writeBtn").on("click", function(){		
	
		$("#actionForm").attr("action", "aBookWrite");
		$("#actionForm").submit();	
	});
	
});

function reloadList() {		//목록 조회용 + 페이징 조회용
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type: "post", 								
		url : "aBookListAjax", 						
		dataType : "json", 							
		data : params,								
		success : function (res) {					
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function (request, status, error) {	
			console.log(request.requestText);		
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list){
		html += "<tr no=\"" + data.BOOK_NO + "\">";
		html += "<td>" + data.BOOK_NO + "</td>";
		html += "<td>" + data.BOOK_TITLE + "</td>";
		html += "<td>" + data.BOOK_AUTHOR + "</td>";
		html += "</tr>";
	}
	$("tbody").html(html);
}

function drawPaging(pb) {
	var html = "";
	
	html += "<span page=\"1\">처음</span>";

	if($("#page").val() == "1"){
		html += "<span page=\"1\">이전</span>";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 - 1) + "\">이전</span>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++ ){
		if($("#page").val() == i){
			html += "<span page=\"" + i + "\"><b>" + i + "</b></span>";
		}else {
			html += "<span page=\"" + i + "\">" + i + "</span>";
		}
		
	}
	if($("#page").val() == pb.maxPcount) {
		html += "<span page=\"" + pb.maxPcount + "\">다음</span>";
	}else{
		html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>";
	}

	html += "<span page=\"" + pb.maxPcount + "\">마지막</span>";
	
	$("#paging_wrap").html(html);
}
</script>
</head>
<body>
<!-- 폼 태그 -->
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="no" id="no">
	<input type="hidden" name="page" id="page" value="${page}">
</form>

<div class="btn_wrap">
	<!-- 등록 버튼 -->
	<input type="button" id="writeBtn" class="writeBtn" value="등록">
</div>
<div class="table_wrap">	
	<!-- 목록 테이블 -->
	<table>
		<thead>
			<tr>
				<th>책번호</th>
				<th>책제목</th>
				<th>저자</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>

<!-- 페이징 -->
<div id="paging_wrap"></div>
</body>
</html>