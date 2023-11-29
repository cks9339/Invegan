<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
table {
	margin-left: auto;
	margin-right: auto;
}

input[id="addM"] {
	margin-top: 30px;
	height: 30px;
}
.addbtn{
	text-align: center;
}

input[type="submit"] {
    background-color: #4682b4; 
    border-radius: 10px;
    color: white;
    border: none;
    cursor: pointer;
}

body {
    background-color: #edf0ef; 
}

input[type="submit"]:hover {
    background-color: #36648b; /* hover */
}


</style>
</head>
<body>
	<h3 align="center">식재료 추가</h3>
	<hr />
	<form action="addMaterial.do" method="post">
	<div >
		<table>
			<tr style="vertical-align: top">
				<td id="food_semi"
					style="width: 400px; border-right: 1px solid gray; padding-right: 12px; text-align: justify">
					식품명 : <input type="text" id="food_name" required name="food_name"
					placeholder="* 식품명 입력" />
				<p>
						분류 : <input type="text" id="food_category" required name="food_category"
							placeholder="* 분류명 입력" /></p>
				<p>
						원산지/제조사 : <input type="text"
							required name="production" placeholder="원산지/제조사 입력" /></p>
					<p>
						1회 제공량(g) : <input type="text"
							required name="serving_size" onkeyup="imsi(this)" placeholder="* g 입력" /></p>
				</td>
				<td style="padding-left: 100px" id="food_detail">열량 <input
					type="text" required name="kcal" onkeyup="imsi(this)" placeholder="* kcal 입력" /> kcal
					<p>
						탄수화물 <input type="text" onkeyup="imsi(this)" required name="carb" placeholder="* g입력" />
						g</p>
					<p>
						단백질 <input type="text" onkeyup="imsi(this)" required name="prot" placeholder="* g입력" />
						g</p>
					<p>
						지방 <input type="text" onkeyup="imsi(this)" required name="fat" placeholder="* g입력" /> g</p>
					<p>
						총 당류 <input type="text" onkeyup="imsi(this)" required name="sugar"
							placeholder="* g입력" /> g</p>
					<p>
						총 식이섬유 <input type="text" onkeyup="imsi(this)" required name="fiber"
							placeholder="* g입력" /> g</p>
					<p>
						칼슘 <input type="text" onkeyup="imsi(this)" required name="ca" placeholder="* mg입력" /> mg</p>
					<p>
						철 <input type="text" onkeyup="imsi(this)" required name="fe" placeholder="* mg입력" /> mg</p>
					<p>
						마그네슘 <input type="text" onkeyup="imsi(this)" required name="mg" placeholder="* mg입력" />
						mg</p>
					<p>
						인 <input type="text" onkeyup="imsi(this)" required name="p" placeholder="* mg입력" /> mg</p>
					<p>
						칼륨 <input type="text" onkeyup="imsi(this)" required name="k" placeholder="* mg입력" /> mg</p>
					<p>
						나트륨 <input type="text" onkeyup="imsi(this)" required name="na" placeholder="* mg입력" />
						mg</p>
					<p>
						아연 <input type="text" onkeyup="imsi(this)" required name="zn" placeholder="* mg입력" /> mg</p>
					<p>
						비타민A <input type="text" onkeyup="imsi(this)" required name="vit_a"
							placeholder="* ㎍입력" /> ㎍</p>
					<p>
						비타민B6 <input type="text" onkeyup="imsi(this)" required name="vit_b6"
							placeholder="* mg입력" /> mg</p>
					<p>
						비타민B12 <input type="text" onkeyup="imsi(this)" required name="vit_b12"
							placeholder="* mg입력" /> mg</p>
					<p>
						비타민C <input type="text" onkeyup="imsi(this)" required name="vit_c"
							placeholder="* mg입력" /> mg</p>
					<p>
						필수 아미노산 <input type="text" onkeyup="imsi(this)" required name="essential"
							placeholder="* mg입력" /> mg</p>
					<p>
						오메가 3 <input type="text" onkeyup="imsi(this)" required name="omega3"
							placeholder="* g입력" /> g</p>
							</td>
			</tr>
		</table>		
		</div>
		<div class="addbtn">
		<input type="submit" id="addM" value="(관리자) 식재료 추가"/>
		</div>
	</form>



</body>
<script>

	

	var prev = "";
	var regexp = /^\d*(\.\d{0,2})?$/;
	function imsi(obj) {
    	if(obj.value.search(regexp)==-1) {
        obj.value = prev;
    	}
   	 else {
   	     prev = obj.value;
   		}
	}


	var msg = "${msg}";
	if(msg != ""){
		console.log(msg);
		swal({
      	    title: msg,
      	    text: "",
      	    icon: "info"
      	});
	}
/*
const urlParams = new URLSearchParams(window.location.search);
const msg = urlParams.get("msg");

if (msg) {

    alert(msg);
  }
*/

</script>
</html>