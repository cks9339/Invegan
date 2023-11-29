<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- xeicon -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<style>
/*header 부트스트랩 적용 방지*/
body {
	margin: 8px !important;
}

/* 왼쪽 사이드바 메뉴 스타일 */
.container {
	width: 1000px;
	margin: 0 auto;
}

input[type="text"] {
	width: 310px;
    height: 45px;
    padding-left: 10px;
    font-size: 18px;
}

.post-header img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.username {
	font-weight: bold;
}

/*.post img {
	max-width: 50%;
	height: auto;
} */
.mainFeedPhoto {
	width: 500px;
	height: 500px;
}

.post-caption .username {
	font-weight: bold;
}

/* 댓글 스타일 */
.post-comments {
	padding: 10px;
}

.comment {
	margin-bottom: 10px;
}

.comment .username {
	font-weight: bold;
}

.side-tag{
	width: 310px;
}

/* .feedWriteModal {
	display: none;
}

.feedDetailModal {
	display: none;
}
 */
.commentFeedWrite {
	float: right;
}

.post-del-btn, .post-edit-btn {
	float: right;
}

.ui-autocomplete {
	max-height: 200px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden;
	height: auto;
}
#autoComplete:focus, #autoComplete:hover {
	font-weight: 600;
}

.ui-menu-item div.ui-state-hover, .ui-menu-item div.ui-state-active {
	color: #ffffff;
	text-decoration: none;
	background-color: #f6B664;
	border-radius: 0px;
	-webkit-border-radius: 0px;
	-moz-border-radius: 0px;
	background-image: none;
	border: none;
}

.no-comment {
	color: gray;
}

.addBtnSearch, .addBtn {
	display: none;
	margin-left: 830px;
	border: none;
	background-color: transparent;
	cursor: pointer;
}

.addBtnImg {
	width: 40px;
}

.btn {
	width: 100px;
	margin-top: 5px;
	margin-bottom: 5px;
	height: 40px;
}

.addBtn:disabled {
	cursor: not-allowed;
	opacity: 0.5;
}

.addBtnSearch:disabled {
	cursor: not-allowed;
	opacity: 0.5;
}

.addBtn:disabled:hover::before, .addBtnSearch:disabled:hover::before {
	content: "마지막 게시글입니다";
	/* 다른 스타일링을 추가하거나 위치를 조절할 수 있습니다. */
	position: absolute;
	background-color: #fff; /* 텍스트 배경색 */
	padding: 5px;
	border: 1px solid #ccc; /* 텍스트 테두리 스타일 */
	border-radius: 5px;
	color: #333; /* 텍스트 색상 */
}

.btn-success {
	width: 150px;
	margin-bottom: 5px;
	height: 40px;
}

.mainFeedPhoto {
	border: 1px solid gray;
}

.custom-col-1 {
	border-left: 1px solid #000; /* 선의 스타일, 색상 및 두께를 조정합니다. */
	height: 100vh; /* 컨테이너의 높이에 맞추도록 설정합니다. */
	position: sticky;
	top: 0; /* 페이지의 상단에 고정합니다. */
}

 .col-3 {
	z-index: 1;

}

#write-btn {
    width: 158px;
    height: 50px;
    margin: 20px 77px;
}

#content {
	height: 200px;
}
.post{
	width: 500px;
	margin: 0 auto;
}
.post-time {
/* 	border-bottom: 1px solid #cdd6df; */
	width: 500px;
	margin-bottom: 10px;
}

#post-tag {
	font-size: 12px;
	height: 30px;
	width: 60px;
	text-align: center;
	margin-left: 5px;
}

#nameSearchBtn, #searchBtn{
	background: none;
    width: 45px;
    position: absolute;
    right: 0px;
    right: 15px;
    height: 35px;
    border-left: 1px solid black;
    border-radius: 0px;
}

.side-searchTag, .side-searchNick{
	width: 100%;
}


/*작성버튼*/
#write-btn{
	color: #86bd86;
    width: 152px;
    background: none;
    padding: 6px 10px;
    font-size: 17px;
    margin: 16px 3px;
    border-radius: 5px;
    border: 2px solid #86bd86;
    box-shadow: lightgray 5px 4px 7px 1px;
    outline-color: #86bd86;
    position: absolute;
    bottom: -85px;
    left: 71px;
}
#write-btn:hover{
	cursor: pointer;
	color: black;
	border: 1.3px solid black;
}
#write-btn:active{
	box-shadow: lightgray 3px 2px 9px 0px;
	border: 1.3px solid #9eca9e;
	color: #9eca9e;
 	position: absolute;
    bottom: -87px;
    left: 73px;
	
}
</style>

</head>

