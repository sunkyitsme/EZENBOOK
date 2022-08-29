<!-- Sitemesh 설정 파일 -->
<!-- 작성자 : 백해운 -->
<!-- 작성일 : 2022-03-18 -->

<!-- 한글 처리 -->
<%@page import="com.ezbook.member.vo.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 모든 페이지에 Sitemesh 적용하기 -->
<%@taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!-- JSTL 사용 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 세션에 로그인 정보 저장해두기 -->
<% LoginVO loginVO = (LoginVO)session.getAttribute("login");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이젠문고<decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 다운로드 받은 Bootstrap template 등록 -->
<link href="../../resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../../resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- CDN 방식으로 Bootstrap 라이브러리 등록 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- CDN 방식으로 jQuery 라이브러리 등록 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- 다운로드 받은 아이콘 등록 -->
<link href="../../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="../../resources/assets/img/favicon.png" rel="icon">
<link href="../../resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- CDN 방식으로 구글 폰트 등록 -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Gowun+Dodum&family=Hahmlet:wght@100&family=IBM+Plex+Sans+KR:wght@100;200;300;400;500;600;700&family=Nanum+Gothic:wght@400;700;800&family=Poppins:wght@400;800&family=Song+Myung&display=swap" rel="stylesheet">

<!-- 다운로드 받은 Bootstrap template 등록 -->
<link href="../../resources/assets/css/style.css" rel="stylesheet">
<link href="../../resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="../../resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
<link href="../../resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- 모든 페이지에 JS 적용하기 -->
<script src="../../resources/assets/js/main.js?v1"></script>
<script src="../../resources/assets/vendor/purecounter/purecounter.js"></script>
<script src="../../resources/assets/vendor/aos/aos.js"></script>
<script src="../../resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../../resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../../resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../../resources/assets/vendor/php-email-form/validate.js"></script>

<!-- jQuery UI 라이브러리 CDN 방식으로 등록 : datepicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<!-- JS CODE -->
<script type="text/javascript">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();

		// 삭제 버튼 이벤트 처리
		$("#deleteBtn").click(function() {

			// 사용자에게 확인/취소 선택 창 열기 - confirm : 확인-true 취소-false
			//	 		alert(confirm("정말 삭제하시겠습니까?"));

			return confirm("정보를 삭제하시겠습니까?");

			// 페이지 이동을 막는다. → 나중에 주석처리 꼭 해야함.
			//	 		return false;		
		});

	});
</script>

<c:if test="${!empty msg}">
	<script type="text/javascript">
		$(function() {
			var msgShow = true;
			if (msgShow) {
				// 화면에 데이터 출력보다 alert이 먼저 실행될 때 
				setTimeout(function() {
					alert("${msg}");
				}, 200 // 0.2 초 : 1000 -> 1초 : 기다려야 할 시간
				);
				msgShow = false;
			}
		});
	</script>
</c:if>
<decorator:head />
</head>
<body>
<!-- Header 부분 -->
  <header id="header" class="fixed-top d-flex align-items-center header-transparent fixed-top">
    <div class="container d-flex align-items-center">
 		<h1 class="logo me-auto"><a href="/main/main.do">EZEN BOOK</a></h1>
 			<nav id="navbar" class="navbar order-last order-lg-0">
       		 <ul>
         		<li><a class="nav-link scrollto" href="/main/main.do">Home</a></li>
        		<li><a class="nav-link scrollto" href="#portfolio">Best</a></li>
          		<li class="dropdown"><a class="nav-link scrollto" href="/books/korList.do"><span>Books</span> <i class="bi bi-chevron-down"></i></a>
            	 <ul>
                	<li><a class="nav-link scrollto" href="/books/korList.do">국내 도서</a></li>
                	<li><a class="nav-link scrollto" href="/books/engList.do">외국 도서</a></li>
             	</ul>
          </li>   
			<%if(loginVO == null){ %>
				<li><a class="nav-link scrollto login" href="/member/login.do">login</a></li>
			<%} %>

			<%if(loginVO != null){ %>
				<li><a class="nav-link scrollto" href="/cart/cartList.do">Cart</a></li>
				<li><a class="nav-link scrollto" href="/member/myPage.do">MyPage</a></li>
				<li><a href="/member/logout.do">logout</a></li>
			<%} %>
        	 </ul>
         	</nav>
    </div>
  </header>
	<article>
		<decorator:body />
	</article>
		<footer id="footer" class="section-bg">
      		<div class="copyright">
       			<p>
				㈜EZEN BOOK 경기도 의정부시 | 대표이사 : 백해운 <br><strong>대표전화 : 1234 - 1234</strong> 팩스
				: 1234-123-1234 <br> &copy;COPYRIGHT <strong>EZEN BOOK CENTRE</strong>. ALL
				RIGHTS RESERVED
				</p>
      		</div>
		</footer><!-- End  Footer -->
</body>
</html>