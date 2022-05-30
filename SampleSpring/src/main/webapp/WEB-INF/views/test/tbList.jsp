<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TB List</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	if('${param.searchGbn}' != ''){						//검색중일 때만 작동
		$("#searchGbn").val('${param.searchGbn}');		//검색구분 유지
	}
	
	////// 엔터키 눌렀을 때 폼 자동 실행되지 않고 지정으로 실행되도록
	$("#searchTxt").on("keypress", function(event){		//event : 내가 어떤 키를 눌렀을 때 처리하는것
		if(event.keyCode ==13) {
			$("#page").val("1");						//검색하면 1페이지가 되도록
			
			$("#actionForm").attr("action", "tbList");
			$("#actionForm").submit();
			
			return false;								
		}
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");							//검색하면 1페이지가 되도록
		
		$("#actionForm").attr("action", "tbList");
		$("#actionForm").submit();
	});
	
	////// 상세보기
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
		
		$("#actionForm").attr("action", "tb");
		$("#actionForm").submit();
	});
	
	////// 페이징
	$("#paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "tbList");
		$("#actionForm").submit();
	});
	
	////// 작성
	$("#writeBtn").on("click", function(){		
		$("#searchGbn").val($("#oldSearchTGbn").val());
		$("#searchTxt").val($("#oldSearchTxt").val());
	
		$("#actionForm").attr("action", "tbWrite");
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
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var ="data" items="${list}">
			<tr no ="${data.TB_NO}">
				<td>${data.TB_NO}</td>
				<td>${data.TB_TITLE}</td>
				<td>${data.M_NM}</td>
				<td>${data.TB_DT}</td>
				<td>${data.TB_HIT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

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