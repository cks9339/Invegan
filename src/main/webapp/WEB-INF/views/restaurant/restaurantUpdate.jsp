<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
	.restaurantWriteTable {
/* 		border: 0.5px solid #30492a; */
		width: 1000px;
		margin: 0 auto;
	}
	.restaurantWriteHead{
		width: 20%;
		font-size: 30px;
	}
	.restaurantWriteCon{
		width: 80%;

	}
	.restaurnatInput{
		width: 100%;
		font-size: 20px;
		margin: 3px 3px;
	}
	textarea{
		height: 200px;
		margin: 3px 3px;
		resize: none;
		display: inline-block;
	}
	.restaurantImg{
		width: 800px;
		white-space: nowrap;
		overflow-x: scroll;
 		background-color: #CCFFCC;
 		border: 0.5px solid #30492a;
	}
	#preview{
		font-size: 2vw;
		text-align: center;
		align-items: center;
		overflow: hidden;
	}
	.divImg{
		position: relative;
		width: 304px;
		border: 0.5px solid #30492a;
		margin: 1px;
		padding: 2px;
		display: inline-block;
		overflow: hidden;
	}
	.previewImg{
		width: 300px;
		height: 300px;
	}
	.delImgButton{
		position: absolute;
		top: 3px;
		right: 3px;
		z-index: 10;
	}
	.nameImg{
		width: 100%;
		padding-top: 5px;
		padding-left: 5px;
		text-overflow: ellipsis;
		overflow: hidden;
	}
	.menuDiv {
		margin: 2px 0px;
		border: 0.5px solid #30492a;
	}
	.menuTable{
		width: 100%;
	}
	select{
		width: 100%;
	}
	.blank{
		margin-bottom: 200px;
	}
</style>
</head>
<body>
<c:import url="/main/header"/>

<table class = "restaurantWriteTable">
	<tr>
		<th class="restaurantWriteHead">식당 이름</th>
		<td class="restaurantWriteCon"><input class="restaurnatInput" type="text" name="title" value="${restaurant.getTitle()}"></td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">식당 주소</th>
		<td class="restaurantWriteCon">
			<button type="button" id="daumPostcode">주소 검색</button>
			<br/>
			<input class="restaurnatInput" type="text" name="address" value="${restaurant.getAddress()}"/>
		</td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">식당 소개</th>
		<td class="restaurantWriteCon"><textarea class="restaurnatInput" name="content">${restaurant.getContent()}</textarea></td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">연락처</th>
		<td class="restaurantWriteCon"><input class="restaurnatInput" type="text" name="phone" value="${restaurant.getPhone()}"/></td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">영업시간</th>
		<td class="restaurantWriteCon"><input class="restaurnatInput" type="text" name="hours" value="${restaurant.getHours()}"/></td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">등록된 사진</th>
		<td class="restaurantWriteCon">
			<div class="restaurantImg" id="restaurantImg_saved"><p id="preview">등록된 사진이 없습니다.</p></div>
		</td>
	</tr>
	<tr>
		<th class="restaurantWriteHead">사진 등록</th>
		<td class="restaurantWriteCon"><input type="file" name="images" id="restarunatWriteImg" multiple="multiple"/></td>
	</tr>
	<tr>
		<th class="restaurantWriteHead"></th>
		<td  class="restaurantWriteCon">
			<div class="restaurantImg" id="restaurantImg_upload"><p class="preview">등록된 사진이 없습니다.</p></div>
		</td>
	</tr>	
	<tr>
		<th class="restaurantWriteHead">메뉴 등록</th>
		<td class="restaurantWriteCon"><button id="menuAdd" type="button">메뉴 추가</button></td>	
	</tr>
	<tr>
		<th></th>
		<td class="restaurantWriteCon" id="menu"></td>
	</tr>
	<tr>
	<th colspan="2"><button type="button" id="write">수정</button>  <button type="button" id="cancle">취소</button></th>
	</tr>
</table>
<div class="blank"></div>
</body>

<script>

//header 카테고리 선택유지
$('#go_rest').css('box-shadow','#95df95 0px 2px 0px 0px');
//저장된 사진 불러오기
	var imgDelList = [];
	var $restaurantImg_saved = document.getElementById('restaurantImg_saved');

	var photoArr = []; //서버에서 받아온 사진 배열로 다시 담는 과정
	<c:forEach items="${photo}" var ='item'>
		photoArr.push("${item}");
	</c:forEach>
	console.log(photoArr);
	
	photoView(photoArr);
	
	function photoView(photoArr){
		if(photoArr.length >= 1){
			$restaurantImg_saved.innerHTML = '';
			for(var i = 0; i < photoArr.length; i++){
				var divTag = document.createElement('div');
				divTag.className = 'divImg';
				divTag.id = photoArr[i];
				$restaurantImg_saved.appendChild(divTag);
				
				var delButton = document.createElement('button');
				delButton.className = 'delImgButton';
				delButton.type= 'button';
				delButton.onclick = function(){savedDelImg(this);};
				delButton.textContent = '삭제';
				divTag.appendChild(delButton);
				
				var img = new Image();
				img.className = 'previewImg';
				img.src = '/photo/'+photoArr[i];
				divTag.appendChild(img);
			}
		}else{
			$restaurantImg_saved.innerHTML = '<p class="preview">등록된 사진이 없습니다.</p>';
		}
	}
	
	function savedDelImg(e){
		var delId = $(e).parent().attr('id');
		imgDelList.push(delId);
		for (var i = 0; i < photoArr.length; i++){
			if(photoArr[i] == delId){
				photoArr.splice(i, 1);
			}
		}
		/*
		console.log('imgDelList');
		console.log(imgDelList);
		console.log('photoArr');
		console.log(photoArr);
		console.log('-------------');
		*/
		photoView(photoArr);
	}
	
	
