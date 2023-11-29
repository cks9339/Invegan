<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Invegan - 식단관리</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>


#defaultMenuBox{
	margin: 0 auto;
    width: 94%;	
    height : 600px;
	overflow: hidden;
}
#listArea, #showNutri, #contents-vertical{
	display: inline-block;
}
#listArea {
    width: 72%;
    height: 600px;
}

/* 식품 검색 구역*/

#left-top-box{
	position: relative;
	white-space :nowrap;
}
#left-top-box div{
	display: inline-block;
}

/* 카테고리 선택 버튼*/
#cateBtn button{
	background: none;
	padding: 8px 13px;
	font-size: 17px;
	margin: 16px 3px;
	border: 1.5px solid gray;
	color: gray;
	border-radius: 5px;
	box-shadow: lightgray 5px 4px 7px 1px;
	outline-color: #9eca9e;
}
#cateBtn button:hover{
	cursor: pointer;
	color: #9eca9e;
}
#cateBtn button:active{
	cursor: pointer;
	box-shadow: lightgray 3px 2px 9px 0px;
	position: relative;
	top:1px;
	left: 1px;
	
}
/*식품 검색 박스*/
#search{
	width: 279px;
    position: absolute;
    right: 163px;
}
#searchBox{
	outline-color: #9eca9e;
    padding-left: 10px;
    margin: 16px 3px;
    width: 260px;
    height: 34px;
    font-size: 18px;
    font-weight: 600;
    border: 1.5px solid gray;
    border-radius: 5px;
}
#search button{
	padding-left: 11px;
    border: none;
    border-left: 1.5px solid gray;
    height: 34px;
    background: none;
    font-size: 20px;
    position: relative;
    top:2px;
    right: 55px;
}
#search button:hover{
	cursor: pointer;
	color:#9eca9e;
}
/*중량 입력 박스*/
#gramBox{
	font-size: 22px;
	font-weight: 600;
	position: absolute;
	right: 92px;
}
#gramBox input{
	outline-color: #9eca9e;
	padding-left:8px;
	margin: 16px 3px;
	width: 40px;
	height: 33px;
	font-size:18px;
	font-weight: 600;
	border:1.5px solid gray;
	border-radius: 5px;
}
/*완료 버튼*/
#addBtn{
	background: none;
	padding: 6px 10px;
	font-size: 17px;
	margin: 16px 3px;
	border-radius: 5px;
	border: 1.5px solid black;
	box-shadow: lightgray 5px 4px 7px 1px;
	outline-color: #9eca9e;
	position: absolute;
	top: 2px;
	right: 1px;
}
#addBtn:hover{
	cursor: pointer;
	color: #9eca9e;
	border: 1.5px solid #9eca9e;
}
#addBtn:active{
	box-shadow: lightgray 3px 2px 9px 0px;
	border: 1.5px solid #9eca9e;
	color: #9eca9e;
 	position: absolute;
	top:3px;
	right: 0px;
	
}

/* 식품 검색 리스트*/
#listBox { 	
	height: 500px;
	overflow: auto;
    overflow-x: hidden;
}

#listBox::-webkit-scrollbar{
	width: 3px;
}
#listBox::-webkit-thumb{
	width: 3px;
}
#listBox::-webkit-track{
	width: 3px;
} 

#foodListHead th {
	padding: 3px 10px;
    height: 25px;
    border: 1.3px solid #59b879;
    border-radius: 3px;
    white-space :nowrap;
    position: sticky;
	top: 0px;
	background-color: white;
}
#msg {
	text-align: center;
}

#foodList {
	white-space: normal;
	border-collapse: collapse;
	text-align: center;
}
.foodItem td{
}
.foodItem:hover {
	cursor: pointer;
	box-shadow:  #59B879 0px 0px 5px 1px;
}



/*가로줄*/
#contents-vertical{
	height: 558px;
    margin: 0px 15px;
    border-right: 1.5px solid gray;
    position: relative;
   	left : 820px;
	bottom : 560px;
}

