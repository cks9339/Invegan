<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Invegan - 식단관리</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
body {
	position: relative;
}

#container {
	height: 800px;
	width: 1000px;
	margin: 0 auto;
	display: flex;
	padding: 20px 0;
}

.contents {
	width: 500px;
	height: 100%;
	padding: 10px 20px;
}

.contents>div {
	width: 95%;
}

#vertical-line {
	height: 100%;
	border-right: 2px solid lightgray;
}

#contents-left-header {
	display: flex;
	justify-content: space-between;
	border-bottom: 1px solid gray;
	vertical-align: middle;
	padding: 10px;
}

#contents-left-header>* {
	cursor: pointer;
	margin: 0px;
}

#contents-left-header button {
	background: none;
	border: none;
	height: 30px;
	width: 30px;
	padding: 0px;
}

#contents-left-content {
	/* border: 1px solid lightgrey; */
	height: auto;
	margin: 20px auto;
	padding: 0 10px;
}

#emptyList {
	height: 100px;
	border: 2px dashed gray;
	border-radius: 15px;
	position: relative;
	margin-top: 20px;
	cursor: pointer;
	color: gray;
}

#emptyList:hover {
	color: #6b6b6b;
	border: 2px solid #6b6b6b;
}

#emptyList p {
	font-size: large;
	font-weight: 600;
	position: absolute;
	top: 30%;
	left: 50%;
	transform: translate(-50%, -50%);
}

#list-items {
	text-align: right;
}

.menu-item td {
	padding-bottom: 7px;
	padding-left: 5px;
}

.menu-item input {
	border: 0;
	text-align: right;
	width: 35px;
	height: 20px;
	font-size: 15px;
}

.menu-item input:focus {
	outline: none;
}

.menu_name {
	padding-left: 20px;
	text-align: left;
}

.menu_name label {
	cursor: pointer;
}
/*제거 대상*/
/* .deleteX{
	display: none;
} */
.diet-category {
	height: 40px;
	font-size: 19px;
	font-weight: 600;
	text-align: left;
	padding-left: 0;
}
/* 제거 대상*/
/* .eventBox-item{
	width: 100%;
	margin: 1px;
	line-height: 25px;
}
.eventBox-item:hover{
	background: #c5fac5;
	border-radius: 13px;
	padding: 5px 5px;
} */
/* 세로 줄 */
.li-vertical-line {
	border-right: 1px solid black;
}

/* 영양성분 */
#contents-right-header {
	border-bottom: 1px solid gray;
	width: 100%;
	height: 39px;
}

#contents-right-header ul {
	margin: 11px auto;
	padding: 0;
	display: flex;
	justify-content: center;
}

#contents-right-header ul li {
	display: inline-block;
	justify-content: center;
}

#contents-right-header ul li:not(.li-vertical-line) {
	padding: 3px 16px;
	cursor: pointer;
	margin: 0 10px;
}

#contents-right-header ul li:not(.li-vertical-line):hover {
	border-bottom: 2px solid #95df95 !important;
}

#contents-right-content {
	width: 100%;
	padding: 10px 0px;
	text-align: center;
}

#contents-right-content h4, #contents-right-content label {
	margin: 8px auto;
}

#contents-right-content h4, #contents-right-content label {
	margin: 5px auto;
}

/* 원형 그래프*/
#kcal, #carb, #prot, #fat {
	width: 84px;
	height: 84px;
	/* padding-bottom: calc(97% - 19px); */
	margin: 3px auto;
	border-radius: 50%;
	position: relative;
	text-align: center;
	background: conic-gradient(#3F8BC9 0% 0%, #F2F2F2 0% 100%);
	display: flex;
    justify-content: center;
    align-items: center;
}

#kcal::before, #carb::before, #prot::before, #fat::before {
	color: black;
	width: 55px;
	height: 55px;
	/* padding: calc(35% - 1.3vw) 0; */
	background: #FFFFFF;
	border-radius: 50%;
	position: absolute;
	content: attr(data-percent) '%';
	transform: skew(-0.03deg);
	margin: auto;
	font-size: 1.1vw;
	font-size: 23px;
	/* padding: calc(43% - 1.3vw) 0; */
	display: flex;
    justify-content: center;
    align-items: center;
}

