<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>인비건 INVEGAN</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
	.banner{
    	border-radius: 10px;
	    background-color: #fff977;
	    width: 1000px;
	    height: 400px;
	    margin: 0 auto;
	}
	.main-content{
		margin: -35px 30px;
	}
	.custom{
		width: 1200px;
		height: auto;
		margin: 0 auto;
	}
	.customFilterArea{
		height: 80px;
		clear: both;
	}
	.customFilterArea a{
		all:initial;
		color:grey;
	}
	.customFilterArea a:hover{
		cursor: pointer;
		color : #000;
	}
	.cF_title{
		position: inherit;
		float: left;
		width: 300px;
		height: 30px;
		margin-left: 50px;
	}
	.cF_move{
		position: inherit;
		float: right;
		width: 100px;
		height: 30px;
		margin-top: 25px;
		margin-right: 50px;
	}
	.customFilterList{
		display: flex;
		flex-direction: row;
	}
	.customFilterButton{
		width: 90px;
		height: 90px;
		margin: 150px auto;
		text-align: center;
		font-size: 25px;
		font-weight: 600;
		cursor: pointer;
		color: grey;
	}
	.customFilterButton:hover{
		color:black;
		
	}
	.cFL_Res{
		position: relative;
		width : 328px;
		margin: 0px 2px;
		cursor: pointer;
	}
	.cFL_R_Img{
		width: 325px;
		height: 325px;
		background-color: #b1b1b1;
		margin: 0 auto;
	}
	.cFL_R_VT{
		position: absolute;
		top: 1px;
		margin: 0px;
		z-index: 10;
	}
	.cFL_R_VT div{
		box-shadow: #4f4f4f 3px 3px 4px 0px !important;
	    font-weight: 600;
	    border-radius: 8px;
	    height: 30px;
	    display: inline-block;
	    margin: 2px 2px;
	    padding: 0px 7px;
	    background-color: #c5e0b5;
	    line-height: 30px;
	    text-align: center;
		
	}
	.cFL_R_Name{
		text-align: center;
		font-weight: 600;
		font-size: 20px;
		margin: 0 0;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.cFL_Feed{
		border-radius: 6px;
   		border: 1px solid grey;
		position: relative;
		width : 328px;
		margin: 0px 2px;
		cursor: pointer;
	}
	.cFL_F_Head{
		padding: 6px 0px 0px 6px;
		align-items: center;
		display: flex;
		margin-bottom: 3px;
	}
	.cFL_F_Head p, .cFL_F_Head img{
		display: inline-block;
	}
	.cFL_F_Img{
		width: 325px;
		height: 325px;
		background-color: #b1b1b1;
		margin: 0 auto;
	}
	.cFL_F_Con{
		width: 100%;
	}
	.cFL_F_Text{
		width: 100%;
		height: 42px;
		overflow: hidden;
		text-overflow: ellipsis;		
	}
	.blank{
		margin-bottom: 200px;
	}

</style>
</head>
<body>

<c:import url="/main/header"/>


	<div class="banner"><img src='<c:url value="/resources/main/invegan_source01.png"/>' alt="banner_1" width="100%" height="100%"/>
	</div>
	<br>

	<!-- 맞춤 정보 제공 --> 
	<div class="custom">
		<!-- 식당 -->
		<div id="fist-content" class="main-content">
			<div class="customFilterArea">
				<!-- <div class="cF_title"><h2>추천 식당</h2></div> -->
				<div class="cF_move"><h3><a href="<c:url value='/restaurant/list'/>">더보기...</a></h3></div>
			</div>
			<div class="customFilterList">
				<div class="customFilterButton">
					<i class="fi fi-rr-angle-double-left" id="restaurantButtonL"></i>
				</div>
				<div class="cFL_Res">
					<div class="cFL_R_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_R_Con">
						<div class="cFL_R_Name"></div>
					</div>
					<div class="cFL_R_VT"></div>
				</div>
				<div class="cFL_Res">
					<div class="cFL_R_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_R_Con">
						<div class="cFL_R_Name"></div>
					</div>
						<div class="cFL_R_VT"></div>
				</div>
				<div class="cFL_Res">
					<div class="cFL_R_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_R_Con">
						<div class="cFL_R_Name"></div>
					</div>
						<div class="cFL_R_VT"></div>
				</div>
				<div class="customFilterButton">
					<i class="fi fi-rr-angle-double-right" id="restaurantButtonR"></i>
				</div>
			</div>
		</div>
		
		<!-- 피드 -->
		<div id="second-content" class="main-content">
			<div class="customFilterArea">
				<!-- <div class="cF_title"><h2>추천 피드</h2></div> -->
				<div class="cF_move"><p><a href="<c:url value='/feed/list.go'/>">더보기...</a></p></div>
			</div>
			<div class="customFilterList" id="restaurantList">
				<div class="customFilterButton">
					<i class="fi fi-rr-angle-double-left" id="feedButtonL"></i>
				</div>
				
				<div class="cFL_Feed" >
					<div class="cFL_F_Head">
						<img src="#" alt="ProfileImg" width="50px" height="50px" style="border-radius:50%; margin-right: 10px;"/>
						<p class="nickname"></p>
					</div>
					<div class="cFL_F_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_F_Con">
						<div class="cFL_F_Text"></div>
						<div class="cFL_F_Tag" style="margin-top: 20px; color: #808080;"></div>
					</div>
				</div>
				
				<div class="cFL_Feed" >
					<div class="cFL_F_Head">
						<img src="#" alt="ProfileImg" width="50px" height="50px" style="border-radius:50%; margin-right: 10px;"/>
						<p class="nickname"></p>
					</div>
					<div class="cFL_F_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_F_Con">
						<div class="cFL_F_Text"></div>
						<div class="cFL_F_Tag" style="margin-top: 20px; color: #808080;"></div>
					</div>
				</div>
				<div class="cFL_Feed " >
					<div class="cFL_F_Head">
						<img src="#" alt="ProfileImg" width="50px" height="50px" style="border-radius:50%; margin-right: 10px;"/>
						<p class="nickname"></p>
					</div>
					<div class="cFL_F_Img"><img src="#" alt="#" width="325px" height="325px"/></div>
					<div class="cFL_F_Con">
						<div class="cFL_F_Text"></div>
						<div class="cFL_F_Tag" style="margin-top: 20px; color: #808080;"></div>
					</div>
				</div>
					
				<div class="customFilterButton">
					<i class="fi fi-rr-angle-double-right" id="feedButtonR"></i>
				</div>
			</div>
		</div>
	</div>
		
	<div class="blank"></div>

</body>


<script>
var RFL;
var FFL
var r_idx = 0;
var f_idx = 0;
var r_length = 0;
var f_length = 0;

$('#login').on('click',function(){
	location.href='member/login.go';
});

$('#addMaterial').on('click',function(){
	location.href='diet/addMaterial.go';
});

//위치 관련
var geodata = {};
navigator.geolocation.getCurrentPosition(geoSuccess, getError);
function geoSuccess(position){
	geodata.lat = position.coords.latitude;
	geodata.lng = position.coords.longitude;
	geoSubmit(geodata);
}
function getError() {
	geodata.lat = 37.4765;
	geodata.lng = 126.8802;
	geoSubmit(geodata);
}
function geoSubmit(data){
	$.ajax({
		type:'post',
		url:'main/FL',
		data:data,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			RFL = data.RFL;
			FFL = data.FFL;
			r_length = RFL.length;
			f_length = FFL.length;
			console.log(RFL);
			console.log(FFL);
			restaurantListView(r_idx);
			feedListView(f_idx);
		},
		error:function(e){
			console.log(e);
		}
	});

}