/*영양소 구역*/
#showNutri{
	position: absolute;
	right : 58px;
	top : 89px;
}
#showNutri table{
	width: 265px;
	height: 570px;
	padding: 5px;
	white-space: normal;
}
#showNutri td:nth-child(odd) {
    text-align: right;
    padding-right: 5px;
}
#showNutri td:not(:first-child):nth-child(even) {
    text-align: left;
    padding-left: 5px;
}
#food_name {
	text-align: center;
	width: 200px;
}
#food_name h3{
	width: 97%;
	margin: 0 5px 10px 5px;
	padding: 10px 5px;
	box-shadow: #95df95 0px 2px 0px 0px;
	text-align: center;
	
}


</style>
</head>
<body>
	<div id="defaultMenuBox">
		<div id="listArea">
			<div id="left-top-box">
				<div id="cateBtn">
					<button id="breakfast" onclick="meal(this)">아침</button>
					<button id="lunch" onclick="meal(this)">점심</button>
					<button id="dinner" onclick="meal(this)">저녁</button>
					<button id="etc" onclick="meal(this)">기타</button>
				</div>
				<div id="search">
					<input id=searchBox type="text" placeholder="식품 검색" />
					<button type="button" onclick="searchFood()">
						<i class="xi-search"></i>
					</button>
				</div>
				<div id="gramBox">
					<input id="gBox" name="gram" type="text" />g
				</div>
				<button id="addBtn" onclick="addMenu()">완료</button>
			</div>
			<div id="listBox">
				<table id="foodListHead">
					<colgroup>
							<col width="4%">
							<col width="40%">
							<col width="15%">
							<col width="20%">
							<col width="12%">
							<col width="9%">
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>식품명</th>
							<th>분류</th>
							<th>제조사</th>
							<th>제공량(g)</th>
							<th>kcal</th>
						</tr>
					</thead>
					<tbody id="foodList">
						<!-- 검색결과 영역 -->
					</tbody>
				</table>
			</div>
			<div id="contents-vertical"></div>
			<div id="showNutri">
				<table>
					<colgroup>
						<col width="60%"/>
						<col width="40%"/>
					</colgroup>
					<tr>
						<td colspan="2" id="food_name"><h3>식품을 선택해주세요</h3></td>
					</tr>
					<tr>
						<td>1회 제공량</td>
						<td id="serving_size">0 g</td>
					</tr>
					<tr>
						<td>kcal</td>
						<td id="kcal">0 kcal</td>
					</tr>
					<tr>
						<td>탄수화물</td>
						<td id="carb">0 g</td>
					</tr>
					<tr>
						<td>단백질</td>
						<td id="prot">0 g</td>
					</tr>
					<tr>
						<td>지방</td>
						<td id="fat">0 g</td>
					</tr>
					<tr>
						<td>총 당류</td>
						<td id="sugar">0 g</td>
					</tr>
					<tr>
						<td>총 식이섬유</td>
						<td id="fiber">0 g</td>
					</tr>
					<tr>
						<td>칼슘</td>
						<td id="ca">0 mg</td>
					</tr>
					<tr>
						<td>철</td>
						<td id="fe">0 mg</td>
					</tr>
					<tr>
						<td>마그네슘</td>
						<td id="mg">0 mg</td>
					</tr>
					<tr>
						<td>인</td>
						<td id="p">0 mg</td>
					</tr>
					<tr>
						<td>칼륨</td>
						<td id="k">0 mg</td>
					</tr>
					<tr>
						<td>나트륨</td>
						<td id="na">0 mg</td>
					</tr>
					<tr>
						<td>아연</td>
						<td id="zn">0 mg</td>
					</tr>
					<tr>
						<td>비타민A</td>
						<td id="vit_a">0 µg</td>
					</tr>
					<tr>
						<td>비타민B6</td>
						<td id="vit_b6">0 mg</td>
					</tr>
					<tr>
						<td>비타민B12</td>
						<td id="vit_b12">0 mg</td>
					</tr>
					<tr>
						<td>비타민C</td>
						<td id="vit_c">0 mg</td>
					</tr>
					<tr>
						<td>필수 아미노산</td>
						<td id="essential">0 mg</td>
					</tr>
					<tr>
						<td>오메가3</td>
						<td id="omega3">0 g</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<script>
	var foodId = 0;
	;
	var diet_category = ''; // 아침/ 점심 /저녁/ 기타
	var gram = 0;
	
	// 식품 검색창 입력후 enter key로 식품 검색 함수 호출
	$("#searchBox").on('keyup', function (e) {
        if (e.key === 'Enter' || e.keyCode === 13) {
            searchFood();
        }
    });
	

	function addMenu() {
		gram = $('#gBox').val();
		console.log('foodId : ' + foodId + " / diet_category : "
				+ diet_category + " / gram : " + gram);
		if (diet_category == "") {
			swal({
            	    title: "아침 / 점심 / 저녁 / 기타 중에 선택해 주세요",
            	    text: "",
            	    icon: "info"
            	});
		} else if (foodId == "") {
			swal({
        	    title: "식품을 선택해주세요",
        	    text: "",
        	    icon: "info"
        	});
			$('#searchBox').focus();
		} else if (gram == 0) {
			swal({
        	    title: "선택한 식품의 섭취량을 입력해주세요",
        	    text: "",
        	    icon: "info"
        	});
		} else if (isNaN(gram)) {
			swal({
        	    title: "중량에는 숫자만 입력해주세요",
        	    text: "",
        	    icon: "info"
        	});
		} else {
		    swal({
		        title: $('#food_name').text() + " " + gram + "g 을 " + diet_category + "에 추가하시겠습니까?",
		        text: "",
		        icon: "info",
		        buttons: ["아니오", "네"]
		    }).then((isConfirmed) => {
		        if (isConfirmed) {
		            var params = {};
		            params.select_date = selectDate;
		            params.food_id = foodId;
		            params.diet_category = diet_category;
		            params.menu_category = menu_category;
		            params.recipe_name = recipe_name;
		            params.gram = gram;

		            $.ajax({
		                type: 'get',
		                url: 'addMenu.do',
		                data: params,
		                dataType: 'JSON',
		                success: function (data) {
		                    opener.location.reload();
		                    self.close();
		                },
		                error: function (data) {
		                    // 오류 처리 코드
		                }
		            });
		        } else {
		            flag = false;
		        }
		    });
		}
		

	}

	function meal(obj) {
		diet_category = $(obj).text();
		if (diet_category === '아침') {
			$('#breakfast').css({'border':'1.5px solid #9eca9e','color':'#9eca9e'});
			$('#lunch').css({'border':'1.5px solid gray','color':'gray'});
			$('#dinner').css({'border':'1.5px solid gray','color':'gray'});
			$('#etc').css({'border':'1.5px solid gray','color':'gray'});
			$('#searchBox').focus();
		} else if (diet_category === '점심') {
			$('#breakfast').css({'border':'1.5px solid gray','color':'gray'});
			$('#lunch').css({'border':'1.5px solid #9eca9e','color':'#9eca9e'});
			$('#dinner').css({'border':'1.5px solid gray','color':'gray'});
			$('#etc').css({'border':'1.5px solid gray','color':'gray'});
			$('#searchBox').focus();
		} else if (diet_category === '저녁') {
			$('#breakfast').css({'border':'1.5px solid gray','color':'gray'});
			$('#lunch').css({'border':'1.5px solid gray','color':'gray'});
			$('#dinner').css({'border':'1.5px solid #9eca9e','color':'#9eca9e'});
			$('#etc').css({'border':'1.5px solid gray','color':'gray'});
			$('#searchBox').focus();
		} else if (diet_category === '기타') {
			$('#breakfast').css({'border':'1.5px solid gray','color':'gray'});
			$('#lunch').css({'border':'1.5px solid gray','color':'gray'});
			$('#dinner').css({'border':'1.5px solid gray','color':'gray'});
			$('#etc').css({'border':'1.5px solid #9eca9e','color':'#9eca9e'});
			$('#searchBox').focus();
		}
	}

	function searchFood() {
		var keyword = $('#searchBox').val().trim();

		if (keyword == '') {
			$('#searchBox').val('');
		} else {
			console.log(keyword);

			$.ajax({
				type : 'get',
				url : 'searchFood',
				data : {
					'keyword' : keyword
				},
				dataType : 'JSON',
				success : function(data) {
					drawList(data);
					console.log(data.success);
				},
				error : function(e) {
					console.log(e);
				}
			});
		}
	};

	function drawList(data) {
		var content = '';

		if (data.success === 0) {
			$('#foodList').empty();
			$('#msg h3').css('display', 'block');
			$('#msg h3').html("검색 결과가 없습니다");
			console.log($('#msg h3').css());
			console.log($('#msg h3').html());
		} else {
			data.findFoodList
					.forEach(function(item, idx) {
						content += '<tr class="foodItem" onclick="selectFood(this)">';
						content += '<td style="display:none"><input type="text" class="foodId" value="'+item.food_id+'"/></td>';
						content += '<td width="51.91px">' + (idx + 1) + '</td>';
						content += '<td width="40%">' + item.food_name + '</td>';
						content += '<td width="15%">' + item.food_category + '</td>';
						content += '<td width="155.48px">' + item.production + '</td>';
						content += '<td width="12%">' + item.serving_size + '</td>';
						content += '<td width="9%">' + item.kcal + '</td>';
						content += '</tr>';
					}); 	
		}
		$('#msg h3').css('display', 'none');
		$('#foodList').empty();
		$('#foodList').append(content);
	};

	function selectFood(obj) {
		foodId = $(obj).find('.foodId').val();
		
		$('.foodItem').css('background', 'none');
		$(obj).css('background-color', 'rgb(115 211 147 / 19%)');

		$('#gBox').focus();

		$.ajax({
			type : 'get',
			url : 'showNutri',
			data : {
				'foodId' : foodId
			},
			dataType : 'JSON',
			success : function(data) {
				var nutri = data.showNutri;
				drawNutri(nutri);
				$('#gBox').val(nutri.serving_size);
			},
			error : function(e) {
				console.log(e);
			}
		});
	};

	function drawNutri(nutri) {
		if (nutri != null) {

			$('#food_name').empty();
			$('#food_name').html('<h3>'+nutri.food_name+'</h3>');
			$('#serving_size').empty();
			$('#serving_size').html(nutri.serving_size + " g");
			$('#kacl').empty();
			$('#kcal').html(nutri.kcal + " kcal");
			$('#carb').empty();
			$('#carb').html(nutri.carb + " g");
			$('#prot').empty();
			$('#prot').html(nutri.prot + " g");
			$('#fat').empty();
			$('#fat').html(nutri.fat + " g");
			$('#h2o').empty();
			$('#h2o').html(nutri.h2o + " g");
			$('#sugar').empty();
			$('#sugar').html(nutri.sugar + " g");
			$('#fiber').empty();
			$('#fiber').html(nutri.fiber + " g");
			$('#ca').empty();
			$('#ca').html(nutri.ca + " mg");
			$('#fe').empty();
			$('#fe').html(nutri.fe + " mg");
			$('#mg').empty();
			$('#mg').html(nutri.mg + " mg");
			$('#p').empty();
			$('#p').html(nutri.p + " mg");
			$('#k').empty();
			$('#k').html(nutri.k + " mg");
			$('#na').empty();
			$('#na').html(nutri.na + " mg");
			$('#zn').empty();
			$('#zn').html(nutri.zn + " mg");
			$('#vit_a').empty();
			$('#vit_a').html(nutri.vit_a + " µg");
			$('#vit_b6').empty();
			$('#vit_b6').html(nutri.vit_b6 + " mg");
			$('#vit_b12').empty();
			$('#vit_b12').html(nutri.vit_b12 + " mg");
			$('#vit_c').empty();
			$('#vit_c').html(nutri.vit_c + " mg");
			$('#essential').empty();
			$('#essential').html(nutri.essential + " mg");
			$('#omega3').empty();
			$('#omega3').html(nutri.omega3 + " g");
		}
	};
</script>
</html>