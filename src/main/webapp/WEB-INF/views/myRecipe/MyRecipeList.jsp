<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
		<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<style>					
				
			/* 카테고리 버튼 */
			.cbutton {
				background: none;
				width : 61.6px;
				height: 40.8px;
				border: 1.5px solid gray;
				background-color: white;
				border-radius: 5px;
				cursor: pointer;
				text-align: center;
				font-size : 17px;
				color : gray;
				box-shadow: lightgray 5px 4px 7px 1px;
				outline-color: #9eca9e;
				padding : 8px 13px;
				margin: 0px 3px;
			}
			
			.cbutton:hover {
				cursor: pointer;
				color: #9eca9e;
			}
			
			.cbutton:active {
				cursor: pointer;
				box-shadow: lightgray 3px 2px 9px 0px;
			}
			
			/* 큰 테두리 */
			#rmain {
				width: 1170px;
				height: 600px;
				margin : 0px 10px 0px 0px;
				position: relative;
			}
			
			/* r:레시피 */
			#rbox {
				width : 720px;
				margin: 46px 0px 0px 30px;
				position: absolute;
				top: -30px;
				left: 6px;
			}
			
			#rbox table {
				width: 720px;
				text-align: center;
				font-size: 15px;
			}
			#rbox th {
				height: 29px;
				border: 1.3px solid #59b879;
    			border-radius: 3px;
			}
			
			#rbox td {
				height: 33px;
			}
			
			#thead {
				margin-top : 16px;
			}
			
			#mrbody {
				width : 718.4px;
				height: 175px;
				border-top: none;
				overflow-x : hidden;
				overflow-y : auto;	
			}
			
			#mrbody::-webkit-scrollbar {
				width : 0px;
				height: 0px;
			}
			
			#mrList {
				border-collapse: collapse;
				width: 718.4px;
			}
			
			#mrList tr:hover {
				cursor: pointer;
				box-shadow:  #59B879 0px 0px 5px 1px;
			}
			
			/* 레시피 추가 버튼 */
			.ibutton {
				position: absolute;
				left: 580px;
				top : -7px;
				cursor: pointer;
				background: none;
				border: none;
				font-size: 40px;
			}
			
			/* 레시피 삭제 버튼 */
			.dbutton {
				position: absolute;
				left: 616px;
				top : -11px;
				cursor: pointer;
				background: none;
				border: none;
				font-size: 40px;
			}
			
			/* 완료 버튼 */
			.fbutton {
				position: absolute;
				left: 632px;
				margin-left: 28px;
				background : none;
				border: 1.5px solid black;
				border-radius: 5px;
				font-size : 16px;
				width : 60px;
				height: 40px;
				cursor: pointer;
				outline-color: #9eca9e;
				box-shadow: lightgray 5px 4px 7px 1px;;
			}
			
			.fbutton:hover {
				border: 1.5px solid #9eca9e;
				cursor: pointer;
			}
			
			.fbutton:active{
				box-shadow: lightgray 3px 2px 9px 0px;
				border: 1.5px solid #9eca9e;
				color: #9eca9e;
			}
			
			/* rm:재료 */
			#rmbox {
				width: 720px;
				margin: 46px 10px 0px 30px;
				position: absolute;
				bottom: 75px;
				left: 6px;
			}
			
			#rmbox table{
				width: 718.4px;
				text-align: center;
				font-size : 15px;
			}
			#rmbox th {
				height: 29px;
			}
			#rmbox td {
				height: 33px;
			}
			
			#rmbody {
				width: 718.4px;
				height: 140px;
				overflow-x : hidden;
				overflow-y : scroll;	
			}
			
			#rmbody::-webkit-scrollbar {
				width : 0px;
				height : 0px;
			}
			
			#rmbody table{
				border-collapse: collapse;
			}
			
			#rmtop {
				width : 720px;
			}
			
			#rmhead {
				width: 718.4px;
				border-bottom: none;
			}
			
			#rmhead table{
				width: 718.4px;
			}
			
			#rmhead th{
				border: 1.3px solid #59b879;
    			border-radius: 3px;
			}
			
			
			#mtop input {
				cursor: pointer;
				background: none;
				border: none;
				font-size: 40px;
			}
			
			#mm{
				position: absolute;
				left: 271px;
   				top: -38px;
   				font-weight: 600;
			}
			
			#rMaterialList tr:hover {
				cursor: pointer;
				box-shadow:  #59B879 0px 0px 5px 1px;
			}
			
			/* 재료 추가 버튼 */
			#minsert {
				position: absolute;
				right: 105px;
				top: -48px;	
			}
			
			/* 재료 삭제 버튼 */
			#mdelete {
				position: absolute;
				right: 78px;
				top: -48px;
			}

			/* rN:영양소 표시 */			
			#rNutri {
				width: 310px;
				height: 590px;
				border-left: 2px solid lightgray;
				position: absolute;
				top : 2px;
				right: 50px;
			}
			
			#rNutri table{
				width: 300px;
				height: 590px;
				padding : 5px 10px;
				margin-left: 10px; 
				border-collapse: collapse;
			}
			
			#rNutri th {
				height : 29px;
				font-size: 15px;
				padding : 3px;
				border-bottom : 2px solid #95df95;
			}
			
			#rNutri td{
				width : 150px;
				height: 19px;
				font-size: 16px;
				padding : 1px 5px 1px 1px;
			}
			
			#rNutri tr td:first-child {
           		text-align: right;
      		}
      		
      		#rNutri tr td:secend-child {
           		text-align: left;
      		}
			
			/* 모달창 */		
			.modal {
				 display: none;
				 position: fixed;
				 z-index: 1;
				 left: 0;
				 top: 0;
				 width: 100%;
				 height: 100%;
				 background-color: rgba(0, 0, 0, 0.7);
			}
			
			#modal-content {
				 display: flex;
				 position: fixed;
				 background-color: #fefefe;
				 padding: 20px;
				 border: 1px solid #888;
				 width: 800px;
				 left: 181.2px;
				 top: 46.95px;
			}

		</style>	
	</head>
	<body>
		<div id="rmain">
			<div id="rbox">		
				<input type="button" class="cbutton" id="breakfast" value="아침"/>
				<input type="button" class="cbutton" id="lunch" value="점심"/>
				<input type="button" class="cbutton" id="dinner" value="저녁"/>
				<input type="button" class="cbutton" id="other" value="기타"/>
				<input type="button" class="ibutton" onclick="rinsert()" value="+"/>
				<input type="button" class="dbutton" onclick="rdel()" value="-"/>
				<input type="button" class="fbutton" onclick="dinsert()" value="완료"/>
				<div id = "thead">
					<table>
						<colgroup>
							<col width="50%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tr>
							<th>레시피 이름</th>
							<th>1회 제공량(g)</th>
							<th>에너지(kcal)</th>
						</tr>
					</table>
				</div>
				<div id = mrbody>
					<table id=rinsertbox>
						<!-- 레시피 이름 입력칸 -->
					</table>
					<div id = tbody>
						<table id=mrList>				
							<!-- 레시피 데이터 출력 -->
						</table>
					</div>
				</div>
			</div>
			<br>
			<div id="rmbox">
				<div id="mtop">
				<a id="mm">재료</a>
				<input type ="button" id="minsert" onclick="minsert()" value="+"/>
				<input type ="button" id="mdelete" onclick="mdel()" value="-"/>
				</div>
				<div id="rmhead">
					<table>
						<colgroup>
							<col width="50%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tr>
							<th>재료 이름</th>
							<th>1회 제공량(g)</th>
							<th>에너지(kcal)</th>
						</tr>
					</table>				
				</div>
				<div id="rmbody">
					<table  id = "rMaterialList">
						<!-- 재료 출력 -->
					</table>
				</div>
			</div>
			<br>
			<br>
			<div id="rNutri">
				<table id = "rNutriList">
					<tr><th colspan="2">+ 버튼을 눌러 레시피를 추가해 주세요</th></tr>
					<tr><td>제공량</td><td class="nutri">0 g</td></tr>
					<tr><td>열량</td><td class="nutri">0 kcal</td></tr>
					<tr><td>탄수화물</td><td class="nutri">0 g</td></tr>
					<tr><td>단백질</td><td class="nutri">0 g</td></tr>
					<tr><td>지방</td><td class="nutri">0 g</td></tr>
					<tr><td>총 당류</td><td class="nutri">0 mg</td></tr>
					<tr><td>총 식이섬유</td><td class="nutri">0 mg</td></tr>
					<tr><td>칼슘</td><td class="nutri">0 mg</td></tr>
					<tr><td>철</td><td class="nutri">0 mg</td></tr>
					<tr><td>마그네슘</td><td class="nutri">0 mg</td></tr>
					<tr><td>인</td><td class="nutri">0 mg</td></tr>
					<tr><td>칼륨</td><td class="nutri">0 mg</td></tr>
					<tr><td>나트륨</td><td class="nutri">0 mg</td></tr>
					<tr><td>아연</td><td class="nutri">0 mg</td></tr>
					<tr><td>비타민A</td><td class="nutri">0 µg</td></tr>
					<tr><td>비타민B6</td><td class="nutri">0 mg</td></tr>
					<tr><td>비타민B12</td><td class="nutri">0 mg</td></tr>
					<tr><td>비타민C</td><td class="nutri">0 mg</td></tr>
					<tr><td>필수 아미노산</td><td class="nutri">0 mg</td></tr>
					<tr><td>오메가 3</td><td class="nutri">0 mg</td></tr>
				</table>
			</div>
		</div>
		<div id="mModal" class="modal">
			<div id="modal-content">
				<!-- 모달의 내용이 출력됨 -->
				<p>로딩중......</p>
			</div>	
		</div>
	</body>
	<script>
		listCall();
		var category = "나만의 레시피";
		var food_id;
		var menu_id;
		var material_id;
		var diet_category;
		var selectDate = $('#getDate').val();
		var grams;
		
		
		// 레시피 리스트 불러오기
		function listCall() {
			
			$.ajax({
				type:'post',
				url:'mrlistCall',
				data:{},
				dataType:'json',
				success:function(data){
					console.log(data);
					drawList(data.mrlist);
				    
					if (data.rowIndex != null){
						$(document).ready(function(){
						var rowToClick = $('#mrList tr:eq('+data.rowIndex+')');
						rowToClick.trigger('click');
						});
					} else{
						$(document).ready(function(){
					    var rowToClick = $('#mrList tr:first');
					    rowToClick.trigger('click');
						});
					} 
				},
				error:function(e) {
					console.log(e);
				}
			});
		}
		
		// 레시피 추가
		function rinsert() {
		    var content = '';
		    content += '<tr>';
		    content += '<td>';
		    content += '<input type="text" name="recipe_name" placeholder="레시피의 이름을 입력해 주세요" style="border:none; width:300px"/>';
		    content += '<input type="button" id="rNameinsert" value="확인"/>';
		    content += '</td>';
		    content += '<td>'+'</td>'+'<td>'+'</td>';
		    content += '</tr>';		
			$('#rinsertbox').empty();
		    $('#rinsertbox').append(content);

		    // 나만의 레시피 이름 입력창
		    $('#rNameinsert').on('click', function(){
				recipe_name = $('input[name="recipe_name"]').val();
				console.log("레시피 이름 : "+recipe_name);
				
				$.ajax({
					type:'post',
					url:'rlistUpdate.do',
					data:{"recipe_name" : recipe_name},
					success:function(data){
						console.log(data);
					},
					error:function(e) {
						console.log(e);
					}
				});
				myRecipeMenu();
			});
		};
		
		

		// 리스트 그리기
		function drawList(mrlist) {
			console.log(mrlist);
			var content = "";
			mrlist.forEach(function(item, idx){	
				if (item.hidden == 0){
					content += '<tr>';
					content += '<td style="display : none;">'+item.menu_id+'</td>';
					content += '<td width="50%">'+item.recipe_name+'</td>';
					content += '<td width="25%">'+item.grams+'</td>';
					content += '<td width="25%">'+item.kcal+'</td>';
					content += '</tr>';
				}
			});
			$('#rMaterialList').empty();
			$('#mrList').empty();
			$('#mrList').append(content);
		}
		
		// 레시피 리스트 클릭시 재료 출력
		$('#mrList').on('click', 'tr', function() {
			$('#rNutriList').empty();
        	$('#mrList tr').css('background', 'none');
            menu_id = $(this).find('td:eq(0)').text();
            var rName = $(this).find('td:eq(1)').text();
            rowIndex = $(this).index();
            grams = $(this).find('td:eq(2)').text();
            $(this).css('background','rgb(115 211 147 / 19%)');
            console.log('클릭한 행의 인덱스: ' + rowIndex);
            console.log('클릭한 레시피 번호: '+menu_id);
            console.log('클릭한 레시피 이름: ' + rName);
            console.log('클릭한 레시피 무게: '+grams);
		
            // 레시리 재료 리스트
            $.ajax({
            	type:'post',
            	url:'rMaterial.do',
            	data:{"menu_id":menu_id},
            	success:function(data){
            		console.log(data.rMaterial);
            		drawmList(data.rMaterial);
            	},
            	error:function(e) {
            		console.log(e);
            	}
            });
            
            // 레시피 영양소
            $.ajax({
            	type:'get',
            	url:'rNutri.do',
            	data:{"menu_id":menu_id},
            	success:function(data){
            		console.log(data);
            		drawrNList(data.rNutri);
            	},
            	error:function(e) {
            		console.log(e);
            	}
            });
       });
		
		// 레시피 영양소 그리기
		function drawrNList(rNutri) {
			console.log(rNutri);
				var content = '';
				rNutri.forEach(function(item, idx){
					if (item != null){
						content += '<tr>'+ '<th colspan="2">'+item.recipe_name+'</th>'+'</tr>';
						content += '<tr>'+'<td>'+'제공량 '+'</td>'+'<td class="nutri">'+item.grams+' g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'열량 '+'</td>'+'<td class="nutri">'+item.kcal+' kcal'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'탄수화물 '+'</td>'+'<td class="nutri">'+item.carb+' g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'단백질 '+'</td>'+'<td class="nutri">'+item.prot+' g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'지방 '+'</td>'+'<td class="nutri">'+item.fat+' g'+'</td>'+'</tr>';		
						content += '<tr>'+'<td>'+'총 당류 '+'</td>'+'<td class="nutri">'+item.sugar+' g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'총 식이섬유 '+'</td>'+'<td class="nutri">'+item.fiber+' g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'칼슘 '+'</td>'+'<td class="nutri">'+item.ca+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'철 '+'</td>'+'<td class="nutri">'+item.fe+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'마그네슘 '+'</td>'+'<td class="nutri">'+item.mg+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'인 '+'</td>'+'<td class="nutri">'+item.p+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'칼륨 '+'</td>'+'<td class="nutri">'+item.k+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'나트륨 '+'</td>'+'<td class="nutri">'+item.na+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'아연 '+'</td>'+'<td class="nutri">'+item.zn+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민A '+'</td>'+'<td class="nutri">'+item.vit_a+' ug'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민B6 '+'</td>'+'<td class="nutri">'+item.vit_b6+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민B12 '+'</td>'+'<td class="nutri">'+item.vit_b12+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민C '+'</td>'+'<td class="nutri">'+item.vit_c+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'필수 아미노산 '+'</td>'+'<td class="nutri">'+item.essential+' mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'오메가3 '+'</td>'+'<td class="nutri">'+item.omega3+' mg'+'</td>'+'</tr>';
					} else {
						content += '<tr>'+ '<th colspan="2">'+'재료를 추가해 주세요'+'</th>'+'</tr>';
						content += '<tr>'+'<td>'+'제공량 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'열량 '+'</td>'+'<td class="nutri">'+'0 kcal'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'탄수화물 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'단백질 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'지방 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';		
						content += '<tr>'+'<td>'+'총 당류 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'총 식이섬유 '+'</td>'+'<td class="nutri">'+'0 g'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'칼슘 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'철 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'마그네슘 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'인 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'칼륨 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'나트륨 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'아연 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민A '+'</td>'+'<td class="nutri">'+'0 µg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민B6 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민B12 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'비타민C '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'필수 아미노산 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';
						content += '<tr>'+'<td>'+'오메가3 '+'</td>'+'<td class="nutri">'+'0 mg'+'</td>'+'</tr>';		
					}
				});
			$('#rNutriList').empty();
			$('#rNutriList').append(content);
		};
		
		// 재료 리스트 그리기
		function drawmList(rMaterial) {
			console.log(rMaterial);
			var content = "";
			rMaterial.forEach(function(item, idx){
				content += '<tr>';
				content += '<td style="display : none;">'+item.material_id+'</td>';
				content += '<td width="50%">'+item.food_name+'</td>';
				content += '<td width="25%">'+item.grams+'</td>';
				content += '<td width="25%">'+item.kcal+'</td>';
				content += '</tr>';
			});
			$('#rMaterialList').empty();
			$('#rMaterialList').append(content);	
		};
		
		// 레시피 재료 클릭
		$('#rMaterialList').on('click', 'tr', function() {
			$('#rMaterialList tr').css('background', 'none');
			material_id = $(this).find('td:eq(0)').text();
		    $(this).css('background-color','rgb(115 211 147 / 19%)');
		    console.log('클릭한 재료의 id : '+material_id);
		    
		    // 재료 영양소 출력
		    $.ajax({
            	type:'get',
            	url:'mNutri.do',
            	data:{"material_id":material_id},
            	success:function(data){
            		console.log(data);
            		drawrmNList(data.mNutri);
            	},
            	error:function(e) {
            		console.log(e);
            	}
            });
		});
		    
		function drawrmNList(mNutri) {
			console.log(mNutri);
			var content = '';
			mNutri.forEach(function(item, idx){
				content += '<tr>'+ '<th colspan="2">'+item.food_name+'</th>'+'</tr>';
				content += '<tr>'+'<td>'+'제공량 '+'</td>'+'<td class="nutri">'+item.grams+' g'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'열량 '+'</td>'+'<td class="nutri">'+item.kcal+' kcal'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'탄수화물 '+'</td>'+'<td class="nutri">'+item.carb+' g'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'단백질 '+'</td>'+'<td class="nutri">'+item.prot+' g'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'지방 '+'</td>'+'<td class="nutri">'+item.fat+' g'+'</td>'+'</tr>';		
				content += '<tr>'+'<td>'+'총 당류 '+'</td>'+'<td class="nutri">'+item.sugar+' g'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'총 식이섬유 '+'</td>'+'<td class="nutri">'+item.fiber+' g'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'칼슘 '+'</td>'+'<td class="nutri">'+item.ca+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'철 '+'</td>'+'<td class="nutri">'+item.fe+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'마그네슘 '+'</td>'+'<td class="nutri">'+item.mg+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'인 '+'</td>'+'<td class="nutri">'+item.p+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'칼륨 '+'</td>'+'<td class="nutri">'+item.k+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'나트륨 '+'</td>'+'<td class="nutri">'+item.na+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'아연 '+'</td>'+'<td class="nutri">'+item.zn+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'비타민A '+'</td>'+'<td class="nutri">'+item.vit_a+' ug'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'비타민B6 '+'</td>'+'<td class="nutri">'+item.vit_b6+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'비타민B12 '+'</td>'+'<td class="nutri">'+item.vit_b12+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'비타민C '+'</td>'+'<td class="nutri">'+item.vit_c+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'필수 아미노산 '+'</td>'+'<td class="nutri">'+item.essential+' mg'+'</td>'+'</tr>';
				content += '<tr>'+'<td>'+'오메가3 '+'</td>'+'<td class="nutri">'+item.omega3+' mg'+'</td>'+'</tr>';
			});
			$('#rNutriList').empty();
			$('#rNutriList').append(content);					
		};

		
		// 재료 추가 모달 이동
		function minsert() {
			if (menu_id == null){
				swal({
		            title: "재료를 추가할 레시피를 선택해주세요",
		            text: "",
		            icon: "info",
		        });
			} else {
				
				// 재료추가 모달창
				var modal = document.getElementById("mModal");
				modal.style.display = "block";		
				$('#modal-content').load("<c:url value='../myRecipe/addRecipeMaterial'/>");
				$(document).click(function(event) {
					  if (event.target === document.getElementById("myModal")) {
					    closeModal(); // 모달 외부 클릭 시 모달 닫기
					  }
				});
				
				$.ajax({
					type:'post',
					url:'minsert.do',
					data:{"menu_id" : menu_id, "rowIndex":rowIndex},
					dataType:'json',
					success:function(data){
						console.log(data);
					},
					error:function(e){
						console.log(e);
					}
				});
			}
		}
		
		// 재료 삭제
        function mdel() {
        	
			if (material_id == null) {
				swal({
		            title: "제거하실 재료를 선택해주세요",
		            text: "",
		            icon: "info",
		        });
				listCall();
			} else {
			    swal({
			        title: '재료를 삭제하시겠습니까?',
			        text: "",
			        icon: "warning",
			        buttons: ["취소", "삭제"]
			    }).then((confirmed) => {
			        if (confirmed) {
			            $.ajax({
			                type: 'get',
			                url: 'mdelete.do',
			                data: { "material_id": material_id },
			                dataType: 'json',
			                success: function (data) {
			                    console.log(data);
			                    if (data.success == true) {
			                        swal({
			                            title: "재료가 삭제되었습니다.",
			                            text: "",
			                            icon: "info",
			                        });
			                        myRecipeMenu();
			                    }
			                },
			                error: function (e) {
			                    console.log(e);
			                }
			            });
			        }
			    });
			}
        }
        
        // 레시피 삭제
		function rdel(){
			if (menu_id == null) {
				swal({
		            title: "제거하실 레시피를 선택해주세요",
		            text: "",
		            icon: "info",
		        });
				listCall();
			} else {
			    swal({
			        title: '레시피를 삭제하시겠습니까?',
			        text: "",
			        icon: "warning",
			        buttons: ["아니오", "네"]
			    }).then((isConfirmed) => {
			        if (isConfirmed) {
			            $.ajax({
			                type: 'get',
			                url: 'rdelete.do',
			                data: { "menu_id": menu_id },
			                dataType: 'json',
			                success: function (data) {
			                    console.log(data);
			                    if (data.success == true) {
			                        swal('레시피가 삭제되었습니다.', {
			                            icon: "success",
			                        }).then(() => {
			                            myRecipeMenu();
			                        });
			                    }
			                },
			                error: function (e) {
			                    console.log(e);
			                }
			            });
			        } else {
			            return false;
			        }
			    });
			}
		}
		
		// 아,점,저,기 버튼
		$('.cbutton').on('click', function(){
			$('.cbutton').css('border','');
			$('.cbutton').css('color','');
			diet_category = $(this).val();
			console.log("식단의 카테고리 : "+diet_category);
			$(this).css('border','1.5px solid #9eca9e');
			$(this).css('color','#9eca9e');
		});
		
		// 식단 추가
		function dinsert() {
			if (diet_category == '') {
				swal({
		            title: "아침, 점심, 저녁, 기타 중 하나를 선택해주세요",
		            text: "",
		            icon: "info",
		        });
			} else if (menu_id == null) {
				swal({
		            title: "레시피를 선택해 주세요",
		            text: "",
		            icon: "info",
		        });
			} else if (grams == 0) {
				swal({
		            title: "레시피에 재료를 추가해 주세요",
		            text: "",
		            icon: "info",
		        });
			} else {
			    swal({
			        title: "선택한 레시피를 식단에 추가하시겠습니까?",
			        text: "",
			        icon: "info",
			        buttons: ["아니오", "네"]
			    }).then((isConfirmed) => {
			        if (isConfirmed) {
			            var param = {};
			            param.diet_category = diet_category;
			            param.menu_id = menu_id;
			            param.date = selectDate;

			            console.log(param);

			            $.ajax({
			                type: 'get',
			                url: 'dinsert.do',
			                data: param,
			                dataType: 'json',
			                success: function (data) {
			                    console.log(data);
			                    swal("레시피가 식단에 추가되었습니다.", {
			                        icon: "success",
			                    }).then(() => {
			                        opener.location.reload();
			                        self.close();
			                    });
			                },
			                error: function (e) {
			                    console.log(e);
			                }
			            });
			        } else {
			            return false;
			        }
			    });
			}
		}

		
	</script>
</html>