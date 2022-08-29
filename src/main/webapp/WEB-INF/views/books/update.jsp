<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 수정하기</title>
<script src="/resources/ckeditor/ckeditor.js"></script>
<style type="text/css">
.ck-content {						/* ckeditor 높이 */
    height: 170px;
}
</style>
<script type="text/javascript">
$(function() {

	// datepicker 클래스 이벤트 - 적정한 옵션을 넣어서 초기화 시켜 준다. 기본 datepicker()로 사용 가능
	$(".datepicker").datepicker(
			{
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy-mm-dd",
				dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
				monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
						"7월", "8월", "9월", "10월", "11월", "12월" ]
			});

	var now = new Date();
	var startYear = now.getFullYear();
	var yearRange = (startYear - 100) + ":" + startYear;
	// datepicker - 초기값으로 셋팅하는 방법을 사용하면 2번째는 무시 당한다.
	//원래 있던 datepicker에 option을 추가하는 방법이다.
	$(".datepicker").datepicker("option", {
		"maxDate" : new Date(),
		"yearRange" : yearRange
	});
});
</script>
</head>
<body>
<div class="container">
<br>
<br>
<br>
<hr>
	<form action="update.do" method="post" class="form-horizontal">
		<input name="page" value="${param.page }" type="hidden">
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		<input name="key" value="${param.key }" type="hidden">
		<input name="word" value="${param.word }" type="hidden">
		
		<div class="form-group">
			<label for="no" class="control-label col-sm-2">번호</label>
			<div class="col-sm-1">
				<input name="no" id="no" class="form-control" value="${vo.no }" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="bookName" class="control-label col-sm-2">제목</label>
			<div class="col-sm-3">
				<input name="bookName" id="bookName" class="form-control" value="${vo.bookName }">
			</div>
		</div>
		
		<div class="form-group">
			<label for="writer" class="control-label col-sm-2">작가</label>
			<div class="col-sm-1">
				<input name="writer" id="writer" class="form-control" value="${vo.writer }">
			</div>
		</div>
		
		<div class="form-group">
			<label for="publisher" class="control-label col-sm-2">출판사</label>
			<div class="col-sm-2">
				<input name="publisher" id="publisher" class="form-control" value="${vo.publisher }">
			</div>
		</div>
		
		<div class="form-group">
			<label for="publeYear" class="control-label col-sm-2">출판일</label>
			<div class="col-sm-2">
				<input name="publeYear" id="publeYear" class="datepicker form-control" autocomplete="off" value="<fmt:formatDate value="${vo.publeYear }" pattern="yyyy-MM-dd"/>">
			</div>
		</div>
		
		<div class="form-group">
			<label for="bookPrice" class="control-label col-sm-2">판매가</label>
				<div class="col-sm-2">
					<input name="bookPrice" id="bookPrice" class="form-control" value="${vo.bookPrice }">
				</div>
		</div>
		
		<div class="form-group">
			<label for="bookInfo" class="control-label col-sm-2">책 소개</label>
			<div class="col-sm-10">
				<textarea rows="7" cols="80" name="bookInfo" id="bookInfo_textarea" class="form-control">${vo.bookInfo }</textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="content" class="control-label col-sm-2">내용</label>
			<div class="col-sm-10">
				<textarea rows="7" cols="80" placeholder="책 소개(2000자 이내)" name="content" id="content_textarea" class="form-control">${vo.content }</textarea>
				<!-- 내용은 에디터를 사용하기 위해서 JS 코드를 사용한다. -->
				<script>
					var ckeditor_config = {
					resize_enaleb : false,
					enterMode : CKEDITOR.ENTER_BR,
					// 엔터를 했을 때 줄 바꿈이 되도록 처리한다.
					shiftEnterMode : CKEDITOR.ENTER_P,
					// shift+엔터를 했을 때 <p> 태그로 처리한다.
					filebrowserUploadUrl : "/books/ckUpload.do"
					// 이미지ㆍ파일을 업로드 하는 위치
					};
	
					CKEDITOR.replace("content_textarea", ckeditor_config);
					// textarea의 id와 맞춰서 작성해야 에디터가 해당란에서 작동한다.
				</script>
			</div>
		</div>

		<div style="text-align:center;">
			<button class="btn btn-primary">수정</button>
			<button class="btn btn-default" type="button" onclick="history.back()">취소</button>
		</div>
		
	</form>
</div>
</body>
</html>