.graph-box {
	display: inline-block;
	width: 23%;
}
/*막대 그래프*/
.graph-bar {
	height: 18px;
	background-color: #caeada;
	border-radius: 5px;
}

.graph-bar span {
	display: block;
	padding: 0px;
	width: 0%;
	max-width: 100%;
	height: 18px;
	font-size: 14px;
	line-height: 18px;
	text-align: right;
	background: #85dd89;
	border-radius: 5px;
	box-sizing: border-box;
	color: #000;
}

.bar-graph-box-txt {
	display: flex;
	justify-content: space-between;
	padding: 2px 10px;
	font-size: 13px;
	font-weight: 600;
}
</style>
</head>
<body>
	<c:import url="/main/header" />
	<div id="container">
		<!-- 식단 영역 -->
		<div class="contents">
			<div id=contents-left-header>
				<h2 id="selectDate">${date}</h2>
				<button id="addMenuBtn" onclick="addMenu()">
					<i class="xi-plus xi-2x"></i>
				</button>
			</div>
			<c:if test="${dietListSize == 0 }">
				<div id="emptyList" onclick="addMenu()">
					<p>
						<i class="xi-plus-circle"></i> 메뉴를 추가해 주세요
					</p>
				</div>
			</c:if>
			<c:if test="${dietListSize > 0 }">
				<div id="contents-left-content">
					<table id="list-items">
						<colgroup>
							<col width="290px">
							<col width="60px">
							<col width="70px">
						</colgroup>
						<!-- 아침 리스트 -->
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'아침' and not hasBreakfast}">
									<tr>
										<td colspan="3" class="diet-category">${list.diet_category}</td>
									</tr>
									<c:set var="hasBreakfast" value="true" />
								</c:when>
							</c:choose>
						</c:forEach>
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'아침'}">
									<tr class="menu-item">
										<c:if test="${list.category eq'기본메뉴'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.food_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<c:if test="${list.category eq'나만의레시피'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.recipe_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<td><input type="text" value="${list.grams}"
											readonly="readonly" />g</td>
										<td>${list.kcal}kcal</td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
						<!-- 점심 리스트 -->
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'점심' and not hasLunch}">
									<tr>
										<td colspan="3" class="diet-category">${list.diet_category}</td>
									</tr>
									<c:set var="hasLunch" value="true" />
								</c:when>
							</c:choose>
						</c:forEach>
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'점심'}">
									<tr class="menu-item">
										<c:if test="${list.category eq'기본메뉴'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.food_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<c:if test="${list.category eq'나만의레시피'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.recipe_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<td><input type="text" value="${list.grams}"
											readonly="readonly" />g</td>
										<td>${list.kcal}kcal</td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
						<!-- 저녁 리스트 -->
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'저녁' and not hasDinner}">
									<tr>
										<td colspan="3" class="diet-category">${list.diet_category}</td>
									</tr>
									<c:set var="hasDinner" value="true" />
								</c:when>
							</c:choose>
						</c:forEach>
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'저녁'}">
									<tr class="menu-item">
										<c:if test="${list.category eq'기본메뉴'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.food_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<c:if test="${list.category eq'나만의레시피'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.recipe_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<td><input type="text" value="${list.grams}"
											readonly="readonly" />g</td>
										<td>${list.kcal}kcal</td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
						<!-- 기타 리스트 -->
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'기타' and not hasEtc}">
									<tr>
										<td colspan="3" class="diet-category">${list.diet_category}</td>
									</tr>
									<c:set var="hasEtc" value="true" />
								</c:when>
							</c:choose>
						</c:forEach>
						<c:forEach var="list" items="${dietList}">
							<c:choose>
								<c:when test="${list.diet_category eq'기타'}">
									<tr class="menu-item">
										<c:if test="${list.category eq'기본메뉴'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.food_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<c:if test="${list.category eq'나만의레시피'}">
											<td class="menu_name"><input type="hidden"
												value="${list.diet_id}" /> <input type="hidden"
												value="${list.menu_id}" /> <input type="hidden"
												value="${list.category}" /> <label>${list.recipe_name }</label>
												<label class="deleteX"> x </label></td>
										</c:if>
										<td><input type="text" value="${list.grams}"
											readonly="readonly" />g</td>
										<td>${list.kcal}kcal</td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>

		<div id="vertical-line"></div>

		<!-- 영양정보 영역 -->
		<div class="contents">
			<div id="contents-right-header">
				<ul>
					<li onclick="getNutri(this)">전체</li>
					<li class="li-vertical-line"></li>
					<li onclick="getNutri(this)">아침</li>
					<li class="li-vertical-line"></li>
					<li onclick="getNutri(this)">점심</li>
					<li class="li-vertical-line"></li>
					<li onclick="getNutri(this)">저녁</li>
					<li class="li-vertical-line"></li>
					<li onclick="getNutri(this)">기타</li>
				</ul>
			</div>
			<!-- 영양성분 / 원형 그래프  -->
			<div id="contents-right-content">
				<div id="circle-graph-box">
					<div class="graph-box">
						<label>열량</label>
						<div id="kcal" class="circle" data-percent=0></div>
						<h4 id="kcal-data"></h4>
					</div>
					<div class="graph-box">
						<label>탄수화물</label>
						<div id="carb" class="circle" data-percent=0></div>
						<h4 id="carb-data"></h4>
					</div>
					<div class="graph-box">
						<label>단백질</label>
						<div id="prot" class="circle" data-percent=0></div>
						<h4 id="prot-data"></h4>
					</div>
					<div class="graph-box">
						<label>지방</label>
						<div id="fat" class="circle" data-percent=0></div>
						<h4 id="fat-data"></h4>
					</div>
					<!-- 영양성분 - 막대 그래프 -->
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>총 당류</div>
							<div id="sugar-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="sugar-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>총 식이섬유</div>
							<div id="fiber-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="fiber-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>비타민 A</div>
							<div id="vitA-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="vitA-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>비타민 B6</div>
							<div id="vitB6-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="vitB6-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>비타민 B12</div>
							<div id="vitB12-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="vitB12-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>비타민 C</div>
							<div id="vitC-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="vitC-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>칼슘</div>
							<div id="ca-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="ca-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>아연</div>
							<div id="zn-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="zn-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>나트륨</div>
							<div id="na-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="na-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>칼륨</div>
							<div id="k-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="k-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>마그네슘</div>
							<div id="mg-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="mg-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>철분</div>
							<div id="fe-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="fe-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>인</div>
							<div id="p-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="p-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>필수 아미노산</div>
							<div id="essential-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="essential-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
					<div class="bar-graph-box">
						<div class="bar-graph-box-txt">
							<div>오메가3</div>
							<div id="omega3-val" class="nutr-value">0 / 0</div>
						</div>
						<div id="omega3-bar" class="graph-bar">
							<span>0%</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%-- 	<c:import url="/main/footer" /> --%>