function restaurantListView(idx){
	for (var i = 0; i < 3; i++) {
		if(RFL[i+idx] == null){
			$('.cFL_Res').eq(i).attr('post_id', 'null');
			$('.cFL_Res').eq(i).find($('img')).attr('src', '<c:url value="/resources/main/logo.png"/>');
			$('.cFL_Res').eq(i).find($('img')).attr('alt', '게시물 없음');
			$('.cFL_Res').eq(i).find($('.cFL_R_Name')).html('게시물 없음');
			$('.cFL_Res').eq(i).find($('.cFL_R_VT')).html('');
		}else{
			$('.cFL_Res').eq(i).attr('post_id',RFL[i+idx].post_id);
			$('.cFL_Res').eq(i).find($('img')).attr('src', '/photo/'+RFL[i+idx].server_file_name);
			$('.cFL_Res').eq(i).find($('img')).attr('alt', RFL[i+idx].title);
			$('.cFL_Res').eq(i).find($('.cFL_R_Name')).html(RFL[i+idx].title);
			var veganArr = RFL[i+idx].vegan.split(',');
			var vegan = [];
			veganArr.forEach(function(v, i){ // 비건 타입 중복 제거
				if(!vegan.includes(v)){
					vegan.push(v);
				}
			});
			var veganType = '';
			vegan.forEach(function(v, i){
				switch(v){
				case '1': veganType += '<div>#플루테리언</div>'; break;
				case '2': veganType += '<div>#비건</div> '; break;
				case '3': veganType += '<div>#락토</div> '; break;
				case '4': veganType += '<div>#오보</div> '; break;
				case '5': veganType += '<div>#락토오보</div> '; break;
				case '6': veganType += '<div>#폴로</div> '; break;
				case '7': veganType += '<div>#페스코</div>'; break;
				case '8': veganType += '<div>#폴로페스코</div>'; break;
				case '9': veganType += '<div>#플렉시테리언</div>'; break;
				}
			});
			$('.cFL_Res').eq(i).find($('.cFL_R_VT')).html(veganType);	
		}
	}
}

