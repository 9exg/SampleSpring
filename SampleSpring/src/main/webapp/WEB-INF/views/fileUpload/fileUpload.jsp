<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FileUpload Test</title>
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$("#uploadBtn").on("click", function(){
		var fileForm = $("#fileForm");
		
		//ajaxForm : form의 동작을 동기화에서 비동기화 방식으로 변경
		fileForm.ajaxForm({ //보내기전 validation check가 필요할경우 
			beforeSubmit: function (data, frm, opt) { 	//beforeSubmit : 보내기전 validation check가 필요할 경우
				alert("전송전!!"); return true;
			}, //submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.result =="SUCCESS"){
//					var resData = eval("(" + removePre(data) + ")");
//					alert("저장완료");
//					alert(data);
//					alert(resData.fileName[0]);
//					alert(resData.fileName[1]);
//					alert(resData.fileName[2]);
//					var resData = eval("(" + removePre(data) + ")");
					alert("저장완료");
					
					console.log(responseText);
					alert(responseText.fileName[0]);
					alert(responseText.fileName[1]);
					alert(responseText.fileName[2]);
				} else {
					alert("저장실패");
				} 
			}, //ajax error
			error: function(){
				alert("에러발생!!"); 
			}
		});
		
		fileForm.submit();
	});
});


</script>
</head>
<body>
<!-- 
	enctype : form 전송 데이터 형태
	multipart : 파일 데이터를 포함한 형태 
 -->
<form id="fileForm" name="fileForm" action="fileUploadAjax" 
	  method="post" enctype="multipart/form-data">
<h3> 첨부파일</h3>
<table width="770"border="0" cellspacing="0" cellpadding="0" class="table_1">
	<colgroup>
		<col width="150px" />
		<col width="600px" />
	</colgroup>
	<tr>
		<th>첨부파일1</th>
		<td><input type="file" name="attFile1" size="85" /></td>
	</tr>
	<tr>
		<th>첨부파일2</th>
		<td><input type="file" name="attFile2" size="85" /></td>
	</tr>
	<tr>
		<th class="th_bot">첨부파일3</th>
		<td class="th_bot"><input type="file" name="attFile3" size="85" /></td>
	</tr>
</table>
</form>
<input type="button" value="저장" id="uploadBtn" />
</body>
</html>