// 저장된 메뉴 불러오기
	<c:forEach items="${menu}" var ='item'>
		var menuContent = '<div class="menuDiv"><table class="menuTable"><tr><th>메뉴명</th><td>';
		menuContent += '<input class="restaurnatInput" type="text" name="menu_name" value="${item.getMenu_name()}"/></td>';
		menuContent += '<th rowspan="3"><button onclick="menuDel(this)">삭제</button></th></tr><tr><th>가격</th><td>';
		menuContent += '<input class="restaurnatInput" type="text" name="price" value="${item.getPrice()}"/></td></tr><tr><th>비건단계</th><td>';
		menuContent += '<select name="vegan_type"><option value="1">플루테리언</option><option value="2">비건</option>';
		menuContent += '<option value="3">락토</option><option value="4">오보</option><option value="5">락토오보</option>';
		menuContent += '<option value="6">폴로</option><option value="7">페스코</option><option value="8">폴로페스코</option>';
		menuContent += '<option value="9">플렉시테리언</option></select></td></tr></table></div>';
		$('#menu').append(menuContent);
		// console.log($('#menu').children().last().find($('select')));
		$('#menu').children().last().find($('select')).val('${item.getVegan_type()}').prop("selected", true);
	</c:forEach>

// 사진 업로드 관련
	var imgArr= [];
	var $restaurantImg_upload = document.getElementById('restaurantImg_upload');
	
	$('#restarunatWriteImg').on('change',function(){
		//console.log("img change 감지");
		var uploadImages = $('#restarunatWriteImg')[0].files;
		upload(uploadImages);
	});
	
	function upload(uploadImages){
		//console.log('upload 펑션 시작');
		//console.log(uploadImages);
		$restaurantImg_upload.innerHTML = '';
		imgArr= [];
		var imageType = 'image';
		for(var i = 0; i < uploadImages.length; i++){
			var imgFile = uploadImages[i];
			imgArr.push(imgFile);
	
			if(imgFile.type.includes('image')){
				var divTag = document.createElement('div');
				divTag.id = 'img_id_'+i;
				divTag.className = 'divImg';
				$restaurantImg_upload.appendChild(divTag);
				
				var img = new Image();
				img.className = 'previewImg';
				img.src = window.URL.createObjectURL(imgFile);
				divTag.appendChild(img);	
				
				var nameTag = document.createElement('div');
				nameTag.className = 'nameImg';
				nameTag.textContent = imgFile.name;
				divTag.appendChild(nameTag);
		
				var delButton = document.createElement('button');
				delButton.className = 'delImgButton';
				delButton.type= 'button';
				delButton.id = 'delButton_'+i;
				delButton.onclick = function(){delImg(this);};
				delButton.textContent = '삭제';
				divTag.appendChild(delButton);
			}else{
				alert('이미지 파일이 아닙니다');
				$('#restarunatWriteImg')[0].files = new DataTransfer().files;
				$restaurantImg.innerHTML='<p id="preview">등록된 사진이 없습니다.</p>';
				break;
			}
		}
		//console.log('upload 펑션 종료');
		//console.log(imgArr);
		}
		
	//업로드 사진 삭제
	function delImg(e){
		var idx = e.id[e.id.length -1];
		imgArr.splice(idx,1);
		//console.log('해당 이미지 삭제');
		//console.log(imgArr);
		var dataTranster = new DataTransfer();
		for(var i = 0; i < imgArr.length; i++){
			dataTranster.items.add(imgArr[i]);
		}
		$('#restarunatWriteImg')[0].files = dataTranster.files;
		//console.log($('#restarunatWriteImg')[0].files);
		upload($('#restarunatWriteImg')[0].files);
	}