$('.cFL_Res').on('click',function(){
	console.log($(this).attr('post_id'));
	var post_id = $(this).attr('post_id');
	if(post_id != 'null'){
		location.href = 'restaurant/detail?post_id='+post_id		
	}
});

$('#restaurantButtonL').on('click',function(){
	if(r_idx == 0){
		r_idx = 9;
	}else{
		r_idx -= 3;
	}
	console.log(r_idx);
	restaurantListView(r_idx);
});
$('#restaurantButtonR').on('click',function(){
	if(r_idx == 9){
		r_idx = 0;
	}else{
		r_idx += 3;
	}
	console.log(r_idx);
	restaurantListView(r_idx);
});


function feedListView(idx){
	for (var i = 0; i < 3; i++) {
		if(FFL[i+idx] == null){
			$('.cFL_Feed').eq(i).attr('post_id','null');
			$('.cFL_Feed').eq(i).find('.cFL_F_Head').find($('img')).attr('src', '<c:url value="/resources/main/logo.png"/>');
			$('.cFL_Feed').eq(i).find('.cFL_F_Head').find($('p')).html('');
			$('.cFL_Feed').eq(i).find('.cFL_F_Img').find($('img')).attr('src', '<c:url value="/resources/main/logo.png"/>');
			$('.cFL_Feed').eq(i).find('.cFL_F_Img').find($('img')).attr('alt', '게시물 없음');
			$('.cFL_Feed').eq(i).find($('.cFL_F_Text')).html('<h2 style="margin: 6px;">게시물 없음</h2>');
			$('.cFL_Feed').eq(i).find($('.cFL_F_Tag')).html('');
		}else{
			$('.cFL_Feed').eq(i).attr('post_id',FFL[i+idx].post_id);
			if(FFL[i+idx].profile_image==null){
				$('.cFL_Feed').eq(i).find('.cFL_F_Head').find($('img')).attr('src', '<c:url value="/resources/main/profile.jpg"/>');
			}else{
				$('.cFL_Feed').eq(i).find('.cFL_F_Head').find($('img')).attr('src', '/photo/'+FFL[i+idx].profile_image);
			}
			$('.cFL_Feed').eq(i).find('.cFL_F_Head').find($('p')).html(FFL[i+idx].nickname);
			$('.cFL_Feed').eq(i).find('.cFL_F_Img').find($('img')).attr('alt', 'Feed Img(post_id:'+FFL[i+idx].post_id+')');
			$('.cFL_Feed').eq(i).find($('.cFL_F_Text')).html(FFL[i+idx].content);
			$('.cFL_Feed').eq(i).find($('.cFL_F_Tag')).html(FFL[i+idx].tag_content);
			if(FFL[i+idx].server_file_name == null){
				$('.cFL_Feed').eq(i).find('.cFL_F_Img').find($('img')).attr('src', '<c:url value="/resources/main/logo.png"/>');
			}else{
				$('.cFL_Feed').eq(i).find('.cFL_F_Img').find($('img')).attr('src', '/photo/'+FFL[i+idx].server_file_name);
			}
		}
	}
}


$('.cFL_Feed').on('click',function(){
	var post_id = $(this).attr('post_id');
	console.log(post_id);
	var nickname = $(this).find('.nickname').text();
	console.log('select nickname',nickname);
    location.href="feed/list.go/"+nickname+","+post_id;
});



$('#feedButtonL').on('click',function(){
	console.log(f_length);
	if(f_idx == 0){
		f_idx = 9;
	}else{
		f_idx -= 3;
	}		
	feedListView(f_idx);
});
$('#feedButtonR').on('click',function(){
	console.log(f_idx);
	if(f_idx == 9){
		f_idx = 0;
	}else{
		f_idx += 3;
	}
	feedListView(f_idx);
});

var clickImg = 0;
$('.banner').on('click',function(){
	var imgArr = ['invegan_source01.png','veganday.gif','vegan_type.jpeg','invegan_source03.jpg','signup-src.png','invegan_logo_master.png'];
	var len = imgArr.length;
	clickImg ++;
	if(clickImg >= len){
		clickImg -= len;
	}
	$('.banner').find('img').attr('src','./resources/main/'+imgArr[clickImg]);
});


var msg = "${msg}";
if(msg != ""){
	console.log(msg);
	swal({
  	    title: msg,
  	    text: "",
  	    icon: "success"
  	});
}

</script>
</html>