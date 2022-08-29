<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: ${vo.bookName }</title>
<style type="text/css">
#footer { font-family: "Montserrat", sans-serif; }
.container { border-top: 1px dashed #000; max-width: 1200px; padding: 15px; }
</style>
<script type="text/javascript">
	$(function() {
		// 이미지 바꾸기 이벤트
		$("#changeImageBtn").click(function() {
		//alert("이미지 바꾸기");
			$("#changeImageDiv").slideToggle();
		});
		
		// 댓글 삭제 이벤트
		$(".deleteRepBtn").click(function(){
			var repNum = $(this).closest("div").find(".repNum").val();
			alert("리뷰가 삭제됩니다. 정말 삭제하시겠습니까?");
			location = "repdelete.do?no=${vo.no}&repNum=" + repNum;
		});
	});
</script>
</head>
<body>
<div class="books">
	<!-- 왼쪽 컬럼 썸네일 표시 부분 -->
	<div class="left-column">
		<img data-image="red" class="active" src="${vo.fileName }" alt="">
	</div>


	<!-- 오른쪽 컬럼 정보 표시 부분 -->
	<div class="right-column">
	
	<!-- 출판사, 도서 이름, 작가, 출판일 부분 -->
		<div class="product-description">
			<span>${vo.publisher }</span>
			<h1>${vo.bookName }</h1>
			<p>${vo.writer } 저 | <fmt:formatDate value="${vo.publeYear }" pattern="yyyy년 MM월 dd일" /></p>
		</div>


		<!-- 판매가, 책 소개 부분 -->
		<div class="product-price">
			<p>판매가</p>
			<span>${vo.bookPrice }</span>
		</div>
		<div class="product-price">
			<p>책 소개</p>
		</div>
		<p>${vo.bookInfo }</p>
		
		<!-- 구입 수량 부분 -->
		<div class="cartStock">
 			<p>구입 수량</p>
 			<button type="button" class="plus btn btn-default btn-sm">+</button>
 			<input type="number" class="numBox" min="1" max="${vo.bookStock}" value="1" readonly="readonly"/>
			<button type="button" class="minus btn btn-default btn-sm">-</button>
 		</div>
 
 		<script>
 		// + 버튼을 눌렀을 때 작동하는 이벤트
		$(".plus").click(function(){
		   var num = $(".numBox").val();
		   var plusNum = Number(num) + 1;
		   
		   if(plusNum >= ${vo.bookStock}) {
		    $(".numBox").val(num);
		   } else {
		    $(".numBox").val(plusNum);          
		   }
		  });
		  
 		// - 버튼을 눌렀을 때 작동하는 이벤트
		$(".minus").click(function(){
		   var num = $(".numBox").val();
		   var minusNum = Number(num) - 1;
		   
		   // 0 이하로는 선택할 수 없도록 한다.
		   if(minusNum <= 0) {
		    $(".numBox").val(num);
		   } else {
		    $(".numBox").val(minusNum);          
		   }
		  });
		</script>
 
 		<p class="addToCart">
			<button type="button" class="addCart_btn btn btn-primary">장바구니에 담기</button>
			<script>
			// 장바구니에 담기 버튼을 클릭시 발생하는 이벤트 코드
			$(".addCart_btn").click(function(){
			var no = $("#no").val(); // no는 도서 번호가 된다.
			var cartStock = $(".numBox").val();
		      
			var data = {
		     no : ${vo.no}, // ${vo.no} 라고 작성하지 않으면 이벤트 처리가 되지 않는다.
		     cartStock : cartStock
		     };
		   
				// ajax를 이용하여 JSP를 따로 만들지 않고 바로 실행할 수 있도록 한다.
				$.ajax({
					url : "addCart.do",
				    type : "post",
				    data : data,
				    success : function(result){
				    	 if(result == 1) {
				    	     alert("장바구니에 추가 되었습니다.");
				    	     $(".numBox").val("1");
				    	    } else {
				    	     alert("회원만 사용할 수 있습니다.")
				    	     $(".numBox").val("1");
				    	    }
				    },
				    error : function(){
				     alert("카트 담기 실패");
				    }
					}); // ajax의 끝
				});
			</script>
 		</p>
	</div>
</div> <!-- books의 끝 -->

<div class="container">
	<c:if test="${!empty login && login.gradeNo == 9}">
		<div class="col-sm-3">
			<button class="changeImageBtn btn btn-primary" id="changeImageBtn">썸네일 변경</button>
		</div>
		<div id="changeImageDiv" class="col-sm-3">
			<form action="changeImage.do" method="post" enctype="multipart/form-data">
			<!-- Controller의 ChangeImage() 에서 return 값으로 받은것들을 전부 hidden으로 넘겨야 함-->
				<input name="no" type="hidden" value="${vo.no }">
				<input name="page" type="hidden" value="${param.page }">
				<input name="perPageNum" type="hidden" value="${param.perPageNum }">
				<input name="key" type="hidden" value="${param.key }">
				<input name="word" type="hidden" value="${param.word }">
				<input name="deleteImage" value="${vo.fileName }" type="hidden">
				<input type="file" name="image" class="form-control">
				<button class="btn btn-default">바꾸기</button>
			</form>
		</div>
	</c:if>
	<table class="table">
		<tr>
			<th>책 소개</th>
			<td>${vo.content }</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<!-- 로그인한 관리자에게만 보이는 수정 / 삭제 버튼 -->
				<c:if test="${!empty login && login.gradeNo == 9}">
					<a href="update.do?no=${vo.no }&inc=0&page=${param.page }&perPageNum=${param.perPageNum}" class="btn btn-primary">수정</a>
					<a href="delete.do?no=${vo.no }&perPageNum=${param.perPageNum}" class="btn btn-primary" id="deleteBtn">삭제</a>
				</c:if>
					<a href="korList.do?page=${param.page }&perPageNum=${param.perPageNum}" class="btn btn-primary">목록으로</a>
			</td>
		</tr>
	</table>
	
	<!-- 댓글 부분(로그인 하지 않았을 때) -->
	<div class="reviewType" id="reply">
		<h4 class="h4-css" style="text-align: left;">댓글</h4>
		<div style="width: 85%; margin: auto;">
			<c:if test="${empty login}">
				<div class="re-wit">
					<form name="reform" id="reform">
						<span class="writeForm">
							<input name="content" class="form-control" value="로그인 후 소중한 댓글을 남겨주세요." type="text" readonly style="border-radius: unset;">
						</span>
						<a href="/member/login.do" class="btn btn-default setbtn">로그인</a>
					</form>
				</div>
			</c:if>
		
			<!-- 댓글 부분(로그인 했을 때) -->
			<c:if test="${!empty login}">
				<div class="re-wit login-re-wit">
					<div class="form">
						<form role="form" method="post" autocomplete="off">
							<input type="hidden" name="no" value="${vo.no}">
							<input name="page" type="hidden" value="${param.page }">
							<input name="perPageNum" type="hidden" value="${param.perPageNum }">
							<input name="key" type="hidden" value="${param.key }">
							<input name="word" type="hidden" value="${param.word }">
							<span class="writeForm" style="width: 100%;">
								<textarea name="repCon" rows="4" id="repCon" placeholder="소중한 댓글을 남겨주세요." style="width: 100%;"></textarea>
							</span>		
							<div class="setbtn-box">
								<button class="btn btn-default setbtn">등록</button>
							</div>
						</form>
					</div>
				</div>
			</c:if>
			
			<!-- 댓글 리스트 부분 -->
			<section class="replyList">
				<div class="wrap_reply">
					<div class="list_reply">
						<ul style="padding-left: unset; padding: 8px;">
 							<c:forEach items="${reply}" var="reply">
 								<li class="dataRow">
									<div class="ico_rep">
										<i class="fa fa-user-circle" style="font-size:40px;color:gray"></i>
									</div>
									<div class="tex_rep">
										<span class="id"><strong>${reply.id}</strong></span>
											<span class="date"><fmt:formatDate value="${reply.repDate}" pattern="YY-MM-dd HH:mm" /></span>
									</div>
									
									<!-- 댓글 작성자와 session에 저장된 아이디가 다를 때 -->
  									<c:if test="${!empty login && reply.id == login.id}">
										<div class="up-del-btn-box pull-right">
											<form action="deleteReply.do" method="post">
												<input name="no" type="hidden" value="${vo.no }">
												<input name="page" type="hidden" value="${param.page }">
												<input name="perPageNum" type="hidden" value="${param.perPageNum }">
												<input name="key" type="hidden" value="${param.key }">
												<input name="word" type="hidden" value="${param.word }">
												<input type="hidden" name="repNum" class="repNum" value="${reply.repNum }">
												<button class="btn btn-default del-btn btn-sm deleteRepBtn">삭제</button>
											</form>
										</div>
									</c:if>
      								<div class="replyContent">${reply.repCon}</div>
   									</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</section>
		</div>
	</div>
</div>
</body>
</html>