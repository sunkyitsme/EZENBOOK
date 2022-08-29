<%@page import="com.ezbook.cart.vo.CartListVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 장바구니</title>
<!-- 스타일 적용 -->
<link href="../../resources/assets/css/style.css" rel="stylesheet">
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
</head>
<body>

<!-- 장바구니에 상품이 없을 때 -->
<c:if test="${empty cartList}">
<div class="container-fluid mt-100">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body cart">
                    <div class="col-sm-12 empty-cart-cls text-center"> <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130" class="img-fluid mb-4 mr-3">
                        <h3><strong>장바구니가 비어있습니다.</strong></h3>
                        <h4>Add something to make me happy :)</h4> <a href="/books/korList.do" class="btn btn-primary cart-btn-transform m-3" data-abc="true">책 보러가기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<!-- 장바구니에 상품이 있을 때 -->
<c:if test="${!empty cartList}">
<br>
<br>
<br>
<br>
<br>
	<div class="container">
		<section id="content">
 			<ul>
				<li>
					<div class="allCheck">
						<input type="checkbox" name="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label> 
							<script>
							$("#allCheck").click(function(){
							 var chk = $("#allCheck").prop("checked");
							 if(chk) {
							  $(".chBox").prop("checked", true);
							 } else {
							  $(".chBox").prop("checked", false);
							 }
							});
							</script>
  					</div> <!-- allCheck의 끝 -->
  
					<div class="delBtn">
   						<button type="button" class="selectDelete_btn">선택 삭제</button> 
   							<!-- ajax를 이용하여 JSP를 따로 만들지 않고 바로 처리하는 코드 -->
							<script>
							 $(".selectDelete_btn").click(function(){
							  var confirm_val = confirm("정말 삭제하시겠습니까?");
							  
							  if(confirm_val) {
							   var checkArr = new Array();
							   
							   $("input[class='chBox']:checked").each(function(){
							    checkArr.push($(this).attr("data-cartNum"));
							   });
							    
							   $.ajax({
							    url : "deleteCart.do",
							    type : "post",
							    data : { chbox : checkArr },
							    success : function(result){
							    	if(result == 1) {          
							    		   location.href = "cartList.do";
							    		  } else {
							    		   alert("삭제 실패");
							    		  }
							    }
							   });
							  } 
							 });
							</script>
					</div><!-- delBtn의 끝 -->
 				</li>
 				
  				<c:forEach items="${cartList}" var="cartList" varStatus="vs">
  					<li>
  						<div class="checkBox">
  							<input type="checkbox" name="chBox" class="chBox" data-cartNum="${cartList.cartNum}" />
							<script>
							 $(".chBox").click(function(){
							  $("#allCheck").prop("checked", false);
							 });
							</script>
  						</div> <!-- checkBox의 끝 -->
  						
   						<div class="thumb">
    						<img src="${cartList.fileName}" />
  						</div>
  						
						<div class="gdsInfo">
    						<p>
     							<span style="margin-left:10px;">상품명 : </span>${cartList.bookName}<br />
     							<span style="margin-left:10px;">구입 수량 : </span>${cartList.cartStock}<br />
   							</p>
   						</div>
   							    
    						<div class="delete">
 								<button type="button" class="delete_${cartList.cartNum}_btn btn btn-primary" data-cartNum="${cartList.cartNum}" style="margin:100px 0px 0px 20px;">삭제</button>
								<script>
									  $(".delete_${cartList.cartNum}_btn").click(function(){
									   var confirm_val = confirm("정말 삭제하시겠습니까?");
									   
									   if(confirm_val) {
									    var checkArr = new Array();
									    
									    checkArr.push($(this).attr("data-cartNum"));
									               
									    $.ajax({
									     url : "deleteCart.do",
									     type : "post",
									     data : { chbox : checkArr },
									     success : function(result){
									      if(result == 1) {     
									       location.href = "cartList.do";
									      } else {
									       alert("삭제 실패");
									      }
									     }
									    });
									   } 
									  });
								</script>
    						</div> <!-- delete의 끝 -->   
  						</li>
				</c:forEach>
 			</ul>
		</section>
	</div>
</c:if>
</body>
</html>