</body>
<script>
	/*식단관리 페이지에서 카테고리 표시*/
	$('#go_diet').css('box-shadow','#95df95 0px 2px 0px 0px');
	$(document).ready(
			function() {
				// 페이지 로드시 바로 실행
				getNutri($('#contents-right-header ul li:first'));

				// 캘린더 화면으로 이동
				$('#selectDate').on('click', function() {
					console.log('date click');
					location.href = "dietCalander";
				});

				// 초기 화면 삭제버튼 숨김
				$('.deleteX').hide();
				// 마우스 오버에 따른 삭제버튼 활성화
				$('.menu_name').hover(function() {
					$(this).find('.deleteX').show();
				}, function() {
					$(this).find('.deleteX').hide();
				});

				$('.deleteX').click(function () {
				    var menuName = $(this).siblings('label').text();
				    
				    swal({
				        title: menuName + '을(를) 삭제하시겠습니까?',
				        text: "",
				        icon: "warning",
				        buttons: ["취소", "삭제"],
				        dangerMode: true,
				    }).then((isConfirmed) => {
				        if (isConfirmed) {
				            var tdMenuName = $(this).closest('.menu_name');
				            
				            var dietId = tdMenuName.find('input').eq(0).val();
				            var menuId = tdMenuName.find('input').eq(1).val();
				            var category = tdMenuName.find('input').eq(2).val();
				            
				            var params = {
				                'diet_id': dietId,
				                'menu_id': menuId,
				                'category': category
				            };
				            
				            console.log(params);
				            deleteMenu(params);
				        }
				    });
				});
			});

	// 메뉴 등록 팝업 창 열기
	function addMenu() {
		var selectDate = $('#selectDate').text();
		window.open("addMenu.go?date=" + selectDate, "pop",
				"width=1200,height=700,top=100,left=300,scrollbars=no");
	}

	// 메뉴 삭제
	function deleteMenu(params) {
		console.log('params for delete check: ', params);
		$.ajax({
			type : 'get',
			url : 'deleteMenu',
			data : params,
			dataType : 'JSON',
			success : function(data) {
				if(data.success=='success'){
					console.log('메뉴삭제',data.success);
					location.reload();
				}
			},
			error : function(data) {
			}
		}); 
	}

	// 영양소 가져오기
	function getNutri(obj) {
		console.log('getNutri() 실행');
		var dietCate = $(obj).text();
		var selectDate = '${date}';
		$('#contents-right-header ul li').not(this).not('.li-vertical-line')
				.css('border-bottom', 'white');
		$(obj).css('border-bottom', '2px solid #95df95');
		console.log(selectDate + ' / ' + dietCate);

		$.ajax({
			type : 'get',
			url : 'getNutri',
			data : {
				'selectDate' : selectDate,
				'dietCate' : dietCate
			},
			dataType : 'JSON',
			success : function(data) {
				var daily = data.daily;
				var nutr = data.nutr;
				console.log(nutr);
				console.log(daily);
				drawNutri(nutr, daily);
				// 등록된 메뉴가 없을때 nutr==null
				// null 일때 처리 해줄것.
			},
			error : function(data) {

			}
		});
	}

	// 영양소 총 합을 그려주는 함수
	function drawNutri(nutr, daily) {
		console.log("nutr", nutr);
		console.log("daily", daily);

		// 태그 가져오기
		var kcal = document.querySelector("#kcal");
		var carb = document.querySelector("#carb");
		var prot = document.querySelector("#prot");
		var fat = document.querySelector("#fat");
		console.log("가져온 태그 확인 : ", kcal, "/", carb, "/", prot, "/", fat);

		// 가져온 태그에 data-percent 속성 추가
		console.log(nutr.kcal + "/" + daily.kcal);
		kcal.setAttribute("data-percent", Math.round(nutr.kcal / daily.kcal
				* 100));
		carb.setAttribute("data-percent", Math.round(nutr.carb
				/ daily.recomm_carb * 100));
		prot.setAttribute("data-percent", Math.round(nutr.prot
				/ daily.recomm_prot * 100));
		fat.setAttribute("data-percent", Math.round(nutr.fat / daily.recomm_fat
				* 100));

		// 태그의 data-percent 속성의 값을 변수에 저장
		var percentKcal = kcal.getAttribute("data-percent");
		var percentCarb = carb.getAttribute("data-percent");
		var percentProt = prot.getAttribute("data-percent");
		var percentFat = fat.getAttribute("data-percent");
		console.log(percentKcal + "/" + percentCarb + "/" + percentProt + "/"
				+ percentFat);

		// 태그의 background 속성 변경
		kcal.style.background = 'conic-gradient(#3F8BC9 0% ' + percentKcal
				+ '%, rgb(222 222 222) ' + percentKcal + '% 100%)';
		carb.style.background = 'conic-gradient(#3F8BC9 0% ' + percentCarb
				+ '%, rgb(222 222 222) ' + percentCarb + '% 100%)';
		prot.style.background = 'conic-gradient(#3F8BC9 0% ' + percentProt
				+ '%, rgb(222 222 222) ' + percentProt + '% 100%)';
		fat.style.background = 'conic-gradient(#3F8BC9 0% ' + percentFat
				+ '%, rgb(222 222 222) ' + percentFat + '% 100%)';

		// kcal chk
		$('#kcal-data').empty();
		$('#kcal-data').append(
				'<h4>' + nutr.kcal + '<br/>/ ' + daily.kcal + 'kcal</h4>');
		// carb chk
		$('#carb-data').empty();
		$('#carb-data').append(
				'<h4>' + nutr.carb + '<br/>/ ' + daily.recomm_carb + 'g</h4>');
		// prot chk
		$('#prot-data').empty();
		$('#prot-data').append(
				'<h4>' + nutr.prot + '<br/>/ ' + daily.recomm_prot + 'g</h4>');
		// fat chk
		$('#fat-data').empty();
		$('#fat-data').append(
				'<h4>' + nutr.fat + '<br/>/ ' + daily.recomm_fat + 'g</h4>');

		// 영양성분 막대 그래프

		// 총당류
		var sugarPer = Math.round(nutr.sugar / daily.recomm_sugar * 100);
		console.log(nutr.sugar, '/', daily.recomm_sugar);
		console.log('sugar per : ', sugarPer);
		$('#sugar-val').empty();
		$('#sugar-val').append(
				'<div>' + nutr.sugar + ' / ' + daily.recomm_sugar + 'g</div>');
		$('#sugar-bar span').css('width', sugarPer + '%');
		$('#sugar-bar span').empty();
		$('#sugar-bar span').append(sugarPer + '% ');
		//식이섬유
		var fiberPer = Math.round(nutr.fiber / daily.fiber * 100);
		console.log(nutr.fiber, '/', daily.fiber);
		console.log('fiber per : ', fiberPer);
		$('#fiber-val').empty();
		$('#fiber-val').append(
				'<div>' + nutr.fiber + ' / ' + daily.fiber + 'g</div>');
		$('#fiber-bar span').css('width', fiberPer + '%');
		$('#fiber-bar span').empty();
		$('#fiber-bar span').append(fiberPer + '% ');
		// 비타민 A
		var vitAPer = Math.round(nutr.vit_a / daily.recomm_vit_a * 100);
		console.log(nutr.vit_a, '/', daily.recomm_vit_a);
		console.log('vitA per : ', vitAPer);
		$('#vitA-val').empty();
		$('#vitA-val').append(
				'<div>' + nutr.vit_a + ' / ' + daily.recomm_vit_a + '㎍</div>');
		$('#vitA-bar span').css('width', vitAPer + '%');
		$('#vitA-bar span').empty();
		$('#vitA-bar span').append(vitAPer + '% ');
		// 비타민 B6
		var vitB6Per = Math.round(nutr.vit_b6 / daily.recomm_vit_b6 * 100);
		console.log(nutr.vit_b6, '/', daily.recomm_vit_b6);
		console.log('vitA per : ', vitB6Per);
		$('#vitB6-val').empty();
		$('#vitB6-val').append(
				'<div>' + nutr.vit_b6 + ' / ' + daily.recomm_vit_b6
						+ 'mg</div>');
		$('#vitB6-bar span').css('width', vitB6Per + '%');
		$('#vitB6-bar span').empty();
		$('#vitB6-bar span').append(vitB6Per + '% ');
		// 비타민 B12
		var vitB12Per = Math.round(nutr.vit_b12 / daily.recomm_vit_b12 * 100);
		console.log(nutr.vit_b12, '/', daily.recomm_vit_b12);
		console.log('vitB12 per : ', vitB12Per);
		$('#vitB12-val').empty();
		$('#vitB12-val').append(
				'<div>' + nutr.vit_b12 + ' / ' + daily.recomm_vit_b12
						+ 'mg</div>');
		$('#vitB12-bar span').css('width', vitB12Per + '%');
		$('#vitB12-bar span').empty();
		$('#vitB12-bar span').append(vitB12Per + '% ');
		// 비타민 C
		var vitCPer = Math.round(nutr.vit_c / daily.recomm_vit_c * 100);
		console.log(nutr.vit_c, '/', daily.recomm_vit_c);
		console.log('vitC per : ', vitCPer);
		$('#vitC-val').empty();
		$('#vitC-val').append(
				'<div>' + nutr.vit_c + ' / ' + daily.recomm_vit_c + 'mg</div>');
		$('#vitC-bar span').css('width', vitCPer + '%');
		$('#vitC-bar span').empty();
		$('#vitC-bar span').append(vitCPer + '% ');
		// 칼슘
		var caPer = Math.round(nutr.ca / daily.recomm_ca * 100);
		console.log(nutr.ca, '/', daily.recomm_ca);
		console.log('ca per : ', caPer);
		$('#ca-val').empty();
		$('#ca-val').append(
				'<div>' + nutr.ca + ' / ' + daily.recomm_ca + 'mg</div>');
		$('#ca-bar span').css('width', caPer + '%');
		$('#ca-bar span').empty();
		$('#ca-bar span').append(caPer + '% ');
		// 인
		var pPer = Math.round(nutr.p / daily.recomm_p * 100);
		console.log(nutr.p, '/', daily.recomm_p);
		console.log('p per : ', pPer);
		$('#p-val').empty();
		$('#p-val').append(
				'<div>' + nutr.p + ' / ' + daily.recomm_p + 'mg</div>');
		$('#p-bar span').css('width', pPer + '%');
		$('#p-bar span').empty();
		$('#p-bar span').append(pPer + '% ');
		// 나트륨
		var naPer = Math.round(nutr.na / daily.na * 100);
		console.log(nutr.na, '/', daily.na);
		console.log('na per : ', naPer);
		$('#na-val').empty();
		$('#na-val').append('<div>' + nutr.na + ' / ' + daily.na + 'mg</div>');
		$('#na-bar span').css('width', naPer + '%');
		$('#na-bar span').empty();
		$('#na-bar span').append(naPer + '% ');
		// 칼륨
		var kPer = Math.round(nutr.k / daily.k * 100);
		console.log(nutr.k, '/', daily.k);
		console.log('k per : ', kPer);
		$('#k-val').empty();
		$('#k-val').append('<div>' + nutr.k + ' / ' + daily.k + 'mg</div>');
		$('#k-bar span').css('width', kPer + '%');
		$('#k-bar span').empty();
		$('#k-bar span').append(kPer + '% ');
		// 마그네슘
		var mgPer = Math.round(nutr.mg / daily.recomm_mg * 100);
		console.log(nutr.mg, '/', daily.recomm_mg);
		console.log('mg per : ', mgPer);
		$('#mg-val').empty();
		$('#mg-val').append(
				'<div>' + nutr.mg + ' / ' + daily.recomm_mg + 'mg</div>');
		$('#mg-bar span').css('width', mgPer + '%');
		$('#mg-bar span').empty();
		$('#mg-bar span').append(mgPer + '% ');
		// 철분
		var fePer = Math.round(nutr.fe / daily.recomm_fe * 100);
		console.log(nutr.fe, '/', daily.recomm_fe);
		console.log('fe per : ', fePer);
		$('#fe-val').empty();
		$('#fe-val').append(
				'<div>' + nutr.fe + ' / ' + daily.recomm_fe + 'mg</div>');
		$('#fe-bar span').css('width', fePer + '%');
		$('#fe-bar span').empty();
		$('#fe-bar span').append(fePer + '% ');
		// 아연
		var znPer = Math.round(nutr.zn / daily.recomm_zn * 100);
		console.log(nutr.zn, '/', daily.recomm_zn);
		console.log('zn per : ', znPer);
		$('#zn-val').empty();
		$('#zn-val').append(
				'<div>' + nutr.zn + ' / ' + daily.recomm_zn + 'mg</div>');
		$('#zn-bar span').css('width', znPer + '%');
		$('#zn-bar span').empty();
		$('#zn-bar span').append(znPer + '% ');
		// 필수 아미노산
		var essentialPer = Math.round(nutr.essential / daily.recomm_essential
				* 100);
		console.log(nutr.essential, '/', daily.recomm_essential);
		console.log('essential per : ', essentialPer);
		$('#essential-val').empty();
		$('#essential-val').append(
				'<div>' + nutr.essential + ' / ' + daily.recomm_essential
						+ 'mg</div>');
		$('#essential-bar span').css('width', essentialPer + '%');
		$('#essential-bar span').empty();
		$('#essential-bar span').append(essentialPer + '% ');
		// 오메가3
		var omega3Per = Math.round(nutr.omega3 / daily.recomm_omega3 * 100);
		console.log(nutr.omega3, '/', daily.recomm_omega3);
		console.log('omega3 per : ', omega3Per);
		$('#omega3-val').empty();
		$('#omega3-val')
				.append(
						'<div>' + nutr.omega3 + ' / ' + daily.recomm_omega3
								+ 'g</div>');
		$('#omega3-bar span').css('width', omega3Per + '%');
		$('#omega3-bar span').empty();
		$('#omega3-bar span').append(omega3Per + '% ');
	}
</script>
</html>