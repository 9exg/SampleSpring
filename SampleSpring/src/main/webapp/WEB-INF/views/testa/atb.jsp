<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATb</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#listBtn").on("click", function(){
		$("#actionForm").attr("action", "atbList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function(){
		$("#actionForm").attr("action", "atbUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			var params = $("#actionForm").serialize();
			
			$.ajax({
				type: "post", 								// 전송 형태
				url : "atbAction/delete", 					//통신 주소
				dataType : "json", 							//받을 데이터 형태
				data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
				success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
					if(res.res == "success"){
						location.href = "atbList";
					}else{
						alert("삭제중 문제가 발생하였습니다.");						
					}
				},
				error : function (request, status, error) {	//문제 발생 시 실행 함수
					console.log(request.requestText);		//결과 텍스트
				}
			});
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
<!-- 첨부파일 존재시 -->
<c:if test="${!empty data.ATT_FILE}">
<!-- c:set ==> 변수선언 -->
<!-- el에서 fn:length ==> 문자열의 길이나 배열의 크기를 가져옴 -->
<c:set var="fileLength" value="${fn:length(data.ATT_FILE)}"></c:set>
<c:set var="fileName" value="${fn:substring(data.ATT_FILE, 20, fileLength)}"></c:set>	<!-- 고유번호 20자 빼고 가져오기 -->
<!-- a 속성중 download : 파일을 다운로드하게 한다. 만약 값이 존재하면 파일명을 값으로 변경하여 다운 
					   확장자 없이 이름이 올 경우 자동으로 파일의 확장자를 붙여줌
-->
첨부파일 : <a href="resources/upload/${data.ATT_FILE}" download="${fileName}">
${fileName}</a><br/>
</c:if>
<br/>
<input type="button" value="목록으로" id="listBtn"/>
<c:if test="${data.TB_WRITER eq sMNo}">
	<input type="button" value="수정" id="updateBtn"/>
	<input type="button" value="삭제" id="deleteBtn"/>
</c:if>
</body>
</html>