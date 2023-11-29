<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 추가하기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<style>
	
	#container{
		width: 1200px;
	}
	ul{
		padding: 0;
	}
	li{
		display: inline-block;
	}
	#tapMenu{
	    padding: 9px;
   	    margin: 17px auto;
    	width: 96%;
		height: 30px;
		border-bottom: 1px solid black; 
		position: relative;
		text-align: center;
	}
	#close i{
		position: absolute;
    	top: 6px;
    	right: 19px;
	}
	#close i{
		cursor: pointer;
		background: none;
		border: none;
		font-size: 25px;
	} 
	.tap{
		display: inline-block;
		font-weight: 600;
	}
	
	.tap button{
		margin: 0 10px;
		padding: 5px;
		font-size: 18px;
		background: #FFF;
		border: none;
	}
	.tap button:hover{
		cursor: pointer;
		color: #95df95;
	}
	
	#vertical{
	    margin: 0px -5px;
		height: 15px;
		border-right: 2px solid gray;
		position: absolute;
		top:17px;
	}
	
	#contents{
		width: 100%;
		margin: 0 auto;
	}
	
</style>

</head>
<body> <!-- style="overflow-x:hidden; overflow-y:auto;" -->
	<div id="container">
	<input id="getDate" type=hidden value="${date} "/>
	<div id="tapMenu">
		<div class="tap">
			<button id="default" onclick="defaultMenu()">기본메뉴</button>
		</div>
		<div id="vertical" class="tap"></div>
		<div class="tap">
			<button id="myRecipe" onclick="myRecipeMenu()">나만의 레시피 메뉴</button>
		</div>
		<div id="close">
			<i class="xi-close" onclick="winClose()"></i>
		</div>
	</div>
	<div id="contents">
	
	</div>
	</div>
</body>
<script>
	var selectDate = $('#getDate').val();
	defaultMenu();
	
	function winClose() {
	    console.log("닫기 클릭");

	    swal({
	        title: "입력된 내용은 사라집니다",
	        text: "창을 닫으시겠습니까?",
	        icon: "warning",
	        buttons: ["아니오", "예"]
	    }).then((isConfirmed) => {
	        if (isConfirmed) {
	            self.close();
	        } else {
	        }
	    });
	}
	
	var menu_category;
	var recipe_name;

	
	function defaultMenu(){
		$('#default').css('box-shadow','#95df95 0px 2px 0px 0px');
		$('#myRecipe').css('box-shadow','#fff 0px 0px 0px 0px');
		$('#contents').load("<c:url value='defaultMenu.go'/>");
		menu_category = $('#default').text();
		recipe_name ='-';
	}
	
	function myRecipeMenu(){
		$('#myRecipe').css('box-shadow','#95df95 0px 2px 0px 0px');
		$('#default').css('box-shadow','#fff 0px 0px 0px 0px');
		$('#contents').load("<c:url value='../myRecipe/MyRecipeList.go'/>");
		menu_category = $('#myRecipe').text();
	}
	
	
	
</script>
</html>