<body>
	<c:import url="/main/header" />


	<div id="feedWriteModal" class="feedWriteModal">
		<%@ include file="feedWrite.jsp"%>
	</div>

	<div id="feedDetailModal" class="feedDetailModal">
		<%@ include file="feedDetail.jsp"%>
	</div>




	<div class="container-fluid" >

		<div class="list-box">
			<div class="col-3 custom-col-3" style="position: fixed; left: 90px; top: 222px; width: 310px; padding: 0;">
				<div class="side-tag">
					<button class="btn btn-outline-info clickTagSearch" name="food">#식품</button>
					<button class="btn btn-outline-info clickTagSearch" name="beauty">#뷰티</button>
					<button class="btn btn-outline-info clickTagSearch" name="fashion">#패션</button>
					<button class="btn btn-outline-info clickTagSearch" name="daily">#일상</button>
					<button class="btn btn-outline-info clickTagSearch" name="restaurant">#식당</button>
					<button class="btn btn-outline-info clickTagSearch" name="recipe">#레시피</button>
					<button class="btn btn-outline-info clickResult" style="width: 310px">전체보기</button>
				</div>
				<div class="side-searchTag">
					<label>태그 검색</label>
					<div id="autoSearch">
						<input type="text" id="autoComplete" class="autoComplete">
						<button id="searchBtn" class="btn btn-Dark">
							<i class="xi-search"></i>
						</button>
					</div>
				</div>
				<div class="side-searchNick">
					<label>닉네임 검색</label>
					<div id="nickNameSearch">
						<input type="text" class="nameSearch" >
						<button id="nameSearchBtn" class="btn btn-Dark" onclick="searchNick()">
							<i class="xi-search"></i>
						</button>
					</div>
				</div>
				<button id="write-btn" class="btn btn-success">피드게시글 작성</button>
			</div>
			<div></div>
			<div >
				<div id="feedList" class="feedListPost">
					<!-- 피드 리스트 동적으로 그리기 -->
				</div>
			</div>
		</div>

	</div>
	<!-- 가운데에 내용 배치 -->



	<button id="addBtn" class="addBtn">
		<img src="<c:url value='/resources/main/morebtn.png' />" alt="More Button" class="addBtnImg">
	</button>

	<button id="addBtnSearch" class="addBtnSearch">
		<img src="<c:url value='/resources/main/morebtn.png' />" alt="More Button" class="addBtnImg">
	</button>

	<!-- 위와 같은 구조의 다른 Instagram 피드 게시물들을 추가 -->



</body>
<script>
	// 메인에서 리스트로 넘어올때 처리
	var post_id;
	
	$(document).ready(function(){
		var nickname = "${getNickname}";
		post_id = "${getPost_id}";
		if(nickname != '' && post_id != ''){
			 $('.addBtnImg').hide();
			console.log('nickname from main page',nickname);
			$('.nameSearch').val(nickname);
			var searchNick = $('#nameSearchBtn');
			searchNick.trigger('click');	
			searchNick();
			
		}
	});
	

	

	//header 카테고리 선택유지
	$('#go_feed').css('box-shadow','#95df95 0px 2px 0px 0px');
	
	var loginInfo;
	var limitcnt = 10;
	var searchbt = '#전체리스트';
	//     var autoText ="*";
	
    listTagCall();
		
    
    $('.addBtn').css('display', 'block');
    //         moreList(); 
    $('#autoComplete').autocomplete(
            {source: function (request, response) { //source: 입력시 보일 목록
                 $.ajax({
                    url: 'feed/autocomplete.do',
                    type: 'POST',
                    dataType: 'JSON',
                    data: {value: request.term},
                            success: function (data) { // 성공
                            console.log(data);
                            console.log(data.resultList);
                            response($.map(data.resultList,function (item) {
                                    return {
                                    	label: item.tag_content + ' (' + item.tag_count + ')', // 목록에 표시되는 값
                                        value: item.tag_content, // 실제 입력 필드에 삽입되는 값
                                        idx: item.tag_id
                                    };
                                     })); //response
                                     
                            },
                            error: function (e) { //실패
                                console.log("AJAX 오류 발생:");
                                console.log(e);
                            }
                        });
                },
                focus: function (event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
                    return false;
                },
                minLength: 1// 최소 글자수
                ,
                autoFocus: true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
                ,
                delay: 50 //autocomplete 딜레이 시간(ms)
                ,
                select: function (evt, ui) {
                    // 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
                    console.log(ui.item.label);
                    console.log(ui.item.value);
                    console.log(ui.item.idx);
                    setTimeout(function(){
                    	$('#autoComplete').autocomplete('close');
                    },200); //엔터로 검색시 리스트 사라짐
                }
            }).keydown(function (e) {
                if (e.keyCode === 13) { // Enter 키 코드는 13
                    clickResult();
                     console.log('엔터 키 눌림, 검색 실행');
                 }
             });
						
						
						

						

