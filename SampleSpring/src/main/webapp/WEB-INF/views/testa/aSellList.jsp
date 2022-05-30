<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A Sell List</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	//////검색구분 유지
	if('${param.searchGbn}' != ''){						//검색중일 때만 작동
		$("#searchGbn").val('${param.searchGbn}');		//검색구분 유지
	}else {
		$("#oldSearchGbn").val("0");		
	}
	
	//////목록조회
	reloadList();
	
	//////엔터키 눌렀을 때 폼 자동 실행되지 않고 지정으로 실행되도록
	$("#searchTxt").on("keypress", function(event){		//event : 내가 어떤 키를 눌렀을 때 처리하는것
		if(event.keyCode ==13) {
			$("#searchBtn").click();						//검색하면 1페이지가 되도록
			
			return false;								
		}
	});
	
	//////검색
	$("#searchBtn").on("click", function() {
		$("#page").val("1");	//검색하면 1페이지가 되도록
		
		$("#oldSearchGbn").val($("#searchGbn").val());
		$("#oldSearchTxt").val($("#searchTxt").val());
		
		reloadList();		//목록조회
	});
	
	
	//////상세보기
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "aSell");
		$("#actionForm").submit();
	});
	
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		reloadList();		//목록조회
	});
	
	
	//////작성
	$("#writeBtn").on("click", function(){		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "aSellAdd");
		$("#actionForm").submit();	
	});
		
	
});

function reloadList() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type : "post",
		url : "aSellListAjax",
		dataType : "json",
		data : params,
		success : function (res) {
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function(request, status, error) {
			console.log(request.requestText);
		}
	});
}

function drawList(list){
	var html = "";
	
	for(var data of list){
		html += "<tr no=\"" + data.SELL_NO + "\">";
		html += "<td>" + data.SELL_NO + "</td>";
		html += "<td>" + data.ITEM_NAME + "</td>";
		html += "<td>" + data.COUNT + "</td>";
		html += "<td>" + data.SELL_DT + "</td>";
		html += "</tr>";
	}
	
	$("tbody").html(html);
}

function drawPaging(pb) {
	var html = "";
	
	html += "<span page=\"1\">처음</span>";
	
	if($("#page").val() == "1" ){
		html += "<span page=\"1\">이전</span>";
	}else{
		html += "<span page=\"" + ($("#page").val() * 1 - 1 ) + "\">이전</span>";
	}

	for(var i = pb.startPcount ; i <= pb.endPcount ; i++ ){
		if($("#page").val() == i){
			html += "<span page=\"" + i + "\"><b>" + i + "</b></span>";
		}else {
			html += "<span page=\"" + i + "\">" + i + "</span>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<span page =\"" + pb.maxPcount + "\">다음</span>";
	}else{
		html += "<span page = \"" + ($("#page").val() * 1 +1 ) + "\" >다음</span>";
	}

	html += "<span page=\"" + pb.maxPcount + "\">마지막</span>";
	
	$("#paging_wrap").html(html);
}


</script>
</head>
<body>
<!-- 검색 데이터 유지용 -->
<input type="hidden" id="oldSearchTxt" value="${param.searchTxt}" />
<input type="hidden" id="oldSearchGbn" value="${param.searchGbn}" />

<form action="#" id="actionForm" method="post"> 
	<input type="hidden" name="no" id="no">   
	<input type="hidden" name="page" id="page" value="${page}">  
	<select id="searchGbn" name="searchGbn">
		<option value="0">상품명</option>
		<option value="1">상품번호</option>
	</select>
	<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" />  
	<input type="button" value="검색" id="searchBtn" />
 	<input type="button" value="글쓰기" id="writeBtn" />
</form>
<!-- 테이블 -->
<table>
	<thead>
		<tr>
			<th>상품번호</th>
			<th>상품명</th>
			<th>수량</th>
			<th>등록일</th>
		</tr>
	</thead>
	<tbody></tbody>
</table>
<!-- 페이징 -->
<div id="paging_wrap"></div>
</body>
</html>