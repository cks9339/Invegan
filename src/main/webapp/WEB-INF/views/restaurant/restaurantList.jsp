<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
    
<style>	
	.restaurantListContainer{
		width: 1000px;
		margin: 0px auto;
	}
	.restaurantListHead{
		width: 100%;
	}
	#restaurantListHeadTitle{
		display: inline-block;
		width: 850px;
		font-weight: 600;
		font-size: 50px;
		margin: 10px 0px;
	}
	#writeButton{
		display: none;
		margin-top: 5px;
		margin-right: 20px;

	}
	.restarurantList{
		width: 100%;
	}
	.restaurantDiv{
		width: 100%;
		
	}
	.restaurantDiv_1{
		position: relative;	
		width: 24.5%;
		margin: 0px 2px 10px 2px;
		display: inline-block;
		cursor: pointer;
	}
	.restaurantImg{
		position: relative;
		width: 100%;
		height: 250px;
	}
	.Img{
		position: absolute;
		width: 100%;
		height: 250px;
	}
	.veganType{
		position: absolute;
		top: 1px;
		margin: 0px;
		z-index: 1;
	}
	.veganType div{
		box-shadow: #4f4f4f 3px 3px 4px 0px;
	    font-weight: 600;
	    border-radius: 8px;
		height: 24px;
		display: inline-block;
		margin: 2px 1px;;
		padding: 0px 4px;
		background-color: #bbe8b7;
		line-height: 24px;
		text-align: center;
	 	border: 0.5px solid #30492a;
	 	font-size: 12px;
	}
	.res_title{
		text-align: center;
		font-weight: 600;
		font-size: 25px;
		margin: 0 0;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.res_dist{
		text-align: center;
		font-size: 15px;
		margin: 0 0;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.pagination {
		justify-content: center;
	}
	.pageDiv{
		width: 100%;
		margin-top: 30px;
	}
	.pageDiv nav ul{
		margin: 0px auto;
	}
	.blank{
		margin-bottom: 200px;
	}
	.active a{
		background-color: grey;
	}
</style>

</head>
<body>
<c:import url="/main/header"/>
	<div class="restaurantListContainer">
		<div class="restaurantListHead">
			<div id="restaurantListHeadTitle">식당 리스트</div>
			<button id="writeButton" type="button" onclick="location.href='write.go'">식당 작성</button>
		</div>
		<div class="restarurantList">
			<div class="restaurantDiv">
				<div class="restaurantDiv_1">
					<div class="restaurantImg"><img class="Img" src="<c:url value='/resources/main/logo.png'/>"></div>
					<div class="res_title">게시물 없음</div>
					<div class="res_dist">-</div>
					<div class="veganType"></div>
				</div>
			</div>
		</div>
		<div class="pageDiv">
			<nav aria-label="Page navigation" style="text-align:center">
				<ul class="pagination" id="pagination"></ul>
			</nav>	
		</div>
	</div>
	<div class="blank"></div>
	
	
</body>
<script>
$('#go_rest').css('box-shadow','#95df95 0px 2px 0px 0px');


var showPage = 1;
var data;
callList(showPage);

function callList(showPage){
	$.ajax({
		type:'get',
		url:'restaurantListCall',
		data:{'page':showPage},
		dataType:'JSON',
		success:function(result){
			data = result;
			console.log(data);
			drawDiv(data.restaurantList.length);
			drawList(data);
		},
		error:function(e){
			console.log(e);
		}
	});
}

function drawDiv(len){
	var totalcontent = '<div class="restaurantDiv"></div>';
	var content = '<div class="restaurantDiv_1" onclick="restaurantClick(this)"><div class="restaurantImg"><img class="Img" src="#"></div>';
	content += '<div class="res_title">게시물 없음</div><div class="res_dist">-</div><div class="veganType"></div></div>';
	$('.restarurantList').html('');
	for(var i = 0; i < len; i++){
		// 0 4 8 
		if(i%4 == 0){
			$('.restarurantList').append(totalcontent)
		}
		$('.restaurantDiv').last().append(content);
	}
}



function drawList(data){
	if(data.admin == 'yes'){ // 작성 버튼 보여주는
		$('#writeButton').css({'display':'inline-block'});
	}else{
		$('#writeButton').css({'display':'none'});
	}
	data.restaurantList.forEach(function(restaurant, i){
		var veganType = ''
		var veganTypeArr = restaurant.vegan.split(',');
		veganTypeArr.forEach(function(v,idx){
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
		$('.restaurantDiv_1').eq(i).attr('post_id',restaurant.post_id);
		$('.restaurantDiv_1').eq(i).find($('.Img')).attr('src','/photo/'+restaurant.server_file_name);
		$('.restaurantDiv_1').eq(i).find($('.res_title')).html(restaurant.title);
		$('.restaurantDiv_1').eq(i).find($('.res_dist')).html('현재 위치와의 거리: '+restaurant.km+' Km');
		$('.restaurantDiv_1').eq(i).find($('.veganType')).html(veganType);
		
		if(restaurant.is_hidden == 1){
			var img = '<c:url value="/resources/main/hidden.png"/>';
			$('.restaurantDiv_1').eq(i).find($('.restaurantImg')).append(
					'<img class="restaurnatHidden" src="'+img+'" style="width:100%; height:250px; z-index:1,back-ground-color:grey; opacity:0.7"}/>'
			);
		}	
		
	});
	
	// 페이징 UI 그리기(플러그인 사용)
	$('#pagination').twbsPagination({
		startPage:showPage, // 보여줄 페이지
		totalPages:data.pages, // 총 페이지 수(총 갯수/페이지당 보여줄 게시물 수) : 서버에서 계산해서 가져와야함
		visiblePages:5,
		onPageClick:function(e,page){// 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){
				console.log(page);
				showPage = page;
				callList(page);
			}
		}
	});
};

function restaurantClick(e){
	var post_id = e.getAttribute('post_id');
	console.log(post_id);
	if(post_id != null){
		location.href = 'detail?post_id='+post_id;
	}
}


</script>
</html>