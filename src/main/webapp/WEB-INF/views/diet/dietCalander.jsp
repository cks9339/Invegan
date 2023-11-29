<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<title>Calendar</title>
<style>
#container{
	width: 1000px;
	margin: 0px auto;
}

.today, .pastDay, .futureDay{
	width: 50px;
	height: 50px;
	padding: 5px;
}

.today:hover, .pastDay:hover, .futureDay:hover{
	cursor: pointer;
	box-shadow:#63c166 1px 1px 9px 0px;
	
}
thead td{
	width: 30px;
	height: 30px;
}

#yearMonth {
	text-align: center;
		font-size: 26px;
}

#day {
	text-align: center;
}
#day td{
	border-radius: 4px;
    border: 1px solid black;
}
tbody tr td:not(.today){
	border: 1px solid black;
	border-radius: 4px;
}

.Calendar {
	width: inherit;
	height: 700px;
	position: relative;
}

.Calendar>thead>tr:first-child>td {
	font-weight: bold;
}

.Calendar>thead>tr:last-child>td {
	background-color: #bbe8b7;
    color: black;
}


.pastDay {
	color: #898585;
	background-color: transparent;
}

.today {
	box-shadow:#ee0000 1px 1px 9px 0px;
	font-size: 16px;
	font-weight: 600;
}

.futureDay {
	background-color: white;
	font-weight: 600;
}

.choiceDay {
	cursor: pointer;
	box-shadow:#63c166 1px 1px 9px 0px;
}


.dayData{
	height: 50px;
}


#yearMonth div{
	display: inline-block;
}

select {
	position: absolute;
	top: 33px;
	left: 5px;
}

#next , #prev{
	text-align: center;
	font-size: 34px;
}

.futureDay.choiceDay {
	background-color: transparent;
	cursor: pointer;
}

.nutriData{
	text-align: center;
}
</style>
</head>
<body>
	<c:import url="/main/header" />
	<div id="container">
		<table class="Calendar">
			<thead>
				<tr style="height: 80px;">
					<td onClick="prevCalendar();" id="prev" style="cursor: pointer;">&#60;</td>

					<td colspan="5" id="yearMonth">
						<div id="calYear"></div>
						<div id="calMonth"></div>
					</td>

					<td onClick="nextCalendar();" id="next" style="cursor: pointer;">&#62;</td>
				</tr>
				<tr id="day">
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
<%-- 	<c:import url="/main/footer" /> --%>
</body>

