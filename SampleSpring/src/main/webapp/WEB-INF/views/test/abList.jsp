<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AB List</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 700px;
	font-size: 10.5pt;
	text-align: center;
	margin: 10px 0px;
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
th {
	height: 30px;
}
td {
	height: 25px;
}
.listTb tbody tr, span:hover{
	cursor: pointer;
}
.analyTb tbody, .analyTb td, .analyTb th{
	border: 1px solid #f2f2f2;
}

.paging_wrap {
	width: 700px;
	text-align: center;
}
.search_wrap {
	width: 700px;
	text-align: right;
}
.searchGbn{
	height: 20px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	
		
	if('${param.searchGbn}' != ''){						//검색중일 때만 작동
		$("#searchGbn").val('${param.searchGbn}');		//검색구분 유지
	}
	
	//////월이 바뀌었을 때 자동 검색되도록
	$("#searchMon").on("change", function () {
		$("#searchGbn").val($("#onldSearchGbn").val());
		$("#searchTxt").val($("#onldSearchTxt").val());
		
		$("#searchBtn").click();
	});
	
	////// 엔터키 눌렀을 때 폼 자동 실행되지 않고 지정으로 실행되도록
	$("#searchTxt").on("keypress", function(event){		
		if(event.keyCode ==13) {
			$("#page").val("1");						//검색하면 1페이지가 되도록
			
			$("#actionForm").attr("action", "abList");
			$("#actionForm").submit();
			
			return false;								
		}
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");							//검색하면 1페이지가 되도록
		
		$("#actionForm").attr("action", "abList");
		$("#actionForm").submit();
	});
	
	////// 상세보기
	$(".listTb tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "ab");
		$("#actionForm").submit();
	});
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "abList");
		$("#actionForm").submit();
	});
	
	////// 작성
	$("#addBtn").on("click", function(){		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "abAdd");
		$("#actionForm").submit();	
	});
	
	//로그아웃
	$("#logoutBtn").on("click", function(){
		location.href = "mLogout";
	});

	$("#loginBtn").on("click", function(){
		location.href = "mLogin";
	});
		
	
	
});
</script>
</head>
<body>
${sMNm} 님 어서오십시오. <input type="button" value="로그아웃" id="logoutBtn" />
<br/>
<br/>
<!-- 검색 데이터 유지용 -->
<input type="hidden" id="oldSearchTxt" value="${param.searchTxt}" />
<input type="hidden" id="oldSearchGbn" value="${param.searchGbn}" />

<!-- action, href 에서의 # : 이동하지 않겠다. (아직 결정나지 않았을 때)  -->
<form action="#" id="actionForm" method="post"> 
	<input type="hidden" name="no" id="no">  <!-- 데이터 한 건을 기준 짓기 위해 글번호를 담을 공간 -->
	<input type="hidden" name="page" id="page" value="${page}">  
	<div class="search_wrap">
		<input type="month" id="searchMon" name="searchMon" value="${searchMon}" />
		<select id="searchGbn" name="searchGbn" class="searchGbn">
			<option value="0">작성자</option>
			<option value="1">내용</option>
		</select>
		<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" /> <!-- value : 검색어 유지 -->
		<input type="button" value="검색" id="searchBtn" />
		&nbsp;
		<input type="button" value="글쓰기" id="addBtn" />	
 
	</div>
</form>
<table class="analyTb">
	<tbody>
		<tr>
			<th rowspan ="2"> 당월 </th>
			<th>입금</th>
			<td>${analy.INSUM}</td>
		</tr>
		<tr>
			<th> 출금 </th>
			<td>${analy.OUTSUM}</td>
		</tr>
		<tr>
			<th colspan ="2"> 총 잔고 </th>
			<td>${analy.TOT}</td>
		</tr>
	</tbody>
</table>
<table class="listTb">
	<thead>
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>금액</th>
			<th>내용</th>
			<th>유형</th>
			<th>적용일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var ="data" items="${list}">
			<tr no ="${data.AB_NO}">
				<td>${data.AB_NO}</td>
				<td>${data.M_NM}</td>
				<td>${data.PRICE}</td>
				<td>${data.AB_CON}</td>
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
				<td>${data.AB_DT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<!-- 페이징 -->
<div id="paging_wrap" class="paging_wrap">
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