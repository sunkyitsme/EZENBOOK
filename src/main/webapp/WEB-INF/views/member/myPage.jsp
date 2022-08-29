<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>: 마이 페이지</title>
<!-- 다음 주소 API를 사용하기 위한 부분 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	$(function() {

		// id중복체크 변수, 비밀번호와 비밀범호 확인이 같은지 체크 변수 -> 전역 변수 선언
		var idCheck = false;
		var pwCheck = false;
		
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
		
		// 비밀번호 처리 이벤트
		$("#pw").keyup(function() {
			pwCheck = false;
			// $(this) == $("#pw")
			var pw = $(this).val();
			//alert(pw.length);
			// 4자 미만 처리
			if (pw.length < 4) {
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 4자 이상이여야 합니다.");
				return;
			}

			// 20자 초과 처리
			if (pw.length > 20) {
				$("#pwCheckDiv").removeClass("alert-success");
				$("#pwCheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호는 20자 이내이여야 합니다.");
				return;
			}

			// 4~20 사이 pw2와 같은지 체크
			var pw2 = $("#pw2").val();
			if (pw == pw2) {
				// 비밀번호와 비밀번호 확인이 같은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-danger");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").text("적당한 비밀번호입니다.");
				pwCheck = true;
			} else {
				// 비밀번호와 비밀번호 확인이 같지 않은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
				$("#pwCheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
				if (pw2.length < 4)
					$("#pw2CheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
				else if (pw2.length > 20)
					$("#pw2CheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
				else
					$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			}

		});
		// 비밀번호 확인 처리 이벤트
		$("#pw2").keyup(function() {
			pwCheck = false;

			// $(this) == $("#pw2")
			var pw2 = $(this).val();
			//alert(pw2.length);
			// 4자 미만 처리
			if (pw2.length < 4) {
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
				return;
			}

			// 20자 초과 처리
			if (pw2.length > 20) {
				$("#pw2CheckDiv").removeClass("alert-success");
				$("#pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
				return;

			}

			// 4~20 사이 pw와 같은지 체크
			var pw = $("#pw").val();
			if (pw == pw2) {
				// 비밀번호와 비밀번호 확인이 같은 경우
				$("#pw2CheckDiv, #pwCheckDiv").removeClass("alert-danger");
				$("#pw2CheckDiv, #pwCheckDiv").addClass("alert-success");
				$("#pw2CheckDiv, #pwCheckDiv").text("적당한 비밀번호입니다.");
				pwCheck = true;
			} else {
				// 비밀번호와 비밀번호 확인이 같지 않은 경우
				$("#pwCheckDiv, #pw2CheckDiv").removeClass("alert-success");
				$("#pwCheckDiv, #pw2CheckDiv").addClass("alert-danger");
				$("#pw2CheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
				if (pw.length < 4)
					$("#pwCheckDiv").text("비밀번호확인은 4자 이상이여야 합니다.");
				else if (pw.length > 20)
					$("#pwCheckDiv").text("비밀번호 확인은 20자 이내이여야 합니다.");
				else
					$("#pwCheckDiv").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			}

		});
		// 비밀번호 처리 이벤트의 끝
		
		// 회원 가입 이벤트
		$("#writeForm").submit(function(){
			
			// alert("아이디 체크 : " + idCheck + "\n비밀번호 체크 : " + pwCheck);
			
			// 비밀번호와 비밀번호 확인
			if(!pwCheck){
				alert("비밀번호와 비밀번호 확인의 길이가 4~20이여야 하고 같아야 합니다.");
				$("#pw").focus();
				// form 전송을 무시시킨다.
				return false;
			}
			
			// form 전송을 무시시킨다. -> 나중에 꼭 주석처리해야만 한다.
			// return false;
		});

	});// $(function(){}) 의 끝
	function execution_daum_address(){
		 
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        	 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;
                } else {
                	addr += ' ';
                }

             // 추가해야할 코드
                $(".address_input_1").val(data.zonecode);
                //$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
                $(".address_input_2").val(addr);
                //$("[name=memberAddr2]").val(addr);            // 대체가능
                // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
                $(".address_input_3").attr("readonly",false);
                 $(".address_input_3").focus();
            }
        }).open();
    }
</script>
<style type="text/css">
body {
	background-image: url("../resources/assets/img/intro_bookstore.png");
	background-size: cover;
	background-repeat: repeat-space;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 10px;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Montserrat", sans-serif;
}

.center {
  position: absolute;
  top: 60%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 400px;
	max-width: 700px;
	width: 100%;
	background-color: #fff;
	padding: 25px 30px;
	border-radius: 10px;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
}

.center .title {
	font-size: 25px;
	font-weight: 500;
	position: relative;
}

.center .title::before {
	content: "";
	position: absolute;
	left: 0;
	bottom: 0;
	height: 3px;
	width: 30px;
	border-radius: 5px;
	background: linear-gradient(135deg, #71b7e6, #9b59b6);
}

.content form .user-details {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	margin: 20px 0 12px 0;
}

form .user-details .input-box {
	margin-bottom: 15px;
	width: calc(100%/ 2 - 20px);
}

form .input-box span.details {
	display: block;
	font-weight: 500;
	margin-bottom: 5px;
}

.user-details .input-box input {
	height: 45px;
	width: 100%;
	outline: none;
	font-size: 16px;
	border-radius: 5px;
	padding-left: 15px;
	border: 1px solid #ccc;
	border-bottom-width: 2px;
	transition: all 0.3s ease;
}

.user-details .input-box input:focus, .user-details .input-box input:valid
	{
	border-color: #9b59b6;
}

form .gender-details .gender-title {
	font-size: 20px;
	font-weight: 500;
}

form .category {
	display: flex;
	width: 80%;
	margin: 14px 0;
	justify-content: space-between;
}

form .category label {
	display: flex;
	align-items: center;
	cursor: pointer;
}

form .category label .dot {
	height: 18px;
	width: 18px;
	border-radius: 50%;
	margin-right: 10px;
	background: #d9d9d9;
	border: 5px solid transparent;
	transition: all 0.3s ease;
}

#dot-1:checked ~ .category label .one, #dot-2:checked ~ .category label .two,
	#dot-3:checked ~ .category label .three {
	background: #9b59b6;
	border-color: #d9d9d9;
}

form input[type="radio"] {
 	display: none; 
 } 

form .button {
	height: 45px;
	margin: 35px 0
}

form .button input {
	height: 100%;
	width: 100%;
	border-radius: 5px;
	border: none;
	color: #fff;
	font-size: 18px;
	font-weight: 500;
	letter-spacing: 1px;
	cursor: pointer;
	transition: all 0.3s ease;
	background: linear-gradient(135deg, #71b7e6, #9b59b6);
}

form .button input:hover {
	/* transform: scale(0.99); */
	background: linear-gradient(-135deg, #71b7e6, #9b59b6);
}

@media ( max-width : 584px) {
	.center {
		max-width: 100%;
	}
	form .user-details .input-box {
		margin-bottom: 15px;
		width: 100%;
	}
	form .category {
		width: 100%;
	}
	.content form .user-details {
		max-height: 300px;
		overflow-y: scroll;
	}
	.user-details::-webkit-scrollbar {
		width: 5px;
	}
}

@media ( max-width : 459px) {
	.center .content .category {
		flex-direction: column;
	}
}

#footer {
	margin-top: 1300px;
	background: transparent;
}
</style>
</head>
<body>
	<div class="center">
		<h5 style="text-align:right;"><strong><a href="delete.do">회원탈퇴</a></strong></h5>
			<div class="title">MY PAGE</div> 
				<div class="content">
					<form action="update.do" method="post" id="writeForm">
						<div class="user-details">
							<div class="input-box">
								<span class="details">Name</span> <input id="name" name="name" value="${vo.name }" readonly>
							</div>
							<div class="input-box">
								<span class="details">Email</span> <input id="email" name="email" autocomplete="off" value="${vo.email }" placeholder="예)test@naver.com" required>
							</div>
							<div class="input-box">
								<span class="details">ID</span> <input id="id" name="id" pattern="[A-Za-z0-9]{4,20}" autocomplete="off" value="${vo.id }" readonly>
							</div>
							<div class="input-box">
								<span class="details">Birth</span> <input id="birth" name="birth" class="datepicker" autocomplete="off" placeholder="생년월일 입력" required >
							</div>
							<div class="input-box">
								<span class="details">PassWord</span> <input type="password"  id="pw" name="pw" pattern=".{4,20}" placeholder="변경할 비밀번호 입력" required>
									<div id="pwCheckDiv" class="alert alert-danger">PW는 4자 이상이어야 합니다.</div>
							</div>
							<div class="input-box">
								<span class="details">Address</span> <input class="address_input_1" type="text" id="addr1" name="addr1" placeholder="주소 입력" value="${vo.addr1 }" required>
									<div class="address_button" onclick="execution_daum_address()">
										<span class="btn btn-default btn-sm">주소 찾기</span>
									</div>
							</div>
							<div class="input-box">
								<span class="details">Confirm Password</span> <input type="password" id="pw2" class="form-control" required="required" pattern=".{4,20}" placeholder="비밀번호 입력 확인">
									<div id="pw2CheckDiv" class="alert alert-danger">PW 확인은 4자 이상이어야 합니다.</div>
							</div>
							<div class="input-box">
								<span class="details"></span> <input type="text" name="addr2" placeholder="상세주소 입력" class="address_input_2" value="${vo.addr2 }" required>
							</div>
							<div class="input-box">
								<span class="details">Phone Number</span> <input id="tel" name="tel" placeholder="예)010-1111-2222" autocomplete="off" value="${vo.tel }" required>
							</div>
							<div class="input-box">
								<span class="details"></span> <input type="text" placeholder="상세주소 입력" name="addr3" class="address_input_3" value="${vo.addr3 }" required>
							</div>
					</div> <!-- user-details의 끝 -->
					<div class="gender-details">
						<input type="radio" name="gender" id="dot-1" value="남자">
         				<input type="radio" name="gender" id="dot-2" value="여자">
							<span class="gender-title">Gender</span>
								<div class="category">
									<label for="dot-1"><span class="dot one"></span><input type="radio" class="dot one" name="gender" value="남자" checked="checked" /> 남자</label>
									<label for="dot-2"><span class="dot two"></span> <input type="radio" name="gender" value="여자" /> 여자</label>
								</div>
					</div><!-- gender-details의 끝 -->
					<div class="button">
						<input type="submit" value="Modify">
					</div>
					</form>
				</div><!-- content의 끝 -->
			</div><!-- center의 끝 -->
</body>
</html>