<script>
	/*식단관리 페이지에서 카테고리 표시*/
	$('#go_diet').css('box-shadow','#95df95 0px 2px 0px 0px');

	var	nowMonth = new Date(); // 현재 달을 페이지를 로드한 날의 달로 초기화
	var	today = new Date();
	var	selectYear = new Date();
		today.setHours(0, 0, 0, 0);
	var selectDate = "";
	buildCalendar();
	// 날짜 클릭시 실행
 	function dietMgmt() {
		console.log('go mgmt click')
		location.href = "dietMgmt?date=" + selectDate;
	} 

	
	// 숫자가 10보다 작을 때 앞에 0을 붙여서 반환
	function leftPad(value) {
		if (value < 10) {
			value = "0" + value;
			return value;
		}
		return value;
	} 
	
	
	function buildCalendar() {
		 /* nowMonth = new Date(); // 현재 달을 페이지를 로드한 날의 달로 초기화
		 today = new Date();
		 selectYear = new Date(); 
		today.setHours(0, 0, 0, 0);
		*/		
		let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1); // 이번달 1일
		let lastDate = new Date(nowMonth.getFullYear(),
				nowMonth.getMonth() + 1, 0); // 이번달 마지막날

		let tbody_Calendar = document.querySelector(".Calendar > tbody");
		document.getElementById("calYear").innerText = nowMonth.getFullYear(); // 연도 숫자 갱신
		document.getElementById("calMonth").innerText = leftPad(nowMonth
				.getMonth() + 1); // 월 숫자 갱신

		while (tbody_Calendar.rows.length > 0) { // 이전 출력결과가 남아있는 경우 초기화
			tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
		}

		let nowRow = tbody_Calendar.insertRow(); // 첫번째 행 추가           

		for (let j = 0; j < firstDate.getDay(); j++) { // 이번달 1일의 요일만큼
			let nowColumn = nowRow.insertCell(); // 열 추가
		}
		
		
		// 칼로리 정보 가져오기
		// 칼로리를 가져오기 위한 파람값 설정
		var yearMonth = $('#calYear').text() + "-" + $('#calMonth').text();
		console.log('가져올 년 월',yearMonth);
		
		$.ajax({
			type : 'get',
			url : 'getMonthKcal',
			data : {'yearMonth':yearMonth},
			dataType : 'JSON',
			success : function(data) {
				console.log('getKcal',data.getKcal);
				let getKcal = data.getKcal;
				drawCalendar(getKcal);
			},
			error : function(data) {
				console.log(data);
			}
		});
		function drawCalendar(getKcal){
			
				
				for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) { // nowDay는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  
				
					 var nowColumn = nowRow.insertCell(); // 새 열을 추가하고
				
					/* 날짜 칸에 데이터 넣는 곳 */
					/* nowColumn.innerText = leftPad(nowDay.getDate()); // 추가한 열에 날짜 입력  */	// 기존코드
					var nutriDataHtml;	
					var dataHtml;
					var kcalData;
					if(getKcal != null){
						 kcalData = getKcal.find(item => {
							let itemData = new Date(item.date);
							return (
								itemData.getFullYear() == nowDay.getFullYear() &&
								itemData.getMonth() == nowDay.getMonth() &&
								itemData.getDate() == nowDay.getDate()
							);
						});	
						console.log('kcalData',kcalData);
						if(!kcalData){
							kcalData = { total_Kcal: 0, stdKcal: 0 };
						}
					}else{
						kcalData = { total_Kcal: 0, stdKcal: 0 };
					}
							nutriDataHtml = "<div class='nutriData'>"+kcalData.total_Kcal+" /<br/>"+kcalData.stdKcal+" Kcal</div>";
						console.log('nutriDataHtml',nutriDataHtml);
						
						dataHtml = "<div class='dayData'>"+leftPad(nowDay.getDate())+"</div>"	
								+ nutriDataHtml;
						console.log('dataHtml',dataHtml);
				
								
					nowColumn.innerHTML = dataHtml; 
	
					if (nowDay.getDay() == 0) {
						/*  nowColumn.style.color = "red";  */ 	// 기존 코드
						nowColumn.querySelector(".dayData").style.color = "red";	// 수정한 코드
					}
					if (nowDay.getDay() == 6) {
						nowRow = tbody_Calendar.insertRow(); // 새로운 행 추가
					}
					if (nowDay < today) { // 지난날인 경우
						nowColumn.className = "pastDay";
						nowColumn.onclick = function() {
							console.log('this',this);
							choiceDate(this);
						}
					}else if (nowDay.getFullYear() == today.getFullYear()
							&& nowDay.getMonth() == today.getMonth()
							&& nowDay.getDate() == today.getDate()) { // 오늘인 경우           
						nowColumn.className = "today";
						nowColumn.onclick = function() {
							choiceDate(this);
						}
					}else { // 미래인 경우
						nowColumn.className = "futureDay";
						nowColumn.onclick = function() {
							choiceDate(this);
						}
					}
				}
		}
		
		
		
	}
		
	
	

 	// 날짜 선택
	function choiceDate(nowColumn) {
		console.log('nowColumn', nowColumn)
		let existingChoiceDay = document.querySelector(".choiceDay");

		if (existingChoiceDay) {
			existingChoiceDay.classList.remove("choiceDay");
		}

		if (nowColumn.classList.contains("pastDay")) {
			nowColumn.classList.add("choiceDay");

		} else {
			nowColumn.classList.add("choiceDay");
		}
		// 클릭한 날짜 값
		selectDate = $('#calYear').text() + "-" + $('#calMonth').text() + "-"
				+ $('.choiceDay .dayData').text();
		console.log(selectDate);
		dietMgmt();
	}

	 // 이전달 버튼 클릭할 때 함수
	function prevCalendar() {
		console.log("nowMonth",nowMonth);
		nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1,
				nowMonth.getDate()); // 현재 달을 1 감소
		buildCalendar(); // 달력 다시 생성
	}
	// 다음달 버튼 클릭할 때 함수
	function nextCalendar() {
		nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1,nowMonth.getDate()); // 현재 달을 1 증가
		buildCalendar(); // 달력 다시 생성
	} 
	
	if (nowColumn.classList.contains("pastDay")) {
		console.log('nowColumn',nowColumn);
		nowColumn.classList.add("choiceDay");

	} else {
		nowColumn.classList.add("choiceDay");
	} 
	

	
	// 년도 변경 보류
	/* document.getElementById("calYear").addEventListener("click",function(event) {
		console.log('click');
		// 클릭한 위치에 새로운 <select> 요소 생성
		var selectElement = document.createElement("select");

		// 현재 해 가져오기
		var currentYear = new Date().getFullYear();

		// 현재 해의 -2부터 +2까지의 년도 
		for (var i = -2; i <= 2; i++) {
			var optionElement = document.createElement("option"); // 선택할 옵션 생성
			optionElement.textContent = currentYear + i;
			selectElement.appendChild(optionElement); // 옵션 추가
		}
		// select 요소의 값 설정을 아무것도 없게 
		selectElement.selectedIndex = -1;

		// 새로운 <select> 요소를 클릭한 <div> 요소 안에 추가
		this.appendChild(selectElement);

		selectElement.addEventListener("change", function() {
			var selectedYear = parseInt(this.value);
			console.log("선택년도: " + selectedYear);

			// <select> 없애기
			this.remove();

			loadSelectedYear();

			function loadSelectedYear() {
				nowMonth = new Date(selectedYear, nowMonth.getMonth());
				buildCalendar();
			}

		});
	}); */
	
	
	
	
	
</script>

</html>