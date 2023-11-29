<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>

<title>Insert title here</title>
<!-- <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script> -->
<style>

#container{
	width: 1000px;
	margin: 0 auto;
}
#loginArea{
	border-radius: 5px;
	position:fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 549px;
    height: 416px;
    margin: 0 auto;
    background-color: white;
}
#login-txt{
	width: 50%;
	margin: 10px auto;
	text-align: center;

}
#login-box{
	position: relative;
	left:108px;
	padding: 0px 30px;
	text-align: center;
	border-collapse: separate;
}
#login-box input{
	width: 190px;
    height: 40px;
    font-size: 15px;
    font-weight: 600;
    padding-left: 10px;
    padding-right: 20px;
    border: none;
    border-bottom: 2px solid #a8dca8;
    margin: 5px;
    outline: none;
    text-align: center;
}
#login-btn-box{
	text-align: center;
}
#loginBtn, #signupBtn{
	background: none;
	border: none;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	display: inline-block;
	margin: 0 auto;
}
#loginBtn:hover, #signupBtn:hover{
	color:#95df95;
}
#login-logo{
	margin: 45px;
	text-align: center; 
}
#login-logo img{
    width: 139px;
    height: 125px;
}
#bottom-box{
	position: absolute;
	bottom: 20px;
    right: 188px;
    
}
#findIdPw{
	background: none;
	border: none;
	font-size: 13px;
	font-weight: 600;
	cursor: pointer;
}
#findIdPw:hover{
	color: #95df95;
}


.login-close{
    font-size: 47px;
    color: #010101;
    z-index: 5;
    cursor: pointer;
    position: absolute;
    top: -2%;
    left: 92%;
}
</style>
</head>
<body>
	<div id="container">
		<div id="loginArea">
		 	<div id="login-logo">
				<img alt="invegan-logo" src="<c:url value='/resources/main/invegan_logo_master.png'/>">
			<span class="login-close" id="closeModalBtn">&times;</span>
			</div>
			<span class="login-close" id="closeModalBtn">&times;</span>
			<form action="member/login" method="post">
				<table id="login-box">
					<tr>
						<th>ID : </th>
						<td><input id="login-id" type="text" name="id" /></td>
					</tr>
					<tr>
						<th>PW : </th>
						<td><input type="password" name="pw" /></td>
					</tr>
				</table>
				<div id="login-btn-box">
					<button id="loginBtn">Login</button>
					<button id="signupBtn" type="button" onclick="goSignUp()">SignUp</button>
				</div>
				<div id="bottom-box">
					<button id="findIdPw" type="button" onclick="goFindIdPw()">forgot your id / password?</button>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
		
	function goSignUp() {
		console.log('회원가입 페이지 진입');
		location.href = 'member/signup.go';
	};

	function goFindIdPw(){
		console.log('아이디 비밀번호 찾기 페이지 진입');
		location.href = 'member/find';
	};

	var msg = "${msg}";
	if (msg != "") {
		swal({
		    title: msg,
		    icon: "warning" //"info,success,warning,error" 중 택1
		});
	}
</script>
</html>