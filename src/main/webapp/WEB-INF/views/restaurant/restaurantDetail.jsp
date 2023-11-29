<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d1b7835be6802634d702664b5059fc0c&libraries=services"></script>
<style>
	.restaurantcontainer{
		width: 1000px;
		margin: 0px auto;
	}
	#restaurantTitle{
		display: flex;
		align-items: center
	}
	#restaurantTitle h1{
		display: inline-block;
	}
	#favorite{
		display: inline-block;
		width: 50px;
		height: 50px;
		cursor: pointer;
		margin-left: 20px;
	}
	
	.restaurantTop{
		width: 100%;
		position: relative;
		margin-bottom: 20px;
		min-height: 410px;
		
	}
	.restaurantImg_main{
		position: absolute;
		top: 5px;
		left: 0px;
		margin-bottom: 20px;
	}
	#img_main{
		position: absolute;
		width: 400px;
		height: 400px;		
	}
	.veganType{
		margin-bottom: 5px;;
	}
	.veganType div{
		box-shadow: #4f4f4f 3px 3px 4px 0px;
	    font-weight: 600;
	    border-radius: 8px;
		height: 28px;
		display: inline-block;
		margin: 2px 1px;;
		padding: 0px 4px;
		background-color: #bbe8b7;
		line-height: 28px;
		text-align: center;
	 	border: 0.5px solid #30492a;
	 	font-size: 17px;
	}
	.restaurantContent{
		display: inline-block;
		width: 600px;
		margin-left: 420px;
	}
	.restaurantcontainer h1{
		margin-top: 10px;
	}
	.restaurantContent h2, .restaurantContent h3 {
     	display: inline-block;
     	margin-right: 4px;
     	margin-bottom: 15px;
     }
   	.restaurantContent p {
   		margin-right: 4px;
   		margin-top: 0px;
   		margin-bottom: 0px;
     }
	.update_delete{
		position: absolute;
		top: 3px;
		right: 3px;
	}
	.restaurantMenuList{
		position: relative;
		width: 100%;
	}
	.menuTable {
		width: 100%;
		border: 0.5px solid #30492a;
		border-collapse: collapse;
		font-size: 20px;
		text-align: center;
	}
	.menuTable tr th{
		background-color: #bbe8b7;
		border: 1px solid black;
		border-collapse: collapse;
		text-align: center;
	}
	.menuTable tr td{
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	
	.restaurantImg{
		background-color: #bbe8b7;
		width: 1000px;
		margin: 0 auto;
		display: inline-block;
	}
	
	#imgList{
		width: 100%;
		display: inline-block;
	}
	.divImg{
		width: 325px;
		margin: 3px;
		display: inline-block;
	}
	.imgDetail{
		width: 100%;
		height: 325px;
	}
	
	.restaurantAddr{
		display: inline-block;
	    margin-right: 20px;
	    margin-top: 20px;
	}
	.restaurantMap{
		background-color: #bbe8b7;
		width: 1000px;
		height: 600px;
		margin: 0 auto;
	}
	#map{
		width: 1000px;
		height: 600px;
		border: 0.5px solid #30492a;
	}

     #blankdiv{
     	width: 100%;
     	height: 200px;
     }
