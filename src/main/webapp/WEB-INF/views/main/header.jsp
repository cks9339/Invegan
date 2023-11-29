<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
 		<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> -->
<!-- 	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
       <!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<!-- 	  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->


<style>

@font-face {
    font-family: 'S-CoreDream-3Light';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/S-CoreDream-3Light.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}




* {
    font-family: 'S-CoreDream-3Light', sans-serif; 
}

body::-webkit-scrollbar {
    width: 0; /* 스크롤바 너비를 0으로 설정하여 숨깁니다. */
}

#header-container{
	height: 100px;
	width: 1000px;
	margin: 0 auto;
	position: relative;
	
}
.header-logoImg img{
	width: 126px;
    height: 104px;
}
.header-logoImg{
	position: fixed;
    left: 6px;
}
.header-logoImg img:hover{
	cursor: pointer;
}

.header-logoImg, .header-navbar, .loginInfo{
	display: inline-block;
}
.header-navbar{
	position: absolute;
    right: 0px;
    top: 53px;
}
.header-nav_list{
	list-style: none;
	display: flex;
	margin: 16px 0px;
	padding: 0px;
}
.header-nav_item{
	margin: 3px 10px;
}
.header-nav_item a{
	all: initial;
	font-size: 19px;
	font-weight: 600;
	
}
.header-nav_item a:hover{
	cursor: pointer;
	color:#95df95;
}

#header-loginBtn{
	position: absolute;
    right: 25px;
    top: 24px;
	cursor: pointer;
}
#header-loginBtn:hover{
	color:#95df95;
}

.loginInfo{
	position: fixed;
	right: 42px;
    top: 5px;
    z-index: 10;
}

.loginInfo p {
	display: inline-block;
	margin: 16px 0px !important;
	font-size: 18px;
    font-weight: 600;
}
#profileImg {
   width: 40px;
   height: 40px;
   border-radius: 50%;
   margin-right: 10px;
   position: relative;
   top: 12px;
   vertical-align: baseline !important;
}
#profileImg:hover{
	cursor: pointer;
}
.infoMB{
	width: 130px;
	background: white;
}
.infoModal{
	display: none;
	border-radius: 5px;
	box-shadow: gray 5px 5px 7px 0px;
	text-align: center;
}
.infoModal div{
	padding: 5px 10px;
	
}
.infoModal div:hover{
	cursor: pointer;
}
.infoModal div a{
	all: initial;
	cursor: pointer;
}

/*login Modal*/
.login-modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 99;
}


</style>
</head>
<body>
<header>

<div id="header-container">
	
		<div class = "header-logoImg">
			<img src="<c:url value='/resources/main/invegan_logo_master.png'/>"  alt="Logo Img" id="Logo"/>
		</div>
		<div class="header-navbar">
			<nav class="header-nav">
				<ul class="header-nav_list">
					<li class="header-nav_item"><a id="go_diet" href="<c:url value='/diet/dietCalander'/>">식단관리</a></li>
					<li class="header-nav_item" id="go_rest"><a href="<c:url value='/restaurant/list'/>">비건식당</a></li>
					<li class="header-nav_item"><a id="go_feed" href="<c:url value='/feed/list.go'/>">피드</a></li>
					<c:if test="${not empty loginInfo}">
						<li class="header-nav_item"><a id="go_myPage" href="<c:url value='/myPage/info.go'/>">MyPage</a></li>
					</c:if>
				</ul>
			</nav>
		</div>
		<div class="loginInfo">
			<!-- 로그인 안했을 때 -->
			<c:if test="${empty loginInfo}">
				<p id="header-loginBtn">Login</p>
			</c:if>
		
			<!-- 로그인 했을 때 -->
 			<c:if test="${not empty loginInfo}">
				<p><img id="profileImg" src="/photo/${loginInfo.getProfile_img()}" /></p>
				<p id="loginNickname">${loginInfo.getNickname()}</p>
				<p id="loginId">( ${loginInfo.getId()} )</p>
				<div class="infoMB">
					<div class="infoModal">
						<div class="infoModalList"><a href = "<c:url value='/member/logout'/>">로그아웃</a></div>
						<div class="infoModalList"><a href = "<c:url value='/myPage/info.go'/>">MyPage</a></div>
						<c:if test="${loginInfo.getIs_admin() eq '1'}">
							<div class="infoModalList_admin"><a href = "<c:url value='/diet/addMaterial.go'/>">식재료추가</a></div>
						</c:if>
					</div>
				</div> 
			</c:if>
		</div>
		<!-- 모달 창 -->
		<div id="login-modal" class="login-modal">
		    <div class="modal-content">
		        <c:import url="/member/login.go"/>
		    </div>
		</div>

</div>
		<hr style="border:1px solid darkgrey; color:darkgrey; margin:8px;"/>
</header>
<%-- 	<%@ include file="library.jsp" %> --%>
</body>

<script>

	/* 로그인 모달 */	
	$("#header-loginBtn").click(function openModal() {
       $("#login-modal").css("display", "block");
       $("body").css("overflow", "hidden");
       $('#login-id').focus();
   });

   // 로그인 모달 닫기 버튼 및 모달 바깥 부분 클릭 시 이벤트
   $("#closeModalBtn, .modal").click(function closeModal() {
       $("#login-modal").css("display", "none");
       $("body").css("overflow", "auto");
   });
   
   	

	// logo 클릭시 메인페이지
	$('#Logo').on('click',function(){
		location.href = '<c:url value='/'/>';
	});
	
	
	// 로그인 계정 메뉴바
	$(document).on('click', function(event) {
		var displayChk = $('.infoModal').css('display');
	    if (!$(event.target).closest('#profileImg').length) {
	        $('.infoModal').css({'display':'none'});
	    }else{
	    	if(displayChk == 'none'){
				$('.infoModal').css({'display':'block'});
	    	}else{
		        $('.infoModal').css({'display':'none'});
	    	}
	    }
	});
	// 로그인 계정 메뉴바 리스트 hover 효과	
	$('.infoModal div').hover(
		function () {
			$(this).find('a').css('color','#95df95');
		},
		function () {
			$(this).find('a').css('color','#000');
		}
	);

	/* $('#nav_item_categori').on('mouseover',function(){
		$('.nav_list_2').css({"display":"block"});	
	});
	$('#nav_item_categori').on('mouseout',function(){
		$('.nav_list_2').css({"display":"none"});	
	}); */

</script>
</html>