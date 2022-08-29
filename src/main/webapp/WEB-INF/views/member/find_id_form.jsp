<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 아이디 찾기</title>
<style type="text/css">
body {
	background-image: url("../resources/assets/img/intro_bookstore.png");
	background-size: cover;
	background-repeat: no-repeat;
}

.center {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 400px;
	background: white;
	border-radius: 10px;
	box-shadow: 10px 10px 15px rgba(0, 0, 0, 0.05);
}

.center h1 {
	text-align: center;
	padding: 20px 0;
	border-bottom: 1px solid silver;
}

.center form {
	padding: 0 40px;
	box-sizing: border-box;
}

form .txt_field {
	position: relative;
	border-bottom: 2px solid #adadad;
	margin: 30px 0;
}

.txt_field input {
	width: 100%;
	padding: 0 5px;
	height: 40px;
	font-size: 16px;
	border: none;
	background: none;
	outline: none;
}

.txt_field label {
	position: absolute;
	top: 50%;
	left: 5px;
	color: #adadad;
	transform: translateY(-50%);
	font-size: 16px;
	pointer-events: none;
	transition: .5s;
}

.txt_field span::before {
	content: '';
	position: absolute;
	top: 40px;
	left: 0;
	width: 0%;
	height: 2px;
	background: #2691d9;
	transition: .5s;
}

.txt_field input:focus ~ label, .txt_field input:valid ~ label {
	top: -5px;
	color: #2691d9;
}

.txt_field input:focus ~ span::before, .txt_field input:valid ~ span::before
	{
	width: 100%;
}

.pass {
	margin: -5px 0 20px 5px;
	color: #a6a6a6;
	cursor: pointer;
}

.pass:hover {
	text-decoration: underline;
}

button[type="submit"] {
	width: 100%;
	height: 50px;
	border: 1px solid;
	background: #2691d9;
	border-radius: 25px;
	font-size: 18px;
	color: #e9f4fb;
	font-weight: 700;
	cursor: pointer;
	outline: none;
}

button[type="submit"]:hover {
	border-color: #2691d9;
	transition: .5s;
}

button[type="button"] {
	width: 100%;
	height: 50px;
	border: 1px solid;
	background: #2691d9;
	border-radius: 25px;
	font-size: 18px;
	color: #e9f4fb;
	font-weight: 700;
	cursor: pointer;
	outline: none;
}

button[type="button"]:hover {
	border-color: #2691d9;
	transition: .5s;
}

.signup_link {
	margin: 30px 0;
	text-align: center;
	font-size: 16px;
	color: #666666;
}

.signup_link a {
	color: #2691d9;
	text-decoration: none;
}

.signup_link a:hover {
	text-decoration: underline;
}

#footer {
	margin-top: 850px;
	background: transparent;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#find_id_btn").click(function() {
			location.href = "../member/find_id_form.do";
		});
	});
</script>
</head>
<body>
	<div class="center">
		<h1>ID FIND</h1>
		<form action="../member/find_id.do" method="post">
			<div class="txt_field">
				<input name="email" id="email" autocomplete="off" required>
					<span></span> <label>Email</label>
			</div>
			<p>
				<button type="submit" id=findBtn>Find</button>
				<button type="button" onclick="history.go(-1);">Cancel</button>
			</p>
		</form>
	</div>
</body>
</html>