</style>
</head>
<body>
<c:import url="/main/header"/>
<div class="restaurantcontainer">
	<div id="restaurantTitle">
		<h1>${restaurantDetail.getTitle()}</h1>
		<img id="favorite" 
			src="<c:if test='${favoriteChk eq 0}'><c:url value='/resources/main/favorite_X.png'/></c:if>
				<c:if test='${favoriteChk eq 1}'><c:url value='/resources/main/favorite_O.png'/></c:if>" 
			alt="favoriteIcon"/>
	</div>
	<div class="restaurantTop">
		<div class="restaurantImg_main"><img id="img_main" src = "/photo/${photoList[0]}" alt="restaurantImg"/></div>
		<div class="restaurantContent">
			<div class="veganType"></div>
			<h1>${restaurantDetail.getTitle()}</h1>			
			<h2>식당 위치</h2>
			<h3>${restaurantDetail.getAddress()}</h3><br>
			<h2>전화 번호  </h2>
			<h3>${restaurantDetail.getPhone()}</h3><br>
			<h2>영업 시간  </h2>
			<h3>${restaurantDetail.getHours()}</h3><br>
			<h2>식당 소개 </h2>
			<p>${restaurantDetail.getContent()}</p>
			<div></div>
		</div>
		<div class="update_delete">
			<c:if test="${admin eq 'yes'}">
				<button id="update">수정</button>
				<button id="hidden">
					<c:if test="${restaurantDetail.getIs_hidden() eq 0}">숨김</c:if>
					<c:if test="${restaurantDetail.getIs_hidden() eq 1}">숨김 해제</c:if>
				</button>
			</c:if>
		</div>
	</div>
	
	<h1>비건 메뉴</h1>
	<div class="restaurantMenuList">
		<table class="menuTable">
			<tr>
				<th>메뉴</th>
				<th>가격</th>
				<th>비건 단계</th>
			</tr>
<%-- 			<c:forEach items="${menuDetail}" var = "menu"> --%>
<!-- 				<tr> -->
<%-- 					<td width="50%">${menu.getMenu_name()}</td> --%>
<%-- 					<td width="25%">${menu.getPrice()}</td> --%>
<%-- 					<td width="25%">${menu.getVegan_type()}</td> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
		</table>
	</div>
	
	<h1>식당 사진</h1>
	<div id="restaurantImg">
		
		<div id="imgList"></div>
		<button id = "prevButton" class="btn btn-dark ">이전</button>
		<button id = "nextButton" class="btn btn-dark ">다음</button>
	</div>
	
	<div class="restaurantAddr"><h1>식당 위치</h1></div>
	<div class="restaurantAddr"><h2>${restaurantDetail.getAddress()}</h2></div>
	<div class="restaurantMap">
		<div id="map"></div>
	</div>
	
	<div id="blankdiv"></div>
</div>	
</body>

<script>
// header 카테고리 선택유지
$('#go_rest').css('box-shadow','#95df95 0px 2px 0px 0px');

var hidden = '${restaurantDetail.getIs_hidden()}';
if(hidden != 0){
	var img = '<c:url value="/resources/main/hidden.png"/>';
	$('.restaurantImg_main').append(
		'<img class="restaurnatHidden" src="'+img+'" style="width:400px; height:400px; z-index:1,back-ground-color:grey; opacity:0.7"}/>'
	);
}

var contents = $('.restaurantContent').find('p').html();
var splitCon = contents.replace(/\n/g, '<br>');
$('.restaurantContent').find('div').html(splitCon);
$('.restaurantContent').find('p').html('');

var veganArr = [];
var menuContent = '';
<c:forEach items="${menuDetail}" var = "menu" varStatus='i'>
 	var idx = '${i.index}';
	 switch ('${menu.getVegan_type()}') {
		case '1': v = '#플루테리언'; break;
		case '2': v = '#비건'; break;
		case '3': v = '#락토'; break;
		case '4': v = '#오보'; break;
		case '5': v = '#락토오보'; break;
		case '6': v = '#폴로'; break;
		case '7': v = '#페스코'; break;
		case '8': v = '#폴로페스코'; break;
		case '9': v = '#플렉시테리언'; break;
	}
	menuContent += '<tr><td width="50%">${menu.getMenu_name()}</td><td width="25%">${menu.getPrice()}</td>';
	menuContent += '<td width="25%">'+v+'</td></tr>';
 	if(!veganArr.includes(v)){
 		veganArr.push(v);
 	}
</c:forEach>
$('.menuTable').append(menuContent);
veganArr.sort();
var veganType = '';
veganArr.forEach(function(v,i){
	veganType += '<div>'+v+'</div>';
});
$('.veganType').html(veganType);






