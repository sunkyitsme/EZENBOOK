<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 국내 도서</title>
<style type="text/css">
.py-5 {
	padding-top: 3rem !important;
	padding-bottom: 3rem !important;
}

.dataRow:hover {
	cursor: pointer;
	background: #eee;
}


.text-center{
	font-family:'Gowun Dodum', sans-serif;
}
</style>
<script type="text/javascript">
//perPageNum 데이터의 변경 이벤트 처리 → jQuery에 대한 이벤트
$(function(){
	$("#perPageNumSelect").change(function() {
	// 			alert("값 변경");
		$("#perPageNumForm").submit()
	});
})
</script>
</head>
<body>
<br>
<br>
<br>
<br>
<br>
	<!-- 헤더 부분입니다. -->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder" style="font-family: 'Gowun Dodum', sans-serif;">국내 도서</h1>
				<p class="lead fw-normal text-white-50 mb-0" style="font-family: 'Poppins', sans-serif;">WHAT ARE YOU LOOKING FOR?</p>
				<br><label for="category" class="control-label col-sm-4"></label>
				<div class="col-sm-4">
					<form class="form-inline">
						<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
							<div class="input-group">
								<select name="key" class="form-control" style="font-weight:bold;">
									<option value="n" ${(pageObject.key == "n")?"selected":"" }>제목</option>
									<option value="w" ${(pageObject.key == "w")?"selected":"" }>작가명</option>
									<option value="nw" ${(pageObject.key == "nw")?"selected":"" }>전체</option>
								</select>
							</div> <!-- input-group의 끝 -->
							<div class="input-group">
								<input type="text" class="form-control" placeholder="검색어를 입력해주세요" name="word" value="${pageObject.word }" autocomplete="off">
								<div class="input-group-btn">
									<button class="btn btn-default col-sm-12" type="submit">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
					</form>
				</div>
			</div>
		</div>
	</header>
	
	<!-- 리스트 부분입니다. -->
	<div class="py-5">
		<div class="container">
			<div class="row" style="margin-bottom: 5px;">
				<div class="col-sm-4">
					<form action="korList.do" class="form-inline" id="perPageNumForm">
						<input type="hidden" name="page" value="1"> <input type="hidden" name="key" value="${pageObject.key }"> <input type="hidden" name="word" value="${pageObject.word }">
						<div class="form-group">
							<label>목록<select name="perPageNum" class="form-control" id="perPageNumSelect">
										<option ${(pageObject.perPageNum == 4)?"selected":"" }>4</option>
										<option ${(pageObject.perPageNum == 8)?"selected":"" }>8</option>
										<option ${(pageObject.perPageNum == 12)?"selected":"" }>12</option>
										<option ${(pageObject.perPageNum == 16)?"selected":"" }>16</option>
										<option ${(pageObject.perPageNum == 20)?"selected":"" }>20</option>
										</select>
							개</label>
						</div>
					</form>
				</div>
			</div> <!-- row의 끝 -->

			<div class="row">
				<c:forEach items="${korList }" var="vo" varStatus="vs">
					<div class="col-md-3">
					<!-- "col-md-3" : 한 줄에 사진 4장 표시 3*4=12 -->
						<div class="thumbnail dataRow" onclick="location='view.do?no=${vo.no}&page=${pageObject.page }&perPageNum=${pageObject.perPageNum }&key=${pageObject.key }&word=${pageObject.word }'">
							<img src="${vo.fileName }" alt="PhotoList" style="width: 100%; height: 300px;">
								<div class="text-center">
									<p>
									<br />
										<strong>${vo.bookName }</strong><br />${vo.bookPrice }<br />
									<br /> <strong>${vo.writer }</strong>
									</p>
								</div> <!-- text-center의 끝 -->
						</div>
					</div>
					<c:if test="${vs.count %4 == 0 && vs.count != list.size()}">
					${"</div>" }
					${"<div class='row'>"}
					</c:if>
				</c:forEach>
			</div> <!-- row의 끝 -->
			
			<div class="text-center">
				<pageNav:pageNav listURI="korList.do" pageObject="${pageObject }" query="&key=${pageObject.key }&word=${pageObject.word }" />
				<c:if test="${!empty login }">
					<div class="text-right">
						<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">등록</a>
					</div>
				</c:if>
			</div>
		</div> <!-- container의 끝 -->
	</div> <!-- py-5의 끝 -->
</body>
</html>