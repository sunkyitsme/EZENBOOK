<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 페이지를 찾을 수 없습니다.</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,900" rel="stylesheet">
<style>
* {
  -webkit-box-sizing: border-box;
          box-sizing: border-box;
}

body {
  padding: 0;
  margin: 0;
}

#notfound {
  position: relative;
  height: 100vh;
}

#notfound .notfound {
  position: absolute;
  left: 50%;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
}

.notfound {
  max-width: 410px;
  width: 100%;
  text-align: center;
}

.notfound .notfound-404 {
  height: 280px;
  position: relative;
  z-index: -1;
}

.notfound .notfound-404 h1 {
  font-family: 'Montserrat', sans-serif;
  font-size: 230px;
  margin: 0px;
  font-weight: 900;
  position: absolute;
  left: 50%;
  -webkit-transform: translateX(-50%);
      -ms-transform: translateX(-50%);
          transform: translateX(-50%);
  background: url("../resources/assets/img/intro_bookstore.png") no-repeat;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-size: cover;
  background-position: center;
}


.notfound h2 {
  font-family: 'Montserrat', sans-serif;
  color: #000;
  font-size: 24px;
  font-weight: 700;
  text-transform: uppercase;
  margin-top: 0;
}

.notfound p {
  font-family: 'Nanum Gothic', sans-serif;
  color: #000;
  font-size: 14px;
  font-weight: 400;
  margin-bottom: 20px;
  margin-top: 0px;
}

.notfound a {
  font-family: 'Montserrat', sans-serif;
  font-size: 14px;
  text-decoration: none;
  text-transform: uppercase;
  background: #0046d5;
  display: inline-block;
  padding: 15px 30px;
  border-radius: 40px;
  color: #fff;
  font-weight: 700;
  -webkit-box-shadow: 0px 4px 15px -5px #0046d5;
          box-shadow: 0px 4px 15px -5px #0046d5;
}


@media only screen and (max-width: 767px) {
    .notfound .notfound-404 {
      height: 142px;
    }
    .notfound .notfound-404 h1 {
      font-size: 112px;
    }
}

</style>
</head>
<body>

	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h1>Oops!</h1>
			</div>
			<h2>404 - Page not found</h2>
			<p>주소를 확인 후, 다시 시도해주세요.<br>오류가 계속 되면 담당자에게 연락해주세요.</p>
			<a href="/main/main.do">Go To Homepage</a>
		</div>
	</div>

</body>

</html>
