<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 500 Error Page</title>
</head>
<body>
	<div class="container" style="margin-top:100px;">
		<h1 style="text-align: center">
			<strong>에러 페이지</strong>
		</h1>
		<hr>
		<br />
		<div class="alert alert-danger">${exception.message }</div>
		<ul class="list-group">
		<c:forEach items="${exception.stackTrace }" var="stack">
			<li class="list-group-item">${stack }</li>
		</c:forEach>
		</ul>
	</div>
</body>
</html>