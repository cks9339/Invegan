<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<!-- bootstrap : 디자인을 위한 프레임워크 -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- jquery 는 사용하는 플러그인과 다른 라이브러리와의 충돌 여부를 확인해야 한다. -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="<c:url value='/resources/js/jquery.twbsPagination.js'/>" type="text/javascript"></script>
<style>
	table,th,td{
		border : 1px solid #f7e1ba;
		border-collapse : collapse;
		padding : 5px 10px;
		border-left : 0;
		border-right : 0;
		text-align : center;
	}
	
	th{
		background-color : #eadab8;
	}
	
	a{
		text-decoration-line : none;
		color : #d0b17c ;
		corsor : pointer;
		text-align : center;
	}
	
	#container{
		width: 1000px;
		margin: 0 auto;
	}
	
	h4{
		font-size : 13px;
	}
	
	#order{
		cursor : pointer;
		width : 66px;
	}
</style>
</head>
<body>
<%-- <c:import url="/main/header"/> --%>
<div id="container">
	<h4 id="order">가입날짜▲</h4>
	 <select id="adminSort" name="is_admin">
	 	 <option value="회원종류">회원종류</option>
	 	 <option value="일반회원">일반회원</option>
	 	 <option value="관리자">관리자</option>
	 </select>
	<h3>회원관리</h3>
	<table>
		<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입날짜</th>
			<th>정지상태</th>
			<th>권한</th>
		</tr>
		</thead>
		<tbody id="list">
		</tbody>
	</table>
		<div class="pageContainer">									
			<nav aria-label="Page navigation" style="text-align:center">
				<ul class="pagination" id="pagination"></ul>
			</nav>					
		</div>
</div>
<%-- <c:import url="/main/footer" />	 --%>
</body>
<script>
var showPage = 1;

memberListCall(showPage);

$('#order').on('click', function () {
	console.log($(this).text());
	memberListCall(showPage);
	
});

// 회원종류 선택/구분해서 리스트 보여주기
$('#adminSort').on('change', function () {
	 console.log($(this).val());
	memberListCall(showPage);

	});


 function memberListCall(page) {

	    $.ajax({
	        type: 'GET',
	        url: 'memberListCall',
	        data: {'page':page,'order':$('#order').text(),'adminSort':$('#adminSort').text()},
	        dataType:'JSON',
	        success: function(data) {
	        	console.log(data);

	     		if(data.success != 1){
	    			alert('이 페이지의 권한이 없습니다.');
	    			location.href='';
	    		}else{
	
	    			drawMemberList(data);
	    		} 
	    			
	        },error:function(e){
	        	console.log(e);
	        }
	    });
	}
 
	
	function drawMemberList(obj){
		var content = '';
		
			obj.memberList.forEach(function(item,idx) {
            content += '<tr>';
            content += '<td>' + item.user_no + '</td>';
            content += '<td><a href="/invegan/admin/detail?id=' + item.id + '">' + item.id + '</a></td>';
            content += '<td>' + item.nickname + '</td>';
            var date = new Date(item.join_date);
			var dateStr = date.toLocaleDateString("ko-KR");
			content += '<td>'+dateStr+'</td>';
            if(item.is_suspended==false){
            	content += '<td>' + '-' + '</td>';
            }else{
            	content += '<td>' + '정지기간' + '</td>';
            }
            if(item.is_admin==false){
            	content += '<td>' + '일반회원' + '</td>';
            }else{
            	content += '<td>' + '관리자' + '</td>';
            }
            content += '</tr>';
        });
        	$('#list').empty();
            $('#list').append(content);
            
            console.log(typeof twbsPagination);
            console.log(obj.pages);
            console.log(showPage);
            console.log(obj.page);
            
           $('#pagination').twbsPagination({
    			startPage: showPage, // 보여줄 페이지
    			totalPages:obj.pages, 
    			visiblePages:10,
    			onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
    				//console.log(e);
    				if(showPage != page){
    					console.log(page);
    					showPage = page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해 준다.
    					memberListCall(page);
    				}
    				
    			}
    		}); 
 
	}
 
 
 





</script>
</html>