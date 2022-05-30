<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATB Write</title>
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
	
	//필수항목 체크
	$("#writeBtn").on("click", function() {
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
			var writeForm = $("#writeForm");
			
			writeForm.ajaxForm({
				success : function(res){
					//물리파일명 보관
					if(res.fileName.length > 0) {					//하나라도 파일이 있는지 확인
					$("#attFile").val(res.fileName[0]);				//하나가 넘어오더라도 배열로 넘어옴 (컨트롤러에서 확인가능)
					}
					
					//글 저장
					var params = $("#writeForm").serialize();
					
					$.ajax({
						type: "post", 								// 전송 형태
						url : "atbAction/insert", 					//통신 주소
						dataType : "json", 							//받을 데이터 형태
						data : params,								//보낼 데이터. 보낼 것이 없으면 안씀.
						success : function (res) {					//성공시 실행 함수. 인자는 받아온 데이터
							if(res.res == "success"){
								location.href = "atbList";
							}else{
								alert("작성중 문제가 발생하였습니다.");						
							}
						},
						error : function (request, status, error) {	//문제 발생 시 실행 함수
							console.log(request.requestText);		//결과 텍스트
						}
					});	//ajax end
				}, //success end
				error : function() {
					console.log(req.responseText);
				} //error end
			});	//ajaxForm end
			
			writeForm.submit(); //ajaxForm 실행
		} //else end
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
<form action="atbList" id="backForm" method="post"> 
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="page" value="${param.page}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" /> 
</form>

<form action="fileUploadAjax" id="writeForm" method="post"
	  enctype="multipart/form-data">
제목<input type="text" id="title" name="title" /><br/>
작성자 : ${sMNm}<input type="hidden" name="writer" value="${sMNo}" /><br/>
내용<br/>
<textarea rows="20" cols="50" id="con" name="con"></textarea><br/>
첨부파일 <input type="file" name="att" /><br/>
<input type="hidden" id="attFile" name="attFile" /><br/>
<input type="button" value="작성" id="writeBtn" />
<input type="button" value="취소" id="cancelBtn" />
</form>

</body>
</html>