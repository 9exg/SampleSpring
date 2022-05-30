<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATB Update</title>
<style type="text/css">
#att{
	display: none;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("con", {
		//옵션
		resize_enabled: false, //크기변경
		language : "ko",	//언어
		enterMode : 2,	//엔터 <br/> 처리
		width : "700",	//가로
		height : "300"	//세로
	});
	
	//취소 버튼 누르면 전 페이지로 이동
	$("#cancelBtn").on("click", function(){
		$("#backForm").submit();
	});
	
	//파일 삭제 버튼 클릭시 
	$("#fileDelBtn").on("click", function() {
		$("#attName").remove();
		$(this).remove();
		$("#att").show();
		
		$("#attFile").val("");
	});
	
	////필수항목 체크
	$("#updateBtn").on("click", function() {
		// instance[이름] : 해당 이름으로 CKEDITOR객체 취득
		// getData() : 입력된 데이터 취득
		$("#con").val(CKEDITOR.instances['con'].getData());
		if(checkEmpty("#title")){
			alert("제목을 입력하세요.");
			$("#title").focus();
		}else if(checkEmpty("#con")){
			alert("내용을 입력하세요.");
			$("#con").focus();
		}else{
			var updateForm = $("#updateForm");
			
			updateForm.ajaxForm({
				success : function(res){
					//물리파일명 보관
					if(res.fileName.length > 0) {
						$("#attFile").val(res.fileName[0]);
					}
					
					//글 수정
					var params = $("#updateForm").serialize();
					
					$.ajax({
						type: "post", 								// 전송 형태
						url : "atbAction/update", 					//통신 주소
						dataType : "json", 							//받을 데이터 형태
						data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
						success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
							if(res.res == "success"){
								$("#backForm").submit();
							}else{
								alert("수정중 문제가 발생하였습니다.");						
							}
						},
						error : function (request, status, error) {	//문제 발생 시 실행 함수
							console.log(request.requestText);		//결과 텍스트
						}
					}); //ajax end
					
				}, //success end
				error : function(req){
					console.log(req.responseText);
				}
			}); //ajaxForm end
			
			updateForm.submit(); //ajaxForm 실행
		}
	});
});

// 필수항목이 있는지 없는지 확인하는 함수
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
<form action="atb" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
</form>
<form action="fileUploadAjax" id="updateForm" method="post" enctype="multypart/form-data">
<input type="hidden" name="no" value="${param.no}" />	<!-- 특정 글을 수정하기 위한 고유값, 글번호 -->
번호: ${data.TB_NO}<br/>
제목<input type="text" id="title" name="title" value="${data.TB_TITLE}" /><br/>
첨부파일 :
<c:choose>
	<c:when test="${empty data.ATT_FILE}">
		<input type="file" name="att" ><br/>
		<input type="hidden" id="attFile" name="attFile" />
	</c:when>
	<c:otherwise>
		<c:set var="fileLength" value="${fn:length(data.ATT_FILE)}"></c:set>
		<c:set var="fileName" value="${fn:substring(data.ATT_FILE, 20, fileLength)}"></c:set>
		<span id="attName">${fileName}</span>
		<input type="button" value="첨부파일삭제" id="fileDelBtn" />
		<input type="hidden" id="attFile" name="attFile" value="${data.ATT_FILE}" />
		<input type="file" id="att" name="att" ><br/> <!-- 숨겨두었다가 나타나게 한다. -->
	</c:otherwise>
</c:choose>
작성자: ${data.M_NM}<br/>
내용<br/>
<textarea rows="20" cols="50" id="con" name="con">${data.TB_CON}</textarea><br/>
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>