// 메뉴 추가 삭제 
	$('#menuAdd').on('click',function(){
		var menuContent = '<div class="menuDiv"><table class="menuTable"><tr><th>메뉴명</th><td><input class="restaurnatInput" type="text" name="menu_name"/>';
			menuContent += '</td><th rowspan="3"><button onclick="menuDel(this)">삭제</button></th></tr><tr><th>가격</th><td>';
			menuContent += '<input class="restaurnatInput" type="text" name="price"/></td></tr><tr><th>비건단계</th><td>';
			menuContent += '<select name="vegan_type"><option value="1">플루테리언</option><option value="2">비건</option>';
			menuContent += '<option value="3">락토</option><option value="4">오보</option><option value="5">락토오보</option>';
			menuContent += '<option value="6">폴로</option><option value="7">페스코</option><option value="8">폴로페스코</option>';
			menuContent += '<option value="9">플렉시테리언</option></select></td></tr></table></div>';
		$('#menu').append(menuContent);
	});

	function menuDel(e){
		$(e).closest('div').remove();
	};


// 주소 검색
	$('#daumPostcode').on('click',function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	$('input[name="address"]').val(data.address);
	        }
	    }).open();	
	});

// 데이터 전송
$('#write').on('click',function(e){
	
	var $title = $('input[name="title"]');
	var $address = $('input[name="address"]');
	var $content = $('textarea[name="content"]');
	var $phone = $('input[name="phone"]');
	var $hours = $('input[name="hours"]');
	var $menu_name = $('input[name="menu_name"]');
	var $price = $('input[name="price"]');
	var $vegan_type = $('input[name="vegan_type"]');

	var blankcnt = 0;
	var len = $menu_name.length;

	if($title.val() == ''){
		swal({
	        title: "식당 이름을 입력해 주세요",
	        text: "",
	        icon: "info"
	    });
		blankcnt ++;
		$title.focus();
	}else if($address.val() == ''){
		swal({
	        title: "식당 주소를 입력해 주세요",
	        text: "",
	        icon: "info"
	    });
		blankcnt ++;
		$address.focus();
	}else if($content.val() == ''){
		swal({
	        title: "식당 소개를 입력해 주세요",
	        text: "",
	        icon: "info"
	    });
		blankcnt ++;
		$content.focus();
	}else if($phone.val() == ''){
		swal({
	        title: "식당 연락처를 입력해 주세요",
	        text: "",
	        icon: "info"
	    });
		blankcnt ++;
		$phone.focus();
	}else if($hours.val() == ''){
		swal({
	        title: "영업시간을 입력해 주세요",
	        text: "",
	        icon: "info"
	    });
		blankcnt ++;
		$hours.focus();
	}else{
		for(var i = 0; i < len; i++){
			if($menu_name.eq(i).val() == ''){
				swal({
			        title: "메뉴를 입력해 주세요",
			        text: "",
			        icon: "info"
			    });
				blankcnt ++;
				$menu_name.eq(i).focus();
				break;
			}else if($price.eq(i).val() == ''){
				swal({
			        title: "가격을 입력해 주세요",
			        text: "",
			        icon: "info"
			    });
				blankcnt ++;
				$price.eq(i).focus();
				break;
			}
			// price에 문자가 들어있는지
			var regex = new RegExp('[a-zA-Zㄱ-ㅎ가-힣]');
			var match = regex.test($price.eq(i).val()); // 패턴이 일치하면 true, 아니면 false
			if(match){
				swal({
			        title: "가격에 숫자만 입력해 주세요",
			        text: "",
			        icon: "info"
			    });
				blankcnt ++;
				break;
			}
		}
	}
	console.log("공백 및 패턴 확인 blankcnt : ");
	console.log(blankcnt);
	
	if(blankcnt == 0){
		var formData = new FormData();

		// 메뉴 배열-맵 묶기
		var menu = new Array(len);
		for(var i = 0; i < len; i++){
			menu[i] = new Array(3);
			menu[i][0] = $('input[name="menu_name"]').eq(i).val();
			menu[i][1] = $('input[name="price"]').eq(i).val();
			menu[i][2] = $('select[name="vegan_type"]').eq(i).val();
			console.log($('select[name="vegan_type"]').eq(i).val());
		}
		
		console.log(menu);
		
		// ajax 전송할 폼데이터
		var uploadImages = $('input[name="images"]')[0].files;
		console.log(uploadImages.length);
		for(var i = 0; i < uploadImages.length; i++){
			console.log(uploadImages[i]);
			formData.append('uploadImages', uploadImages[i]);
		}

		formData.append('post_id', '${restaurant.getPost_id()}');
		formData.append('title', $title.val());
		formData.append('address', $address.val());
		formData.append('content', $content.val());
		formData.append('phone', $phone.val());
		formData.append('hours', $hours.val());
		formData.append('menu', menu);
		formData.append('imgDelList', imgDelList);
		$.ajax({
			type:'post',
			url:'update.do',
			data:formData,
			contentType:false,
			processData:false,
			enctype : 'multipart/form-data',
			success: function (data) {
			    console.log(data);

			    swal({
			        title: data.결과,
			        text: "",
			        icon: "success"
			    }).then(() => {
			        location.href = 'detail?post_id=${restaurant.getPost_id()}';
			    });
			},
			error:function(e){
				console.log(e);
			}
		});	
	}
});

$('#cancle').on('click', function(){
	location.href = 'detail?post_id=${restaurant.getPost_id()}';
});


</script>

</html>