// 						$('body').css('overflow', 'auto');
						$('#write-btn').on('click', function() {
						    console.log('a');
						    console.log(loginInfo);
						    if (loginInfo == null) {
						        swal({
						            title: "로그인이 필요합니다 !",
						            text: "",
						            icon: "error",
						            allowOutsideClick: false //외부창 눌러서 끄기
						        }).then((result) => {
						            if (result) {
						                // loginInfo가 null일 때 로그인 페이지로 이동
						                location.href = "/invegan/";
						            }
						        });
						    } else {
						        // loginInfo가 null이 아닐 때 모달 창을 수동으로 엽니다.
						        $('.bd-example-modal-xl').modal('show');
						    }
						});
						







						// list 불러오기와 tag 선택했을떄 list 불러오기         
						function listTagCall() {

							console.log("listTagCall 메서드 호출");

							$.ajax({
								type : 'GET',
								url : 'searchByTag',
								data : {
									'searchbt' : searchbt,
									'limitcnt' : limitcnt
								},
								dataType : 'JSON',
								success : function(data) {
// 									console.log(data);
// 									console.log(data.list);
// 									console.log(data.listSize);
// 									console.log(data.limitcnt);
									drawList(data.list);
									loginInfo = data.loginInfo;
									console.log(loginInfo);
									
									if (data.limitcnt > data.listSize) {
										$('.addBtn').prop('disabled', true);
										
									} else {
										$('.addBtn').prop('disabled', false);
									}
								},
								error : function(error) {
									console.log("버튼클릭 리스트불러오기 에러" + error);
								}
							});
						}
						// 기본태그를 클릭했을때 나오는 리스트 처리
						$(document).on('click', '.clickTagSearch', function() {
							backToTop();
							$('.addBtnImg').show();
							limitcnt = 10;
							$('.addBtn').css('display', 'block');
							$('.addBtnSearch').css('display', 'none');
							searchbt =$(this).text();
							$('#autoComplete').val('');
							$('.nameSearch').val('');
							console.log(searchbt);
							console.log(limitcnt);
							listTagCall();
							
							$('.clickTagSearch').removeClass('active'); // 모든 버튼에서 active 클래스 제거
							console.log(this);
						    $(this).addClass('active');

						});

						// 전체리스트와 피드태그를 선택했을때 더보기 처리
						$('.addBtn').on('click', function() {
					
							limitcnt += 10;
							console.log('click');
							console.log('aa');
							listTagCall();

						})

						// 피드를 검색했을때 나오는 더보기 처리
						$('.addBtnSearch').on('click', function() {
							limitcnt += 10;
							console.log('click');
							console.log('bb');
							autoListCall();

						})
						
						function drawList(list) {
							console.log(list);
							var content = '';
							var clickedTag = searchbt.toLowerCase();
							list.forEach(function(item, idx) {			
								var tags = item.tag_content;
								var allowedTags = [ '#식품', '#패션','#일상', '#레시피', '#뷰티', '#식당' ];
									
								var selectedTagIndex = allowedTags.findIndex(function (tag) {
								    return tag.toLowerCase() === clickedTag;
								});

								if (selectedTagIndex !== -1) {
								    var selectedTag = allowedTags.splice(selectedTagIndex, 1);
								    allowedTags = [selectedTag[0]].concat(allowedTags);
								}
								
									content += '<div class="post">';
									if (tags) {
										allowedTags.forEach(function(tag) {
											if (tags.includes(tag)) {
												
							                    content += '<button class="btn btn-outline-info listTags active " id="post-tag">' + tag + '</button>';
												}
											});
										}
									
									content += '<div class="post-header">';
									var defaultImagePath = '/invegan/resources/main/profile.jpg';
									var profileImagePath = item.profile_image ? '/photo/' + item.profile_image : defaultImagePath;
									content += '<div class="user-profile"><img src="' + profileImagePath + '"></div>'; // 사용자의 프로필 사진
									content += '<span class="username">'+ item.nickname + '</span>';
									content += '</div>';
									content += '<div class="post-details">';
									content += '<div class="post-image">';
									content += '<a href="#" class="post-link" data-post-id="'+ item.post_id+ '" data-toggle="modal" data-target="#detailModal" style="display: block; width: 500px; height: 500px;">';
									console.log(item.post_id);
									content += '<img src="/photo/' + item.server_file_name + '" class="mainFeedPhoto">';
									content += '</a>';
									content += '</div>';
									content += '<div class="post-content"  style="width:500px">';
									
									var feedContentTxt = item.content;
									var truncatedTxt = truncateTxt(feedContentTxt, 100);

									function truncateTxt(txt, maxLength) {
									    if (txt.length > maxLength) {
									        return txt.substring(0, maxLength) + '...';
									    }
									    return txt;
									}

									content += '<span class="feed-content">' + truncatedTxt + '</span>';
									content += '<div class="post-caption">';
									content += '</div>';
									content += '<div class="post-comments">';
									content += '<div class="comment comments">';

									if (item.comment_user_nickname !== null && item.comment_text !== null) {
									    content += '<span class="username">' + item.comment_user_nickname + '</span>';
									    content += '<div class="detail-href">';
									    content += '<span class="comment">' + item.comment_text + '</span>';
									    content += '</div>';
									} else {
									    content +=  '<div class="no-comment">아직 댓글이 없습니다.</div>';
									}

									content += '</div>';
									content += '</div>';
									content += '</div>';
									var date = new Date(item.date);
									var dateStr = date.toLocaleDateString("ko-KR"); //en-US
									content += '<div class="tag-content" style="width:500px; color: #808080;">'+ item.tag_content + '</div>';
									content += '<div class="post-time">'+ dateStr + '</div>';
									content += '</div>';
									

									});
							$('#feedList').html(content);

						}
						
						
						function autoListCall() {
						    console.log('autoListCall 호출');

						    $.ajax({
						        url: 'autoSearchTag',
						        data: {
						            'autoText': autoText,
						            'limitcnt': limitcnt
						        },
						        success: function (data) {
						            console.log(data);
						            console.log(data.searchResult);
						            console.log(data.limitcnt);
						            console.log(data.listSize);
						            drawList(data.list);
						            if (data.listSize < 1) {
						                swal({
						                    title: "해당 태그의 게시글이 없습니다.",
						                    text: "",
						                    icon: "info",
						                }).then((result) => {
						                    if (result) {
						                        flag = true;
						                        location.href = "list.go";
						                    }
						                }); // 이 부분에 괄호 추가
						            }

						            if (data.limitcnt > data.listSize) {
						                $('.addBtnSearch').prop('disabled', true);
						            } else {
						                $('.addBtnSearch').prop('disabled', false);
						            }
						        },
						        error: function (e) {
						            console.log('에러발생' + e);
						        },
						    });
						}
						//자동완성 검색 // 전체보기
						function clickResult() {
						    backToTop();
						    autoText = $('#autoComplete').val();
						    $('.nameSearch').val('');
						    limitcnt = 10;
						    console.log('click');
						    $('.clickTagSearch').removeClass('active');
						    $('.addBtn').css('display', 'none');
						    $('.addBtnSearch').css('display', 'block');
						    $('.addBtnImg').show();
						
						    autoListCall();
						}
						$(document).on('click', '#searchBtn', function () {
						    clickResult();
						});
             			//전체보기			
						$('.clickResult').on('click',function(){
							$('#autoComplete').val('');
							clickResult();
							
						});
						
						
						
						//닉네임 검색
						function searchNick(){
							
							if (post_id == '') {
								backToTop();
								var nameText = $('.nameSearch').val();
								console.log('nameText chk',nameText);
								$('#autoComplete').val('');
								$.ajax({
									url:'feed/nameSearch',
									data:{nameText : nameText},
									success:function(data){
										 if (data.list.length === 0) {    
								                showNoResultsMessage();
								            } else {							                
								                drawList(data.list);
								                $('.addBtnImg').hide();
								            }
										drawList(data.list);
										$('.addBtnImg').hide();
									},
									error:function(e){
										console.log('닉네임 검색 오류'+e);
									},
								});
							} else {
								var nameText = $('.nameSearch').val();
								console.log('nameText chk',nameText);
								console.log('post_id',post_id);
						
								$.ajax({
									url:'feed/mainClickFeed.do',
									data:{"nameText":nameText, "post_id":post_id},
									dataType:'json',
									success:function(data){
										console.log(data);
										drawList(data.list);
										post_id = '';
									},
									error:function(e){
										console.log(e);
									}
								});
							}

						}
						
					function showNoResultsMessage(){
							swal({
                                title: "해당 닉네임이 작성한 게시글이 없습니다.",
                                text: "",
                                icon: "error"
                            }).then((result) => {
					            if (result) {
					                // loginInfo가 null일 때 로그인 페이지로 이동
					                location.href = "list.go";
					            }
					        });
					    } 


		function backToTop() {
			  const position =
				    document.documentElement.scrollTop || document.body.scrollTop;
				  if (position > 0) {
				    window.requestAnimationFrame(() => {
				      window.scrollTo(0, position - position / 10);
				      backToTop();
				    });
				  }
				}

		
		
		




</script>

</html>