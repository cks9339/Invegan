<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피게시판</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<!-- 
<link rel="stylesheet" href="resources/css/common.css" type="text/css">
 -->

<style>

</style>
</head>
<body>
<c:import url="/main/header"/>
<div id=container>

<div class="searchBox">
			<form  action="search" name="search" method="post">
				<table class="">
					<tr>
						<td><select class="typeSelect" name="type">
								<option value="0">선택</option>
								<option value="title">제목</option>
								<option value="writer">작성자</option>
						</select></td>
						<td><input type="text" class="textBox" placeholder="검색어 입력하세요." name="keyword" maxlength="100"></td>
						<td><button type="submit" class="searchBtn">검색</button></td>
					</tr>

				</table>
			</form>
		</div>

</div>	
<c:import url="/main/footer"/>
</body>

<script>
$('.searchBtn').on('click',function(){
	location.href='recipe/search';
});
</script>
</html>