var $imgList = document.getElementById('imgList');
var photoArr = [];
<c:forEach items="${photoList}" var ='item'>
	photoArr.push("${item}");
</c:forEach>
console.log(photoArr);

var cnt = 0;
photoView(cnt);

function photoView(cnt){
	$imgList.innerHTML = '';
	for(var i = 0; i < 3; i++){
		var idx = cnt+i;
		if(idx < photoArr.length){
			var divTag = document.createElement('div');
			divTag.className = 'divImg';
			$imgList.appendChild(divTag);
			
			var img = new Image();
			img.className = 'imgDetail';
			var imgsrc = '/photo/'+photoArr[idx];
			console.log(imgsrc);
			img.src = imgsrc;
			divTag.appendChild(img);			
		}
	}	
}

$('#prevButton').on('click', function(){
	if(cnt > 0){cnt -= 3;}
	photoView(cnt);
});

$('#nextButton').on('click', function(){
	if(!(cnt + 3 >= photoArr.length)){cnt += 3;}
	photoView(cnt);
});


// 수정 컨펌
$('#update').on('click', function () {
    swal({
        title: "수정하시겠습니까?",
        text: "",
        icon: "info",
        buttons: ["아니오", "예"]
    }).then((isConfirmed) => {
        if (isConfirmed) {
            location.href = 'update.go?post_id=' + ${restaurantDetail.getPost_id()};
        } else {
            // 사용자가 '아니오'를 선택한 경우의 처리
        }
    });
});


// 숨김 컨펌
$('#hidden').on('click', function () {
    console.log('hidden click');
    // SweetAlert2를 사용하여 확인 대화 상자 표시
    swal({
        title: hidden == 0 ? "숨기시겠습니까?" : "숨김을 해제하시겠습니까?",
        text: "",
        icon: "info",
        buttons: ["아니오", "예"]
    }).then((isConfirmed) => {
        if (isConfirmed) {
            // 사용자가 '예'를 선택한 경우
            location.href = 'hidden?post_id=' + ${restaurantDetail.getPost_id()} + '&is_hidden=' + hidden;
        } else {
            // 사용자가 '아니오'를 선택한 경우
            console.log('숨김 취소 클릭');
        }
    });
});


// 즐겨찾기
$('#favorite').on("click",function(){
	console.log('즐겨찾기 클릭');
	var param = {};
	param.user_no = '${loginInfo.getUser_no()}';
	param.post_id = '${restaurantDetail.getPost_id()}';	
	$.ajax({
		type:'post',
		url:'favorite',
		data:param,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.result == '0'){
				$('#favorite').attr('src','<c:url value="/resources/main/favorite_X.png"/>');
			}else{
				$('#favorite').attr('src','<c:url value="/resources/main/favorite_O.png"/>');
			}
		},
		error:function(e){
			console.log(e);
		}
	});
});

//지도 부분
var title = '${restaurantDetail.getTitle()}'; // 식당 이름
var addr = '${restaurantDetail.getAddress()}'; // 식당 주소

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
    	center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    	level: 3 // 지도의 확대 레벨
	};

var map = new kakao.maps.Map(mapContainer, mapOption);

//주소-좌표 변환 객체 생성
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch(addr, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
     	
        map.setCenter(coords);
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        
		var infoContrn
		var iwContent = '<div style="width:150px; padding:5px; text-align: center; margin: 0 auto;">'+title+'<br>';
		iwContent += '<a href="https://map.kakao.com/link/search/'+addr+'" style="color:blue" target="_blank">큰지도보기</a>    ';
		iwContent += '<a href="https://map.kakao.com/link/to/'+addr+'" style="color:blue" target="_blank">길찾기</a></div>';
		
        // 인포윈도우로 장소에 대한 설명을 표시합니다
		var infowindow = new kakao.maps.InfoWindow({
            map: map,
            position: coords,
           	content: iwContent
		});
        infowindow.open(map, marker);
    } 
});


</script>
</html>