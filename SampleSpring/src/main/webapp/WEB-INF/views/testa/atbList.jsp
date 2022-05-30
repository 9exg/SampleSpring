<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATB List</title>
<style type="text/css">
tbody img {
	width:  12px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	//////검색구분 유지
	if('${param.searchGbn}' != ''){						//검색중일 때만 작동
		$("#searchGbn").val('${param.searchGbn}');		//검색구분 유지
	}else {
		$("#oldSearchGbn").val("0");		
	}
	
	//////목록조회
	reloadList();
	
	////// 엔터키 눌렀을 때 폼 자동 실행되지 않고 지정으로 실행되도록
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
	
	
	////// 상세보기
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "atb");
		$("#actionForm").submit();
	});
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		reloadList();		//목록조회
	});
	
	////// 작성
	$("#writeBtn").on("click", function(){		
		$("#searchGbn").val($("#oldSearchGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "atbWrite");
		$("#actionForm").submit();	
	});
	
	//로그아웃
	$("#logoutBtn").on("click", function(){
		location.href = "amLogout";
	});

	
	//로그인
	$("#loginBtn").on("click", function(){
		location.href = "amLogin";
	});
});

function reloadList() {		//목록 조회용 + 페이징 조회용
	var params = $("#actionForm").serialize();
	
	$.ajax({
		type: "post", 								// 전송 형태
		url : "atbListAjax", 						//통신 주소
		dataType : "json", 							//받을 데이터 형태
		data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
		success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
			console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error : function (request, status, error) {	//문제 발생 시 실행 함수
			console.log(request.requestText);		//결과 텍스트
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list){
		html += "<tr no=\"" + data.TB_NO + "\">";
		html += "<td>" + data.TB_NO +"</td>";
		html += "<td>";
		html += data.TB_TITLE;
		if(data.ATT_FILE != null){
			html += "<img src=\" resources/images/attFile.png\" />";
		}
		html += "</td>";
		html += "<td>" + data.M_NM +"</td>";
		html += "<td>" + data.TB_HIT +"</td>";
		html += "<td>" + data.TB_DT +"</td>";
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
<c:choose>
	<%--  비로그인 시--%>
	<c:when test="${empty sMNo}">
		로그인이 필요합니다. <input type="button" value="로그인" id="loginBtn" />
	</c:when>
	<%--  로그인 시--%>
	<c:otherwise>
		${sMNm} 님 어서오십시오. <input type="button" value="로그아웃" id="logoutBtn" />
	</c:otherwise>
</c:choose>

<!-- 검색 데이터 유지용 -->
<input type="hidden" id="oldSearchTxt" value="${param.searchTxt}" />
<input type="hidden" id="oldSearchGbn" value="${param.searchGbn}" />

<!-- action, href 에서의 # : 이동하지 않겠다. (아직 결정나지 않았을 때)  -->
<form action="#" id="actionForm" method="post"> 
	<input type="hidden" name="no" id="no">  <!-- 데이터 한 건을 기준 짓기 위해 글번호를 담을 공간 -->
	<input type="hidden" name="page" id="page" value="${page}">  
	<select id="searchGbn" name="searchGbn">
		<option value="0">제목</option>
		<option value="1">작성자</option>
	</select>
	<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" /> <!-- value : 검색어 유지 -->
	<input type="button" value="검색" id="searchBtn" />
	<c:if test="${!empty sMNo}">							<!-- 비어있지 않을 때(세션에 정보가 있을 때) 글쓰기 버튼 보인다. -->
		<input type="button" value="글쓰기" id="writeBtn" />
	</c:if>
</form>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody></tbody>
</table>

<!-- 페이징 -->
<div id="paging_wrap"></div>
</body>
</html>