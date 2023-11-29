<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세보기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>

	#container{
		width: 1000px;
		margin: 0px auto;
	}
	
	.tabContainer {
	    display: flex;
	    justify-content: space-evenly;
	    align-items: baseline;
	    flex-direction: column;
	    position: relative;
	}
	
	ul.tabs{
		margin: 0px;
		padding: 0px;
		list-style: none;
	}
	ul.tabs li{
		background: none;
		color: #222;
		display: inline-block;
		padding: 10px 15px;
		margin: -3px;
		cursor: pointer;
		border: solid aquamarine;
		border-bottom: none;
	}
		
	ul.tabs li.current{
		background: white;
		color: black;
		width: 173px; 
	    height: 40px; 
	    line-height: 40px; 
	    font-weight: bold;
	    position: relative;
	}
	
	.tab-content{
			display: none;
			background: white;
			padding: 15px;
		}
		
		.tab-content.current{
			display: inherit;
		}
		
		.tab-1{
			display: flex;
			height: 102px;
	        width: 1200px;
	        right: -137px;
		    margin: 67px;
		    flex-wrap: inherit;
		    justify-content: space-evenly;
		    flex-direction: column;
		    align-items: baseline;
		    position: relative;
	}
	
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px 10px;
    }
    
    input[type="submit"]{
    	height: 50px;
    }    
    
</style>
</head>
<body>
<%-- <c:import url="/main/header"/> --%>
<div id="container">
	<h3>회원관리</h3>
	
	<c:set var="myPageImg" value="${dto.profile_image}" />
	<div class="profileContainer">

  	<div class="myPageImg">
        <img src="/photo/${myPageImg}" width="200" height="200">
    </div>
    
   	<div class="userInfo">
        <label>회원번호 :</label> ${dto.user_no}<br>
        <label>가입날짜 : </label> ${dto.join_date}<br>
        <label>아이디 : </label> ${dto.id}<br>
        <label>생년월일 : </label> ${dto.birthdate}<br>
        <label>관심사</label>${dto.interests}
        <input type="checkbox" name="interests" value="식당" id="interests1"/> 식당
		<input type="checkbox" name="interests" value="레시피" id="interest2"/> 레시피
		<input type="checkbox" name="interests" value="식품" id="interests3"/> 식품
		<input type="checkbox" name="interests" value="뷰티" id="interests4"/> 뷰티
		<input type="checkbox" name="interests" value="패션" id="interests5"/> 패션
		<input type="checkbox" name="interests" value="일상" id="interests6"/> 일상
    </div>
    
    <div class="is_admin">
	    <c:choose>
	        <c:when test="${dto.is_admin==1}">
	            관리자
	        </c:when>
	        <c:otherwise>
	            일반회원
	        </c:otherwise>
	    </c:choose>
    </div>
   
   	<div class="additionalInfo">
        <label>닉네임 : </label> ${dto.nickname}<br>
        <label>비건타입 : </label> ${dto.vegan_type}<br>
        <label>비건목적 </label><br>${dto.vegan_purpose}<br>
        
		<input type="hidden" name="id" value="${dto.id}"/>
		<input type="hidden" name="user_no" value="${dto.user_no}"/>

    </div>
	</div>
	
<div class="tabContainer">
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">정지관리</li>
		<li data-tab="tab-2">신고관리</li>
		<li data-tab="tab-3">요청관리</li>
		<li data-tab="tab-4">요청관리</li>
		<li data-tab="tab-5">게시글관리</li>
		<li data-tab="tab-6">댓글관리</li>
		<li data-tab="tab-7">리뷰관리</li>
	</ul>
	
	<div id="tab-1" class="tab-content current">
		
	</div>
	
	<div id="tab-2" class="tab-content">
		
	</div>
		
	<div id="tab-3" class="tab-content">
		
	</div>
	
	<div id="tab-4" class="tab-content">
		
	</div>
	
	<div id="tab-5" class="tab-content">
		
	</div>
	
	<div id="tab-6" class="tab-content">
		
	</div>
	
	<div id="tab-7" class="tab-content">
		
	</div>
	
	<!-- list 그리는 부분 -->
	<div id="ListContainer">
	</div>
	<div class="pageContainer">									
		<nav aria-label="Page navigation" style="text-align:center">
			<ul class="pagination" id="pagination"></ul>
		</nav>					
	</div>
</div>
</div>
<%-- <c:import url="/main/footer" />	 --%>
</body>
<script>
$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		
		$('#ListContainer').hide();
	});

});

</script>
</html>