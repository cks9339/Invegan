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
			  
			  .xscrollbar{
			  	overflow : auto;
			  	width : 800px;
			  	height: 457.6px;
			  	border: 1px solid black;
			  }
			  .xscrollbar table{
			  	border-collapse: collapse;
			    text-align: center;
			    width: 3000px;
			  }
			  
			  .xscrollbar th{
			  	padding : 1px;
			    height: 30px;
			    border-bottom : 1px solid black;
			    background-color: rgb(211 255 204);
			    font-size: 14px;	
			    position: sticky;
			    top: 0px;
			  }
			  
			  #box {
			  	width :  800px;
			  }
			  
			  
			  #sbutton, #gram {
			  	float: right;
			  }
			  		
			  #sbutton {
			  	margin-bottom: 10px;
			  }
			  
			  #msearch {
			  	width : 50px;
			  	height: 35px;
			  	margin-top : 1px;
			  	background: none;
			  	border: 1.5px solid black;
			  	border-radius: 5px;
				font-size : 16px;
				outline-color: #9eca9e;
			  	cursor: pointer;
			  	box-shadow: lightgray 5px 4px 7px 1px;;
			  }
			  
			  #msearch:hover {
				background-color: rgb(115 211 147 / 19%);
				border: 1.5px solid #9eca9e;
				cursor: pointer;			  
			  }
			  
			  #msearch:active {
			  	box-shadow: lightgray 3px 2px 9px 0px;
				border: 1.5px solid #9eca9e;
				color: #9eca9e;
			  }
			  
			  input[name="fname"]{
			  	height: 30px;
			  	outline-color: #9eca9e;
			  }
			  
			  
			  #down {
			  	padding : 5px 0px 0px 0px;
			  	margin-top: 10px;
			  	float : right;
			  }
			  
			  #mMaterial {
			  	width : 50px;
			  	height: 35px;
			  	margin-left : 10px;
			  	background: none;
			  	border: 1px solid gray;
			  	cursor: pointer;
			  	border-radius : 5px;
			  	box-shadow: lightgray 5px 4px 7px 1px;
			  	font-size : 16px;
			  }
			  
			  #mMaterial:hover {
			  	background-color: rgb(115 211 147 / 19%);
				border: 1.5px solid #9eca9e;
				cursor: pointer;	
			  }
			  
			  #mMaterial:active {
			  	box-shadow: lightgray 3px 2px 9px 0px;
				border: 1.5px solid #9eca9e;
				color: #9eca9e;
			  }
			  
			  #close input {
			  	cursor: pointer;
				background: none;
				border: none;
				font-size: 25px;
			  	margin-left: 10px;
			  	float: right;
			  }

		</style>
	</head>
	<body>
		<div id = "box">
			<div id="close">
				<input type="button" value="Χ" onclick="closeModal()"/>
			</div>
			<div id = "sbutton">
				<input type="text" name="fname" placeholder=" 재료 검색"/> <input type="button" id="msearch"  value="검색"/>
			</div>
			<div class="xscrollbar">
				<table>
					<thead>
						<tr>
							<th width="1%">No.</th>
							<th width="9%">식품명</th>
							<th width="5%">분류</th>
							<th width="5%">원산지 / 제조사</th>
							<th width="4%">1회 제공량(g)</th>
							<th width="4%">에너지(kcal)</th>
							<th width="3%">단백질(g)</th>
							<th width="3%">지방(g)</th>
							<th width="3%">탄수화물(g)</th>
							<th width="3%">총 당류(g)</th>
							<th width="4%">총 식이섬유(g)</th>
							<th width="3%">칼슘(mg)</th>
							<th width="3%">철(mg)</th>
							<th width="4%">마그네슘(mg)</th>
							<th width="3%">인(mg)</th>
							<th width="3%">칼륨(mg)</th>
							<th width="4%">나트륨(mg)</th>
							<th width="3%">아연(mg)</th>
							<th width="4%">비타민A(µg)</th>
							<th width="4%">비타민B6(mg)</th>
							<th width="4%">비타민B12(mg)</th>
							<th width="4%">비타민C(mg)</th>
							<th width="5%">필수 아미노산(mg)</th>
							<th width="3%">오메가 3(g)</th>
						</tr>
					</thead>
					<tbody id = "materialList">
						<!-- 여기에 입력 -->
					</tbody>
				</table>
			</div>
			<div id="down">
				<a><input type="text" name="gram"/> g</a>	
				<input type="button" id ="mMaterial" value="완료"/>
			</div>	
		</div>
	</body>
	<script>
		var food_id; // food_id
		var fName;
		var mName; // material_name
		var grams; // gram

		// 재료 검색
		$('#msearch').on('click', function(){
			fName = $('input[name="fname"]').val();
			
			console.log('food_name : '+fName);
			if (fName != ''){
				$.ajax({
					type:'get',
				    url:'mlist.do',
				    data:{'fName' : fName},
				    dataType:'json',
				    success:function(data){
				       console.log(data);
				       if (data.mlist.length == 0){
							swal({
					            title: "입력하신 재료가 존재하지 않습니다.",
					            text: "관리자에게 문의해 주세요",
					            icon: "info",
					        });
							$('input[name="fname"]').val('');	
				       } else {
							drawList(data.mlist);
				       }			       
				    },
				    error:function(e){
				       console.log(e);
				    }
				});
			} else {
				swal({
            	    title: "검색어를 입력해주세요 !",
            	    text: "",
            	    icon: "error",
            	})		
			}
			

		});
		
		// 재료 리스트 그리기
		function drawList(mlist) {
			console.log(mlist);
			var content = '';
			mlist.forEach(function(item, idx){
					content += '<tr>';
					content += '<td width="1%">'+(idx+1)+'</td>';
					content += '<td style="display : none;">'+item.food_id+'</td>';
					content += '<td width="9%">'+item.food_name+'</td>';
					content += '<td width="5%">'+item.food_category+'</td>';
					content += '<td width="5%">'+item.production+'</td>';
					content += '<td width="4%">'+item.serving_size+'</td>';
					content += '<td width="4%">'+item.kcal+'</td>';
					content += '<td width="3%">'+item.prot+'</td>';
					content += '<td width="3%">'+item.fat+'</td>';
					content += '<td width="3%">'+item.carb+'</td>';
					content += '<td width="3%">'+item.sugar+'</td>';
					content += '<td width="4%">'+item.fiber+'</td>';
					content += '<td width="3%">'+item.ca+'</td>';
					content += '<td width="3%">'+item.fe+'</td>';
					content += '<td width="4%">'+item.mg+'</td>';
					content += '<td width="3%">'+item.p+'</td>';
					content += '<td width="3%">'+item.k+'</td>';
					content += '<td width="4%">'+item.na+'</td>';
					content += '<td width="3%">'+item.zn+'</td>';
					content += '<td width="4%">'+item.vit_a+'</td>';
					content += '<td width="4%">'+item.vit_b6+'</td>';
					content += '<td width="4%">'+item.vit_b12+'</td>';
					content += '<td width="4%">'+item.vit_c+'</td>';
					content += '<td width="5%">'+item.essential+'</td>';
					content += '<td width="3%">'+item.omega3+'</td>';
					content += '</tr>';
			});
			$('#materialList').empty();
			$('#materialList').append(content);
		}
		
        $('#materialList').on('click', 'tr', function() {
        	$('#materialList tr').css('background', 'none');
            food_id = $(this).find('td:eq(1)').text();
            fName = $(this).find('td:eq(2)').text();
            $(this).css('background-color','rgb(115 211 147 / 19%)');
            console.log('클릭한 food_name: ' + fName);
        });
        
        // 재료 추가
        $('#mMaterial').on('click', function() {
        	grams = $('input[name="gram"]').val();
        	console.log('전송한 food_name : ' + mName);
        	console.log('입력한 grams 수 : '+grams);
        	
        	// gram에 문자가 있을경우 alert
			var regex = new RegExp('[^0-9\\s]');
			var match = regex.test(grams);
			
			if (food_id == null) {
				swal({
		            title: "재료를 선택해 주세요",
		            text: "",
		            icon: "info",
		        });
			} else if (match || grams === '0' || grams.trim() === ''){
			    swal({
		            title: "0이 아닌 숫자만 입력해 주세요",
		            text: "",
		            icon: "info",
		        });
			    $('input[name="gram"]').val('');	
			} else{
	        	$.ajax({
	        		type:'get',
	        		url:'mMaterial',
	        		data:{"food_id":food_id, "grams":grams},
	        		dataType:'JSON',
	        		success:function(data){
	        			console.log(data);				
ㅊ
	        		},
	        		error:function(e) {
	        			console.log(e);
	        		} 
	        	});
	        	swal({
		            title: "레시피에 재료가 추가되었습니다.",
		            text: "",
		            icon: "info",
		        });
	        	closeModal();

			}			
        });
        
    	function closeModal() {
        	var modal = document.getElementById("mModal");
        	modal.style.display = "none";
        	myRecipeMenu();
    	}
    	
    	
		
	</script>
</html>