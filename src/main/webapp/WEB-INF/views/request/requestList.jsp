<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!-- bootstrap : 디자인을 위한 프레임 워크 -->
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
		<!-- jquery는 사용하는 플러그인과 다른 라이브리와의 충돌 여부를 확인해야 한다. -->
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
		<!-- 페이징 처리를 위한 라이브러리 -->
		<script src="../resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
		<style>
			
		</style>
	</head>
	<body>
		<c:import url="/main/header" />
		<div id = "box">
			<br>
			<table>
				<thead>
					<tr>
						<th width="80px">글 번호</th>
						<th width="350px">제목</th>
						<th width="185px">작성자</th>
						<th width="90px">요청 구분</th>
						<th width="90px">처리여부</th>
						<th width="105px">작성날짜</th>
					</tr>
				</thead>
				<tbody id ="requestBody">
					<!-- 요청리스트 출력 -->
				</tbody>
			</table>
			<!-- 	플러그인 사용	(twbsPagination) - 이렇게 쓰라고 tutorial에서 제공-->
			<div class="container">									
				<nav aria-label="Page navigation" style="text-align:center">
					<ul class="pagination" id="pagination"></ul>
				</nav>					
			</div>
			<input type="button" value="글 쓰기" name="rqWrite"/>
		</div>
		<div>
			<c:import url="/main/footer" />	
		</div>
	</body>
	<script>
		var showPage = 1;
		var pagePerNum = 20;
		
		listCall(showPage);
		
		function listCall(page){
			$.ajax({
				type:'get',
				url:'requestList.do',
				data:{'pagePerNum':pagePerNum, 'page':page},
				dataType:'json',
				success:function(data) {
					console.log(data);
					drawList(data);
				},
				error:function(e){
					console.log(e);
				}
			});
		}
		
		function drawList(obj) {
			console.log(obj);
			var content = "";	
			if (obj.admin == 0) {
				obj.list.forEach(function(item, idx){
					if (item.is_hidden == 0) {
							content += '<tr>';
							content += '<td>'+item.req_id+'</td>';
							content += '<td style="display : none">'+item.user_id+'</td>';
							content += '<td style="text-align: left">'+item.req_title+'</td>';
							content += '<td>'+item.nickname+'</td>';
							content += '<td>'+item.category+'</td>';
							if (item.is_resolved == 0){
								content += '<td>'+'처리중'+'</td>';
							} else {
								content += '<td>'+'처리완료'+'</td>';
							}
							content += '<td>'+item.date+'</td>';
							content += '</tr>';
						}
				});
			} else {
				obj.list.forEach(function(item, idx){
					if (item.is_hidden == 0) {
						content += '<tr>';
						content += '<td>'+item.req_id+'</td>';
						content += '<td style="display : none">'+item.user_id+'</td>';
						content += '<td style="text-align: left">'+item.req_title+'</td>';
						content += '<td>'+item.nickname+'</td>';
						content += '<td>'+item.category+'</td>';
						if (item.is_resolved == 0){
							content += '<td>'+'처리중'+'</td>';
						} else {
							content += '<td>'+'처리완료'+'</td>';
						}
						content += '<td>'+item.date+'</td>';
						content += '</tr>';
					} else {
						content += '<tr>';
						content += '<td>'+item.req_id+'</td>';
						content += '<td style="display : none">'+item.user_id+'</td>';
						content += '<td style="text-align: left">'+item.req_title+'</td>';
						content += '<td>'+item.nickname+'</td>';
						content += '<td>'+item.category+'</td>';
						if (item.is_resolved == 0){
							content += '<td>'+'처리중'+'</td>';
						} else {
							content += '<td>'+'처리완료'+'</td>';
						}
						content += '<td>'+item.date+'</td>';
						content += '</tr>';
						$(this).css('background-color','#87878754');
					}

			});
			}
			$('#requestBody').empty();
			$('#requestBody').append(content);
			
			$('#pagination').twbsPagination({
				startPage:obj.currPage, // 보여줄 페이지
				totalPages:obj.pages, // 총 페이지 수 (총 갯수 / 페이지당 보여줄 게시물 수) : 서버에서 계산해서 가져와야 함
				visiblePages:5, // [1],[2],[3],[4],[5]
				onPageClick:function(e, page){
					// console.log(e);
					if (showPage != page) {
						console.log(page);
						showPage = page;
						listCall(page);
					}
				}
			});
		}
	</script>
</html>