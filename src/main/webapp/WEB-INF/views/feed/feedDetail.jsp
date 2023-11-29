<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<style>
.post-header {
	display: flex;
	align-items: center;
	padding: 10px;
}


.post-header img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	margin-right: 10px;
}

.post-wrapper {
	width: 500vw;
	transition: transform 0.1s;
}

.post-img-slider {
	width: 100vw;
	float: left;
}

#comment-write-btn {
	float: right;
}

.btn-dark {
	width: 60px;
	height: 45px;
}

.modal-dialog.modal-fullsize {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

#detailModal .modal-content {
	width: 700px;
}

#detailModal {
	padding-right: 200px !important;
}

.modal-backdrop {
	display: block !important;
}

.custom-button {
	width: 65px;
	height: 40px;
}

.post-btn-group {
	float: right;
}

#post-img-edit-btn, #post-edit-btn {
	width: 100px;
}

.detailPostCaption {
	margin-top: 300px;
}
.detail-href{
    width: 500px;
    border-bottom: 1px solid #ccc; 
    padding: 10px; 
}
.comment-edit-btn, .comment-del-btn, #comment-save-btn, #comment-cancle-btn{
	width:50px;
	font-size:12px !important;
	height:30px;
	margin-right:10px;
}
.comment-box{
	width: 500px;
    margin: 0 auto;
}
</style>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- autocomplete 자동완성검색 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Feed Detail</title>
</head>

<body>

	<div class="modal fade bd-detail-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" data-backdrop="true" id="detailModal" style="padding-right: 500px;">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myExtraLargeModalLabel">피드 상세보기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body" id="feedDetail"></div>

			</div>
		</div>
	</div>


</body>
<script>
$(document).ready(function(){
	

});
	

  var loginInfo;
  
  // feedDetail 처리
  $(document).on('click', '.post-link', function() {
	  
     var post_id = $(this).data('post-id');
     console.log(post_id);

     $('.modal-backdrop').css({ 'display': 'none' });
     
     $.ajax({
         type: 'GET',
         url: 'feed/feedDetailCall', // 데이터를 제공하는 서버의 엔드포인트로 변경
         data: { post_id: post_id },
         success: function(data) {
             drawdetailList(data.detailList,data.findBoardUserno,data.user_no,data.is_admin); // 게시글 상세보기 리스트
             drawcommentList(data.commentList,data.user_no);
             loginInfo = data.loginInfo;
             console.log(loginInfo);
             console.log('is_admin============='+data.is_admin);
             
             $('.feedDetailModal').css({ 'display': 'block' });
         },
         error: function(error) {
             console.log('데이터 가져오기에 실패했습니다: ' + error);
         }
     });
       
  });
  
  function drawcommentList(commentList, user_no) {
	    var commentContent = '';

	    console.log(commentList);
	    console.log(user_no);
	    commentContent += '<div class="comment">';
	    commentList.forEach(function (item, index) {       
	    	console.log(item.comment_id);
	        commentContent += '<div class="detail-href">';
	        commentContent += '<span class="username">' + item.comment_user_nickname + '</span> ';     
	        commentContent += '<span class="commentTxt">' + item.comment_text + '</span> ';
		
	        var commentUserNo = user_no;
			console.log('aaaaaaaaaa'+commentUserNo);
			console.log(item.user_no);
				if (item.user_no == commentUserNo) {
		            console.log('사용자가 이 댓글을 작성한 댓글이 있습니다.');
		            
		            commentContent += '<button class="btn btn-dark comment-edit-btn" data-comment-id="' + item.comment_id + '" data-feed-content="' + item.comment_text + '">수정</button>';
		            commentContent += '<button class="btn btn-dark comment-del-btn" data-comment-id="' + item.comment_id + '">삭제</button>';
		            $('.comment-edit-btn').addClass('custom-button');
		        	 $('.comment-del-btn').addClass('custom-button');
		        } else {
		            console.log('사용자가 이 댓글을 작성하지 않았습니다.');
		        }
			commentContent += '</div>';
	  
	    });
	    commentContent += '</div>';
	    // 댓글을 추가하려는 요소에 commentContent를 추가
	    
	    // 예를 들어, 아래처럼 HTML 요소에 추가할 수 있습니다.
	    $('#feedDetail .post-comments').html(commentContent);
	   
	}  
  $(document).on('click', '.comment-edit-btn', function () {
	  swal({
  	      title: "댓글을 수정하시겠습니까??",
  	      text: "",
  	      icon: "info",
  	      buttons: ["아니오", "네"]
  	  }).then((YES) => {
  	      if (YES) {
  	          flag = true;
  	        var commentTxt = $(this).parent().find('.commentTxt');
	        var originalComment = commentTxt.text();
	        var commentId = $(this).data('comment-id');
	        $('.comment-edit-btn').prop('disabled', true);
	        $('.comment-del-btn').prop('disabled', true);
	        // "commentTxt"를 input 태그로 대체
	        commentTxt.html('<input type="text" class="comment-input" value="' + originalComment + '">');
	        // 저장 버튼과 취소 버튼 추가
			commentTxt.append('<button class="btn btn-dark" id="comment-save-btn" data-comment-id="' + commentId + '">저장</button>');
			commentTxt.append('<button class="btn btn-dark" id="comment-cancle-btn">취소</button>');
			//문제없음
			
	        $('#comment-save-btn').on('click', function () {
	        	swal({
	        	      title: "댓글을 저장하시겠습니까???",
	        	      text: "",
	        	      icon: "info",
	        	      buttons: ["아니오", "네"]
	        	  }).then((YES) => {
	        	      if (YES) {
	        	          flag = true;
	        	          var commentId = $(this).data('comment-id');
	  	                var commentTxt = $(this).parent().find('input.comment-input').val();
	  	                var commentTxtElement = $(this).parent();
	  	                
	  	                if (commentTxt.trim() === "") {
	  	                	swal({
	  	              	    title: "댓글을 입력해주세요",
	  	              	    text: "",
	  	              	    icon: "warning"
	  	              	});
	  	                    return; // 빈 댓글일 경우 아래 로직을 실행하지 않고 함수 종료
	  	                }
	  	                $.ajax({
	  	                    url: 'feedEditComment/update',
	  	                    data: {
	  	                        'commentId': commentId,
	  	                        'commentTxt': commentTxt
	  	                    },
	  	                    success: function (data) {
	  	                        console.log(data);
	  	                      swal({
	  	  	              	    title: "댓글이 수정되었습니다",
	  	  	              	    text: "",
	  	  	              	    icon: "success"
	  	  	              	});
	  	                        commentTxtElement.html(commentTxt);
	  	                        $('.comment-edit-btn').prop('disabled', false);
	  	            	        $('.comment-del-btn').prop('disabled', false);
	  	                    },
	  	                    error: function (e) {
	  	                        console.log("댓글 수정에러발생 " + e);
	  	                    },
	  	                });
	        	      }else{
	        	          flag = false;
	        	      }
	        	      
	        	  });          
	            
	        });
  	      }else{
  	          flag = false;
  	      }
  	      
  	  });
	  
	  
	});

  $(document).on('click', '#comment-cancle-btn', function () {
	  swal({
  	      title: "댓글 수정을 취소하시겠습니까??",
  	      text: "",
  	      icon: "info",
  	      buttons: ["아니오", "네"]
  	  }).then((YES) => {
  	      if (YES) {
  	          flag = true;
  	        var commentTxt = $(this).parent();
	        var commentId = $(this).siblings('#comment-save-btn').data('comment-id'); // 취소 버튼의 형제로부터 commentId 가져옴
	        commentTxt.html(commentTxt.find('input.comment-input').val());
	        $('.comment-edit-btn').prop('disabled', false);
	        $('.comment-del-btn').prop('disabled', false);
  	      }else{
  	          flag = false;
  	      }
  	      
  	  });
	});

  
  $(document).on('click','.comment-del-btn',function(){
	  var commentElement = $(this).closest('.detail-href');
	  
	  swal({
  	      title: "댓글을 삭제하시겠습니까???",
  	      text: "",
  	      icon: "warning",
  	      buttons: ["아니오", "네"]
  	  }).then((YES) => {
  	      if (YES) {
  	          flag = false;
  	        var commentId =$(this).data('comment-id');
			$.ajax({
				url:'feedDelComment/delete',
				data:{'commentId':+commentId},
				success:function(data){
					console.log(data);
					swal({
	            	    title: "댓글이 삭제되었습니다.",
	            	    text: "",
	            	    icon: "success"
	            	});
					commentElement.remove();
				},
				error:function(e){
					console.log("댓글 삭제에러발생 "+e);
				},
			});
  	      }else{
  	          flag = true;
  	      }
  	      
  	  });
	  
		
		
		
  })
	var currentImageIndex = 0;
	var maxImageIndex = 0	
  	
  // 게시글 상세보기 리스트  
  function drawdetailList(detailList, findBoardUserno, user_no,is_admin) {
      console.log(detailList);
      console.log('is_admin ==============='+is_admin);
      var content = '';

      detailList.forEach(function (item) {
    	  var imageFiles = item.server_file_name.split(','); 
    	  maxImageIndex = imageFiles.length - 1;
          content += '<div class="post">';
          content += '<div class="post-header">';
          var defaultImagePath = '/invegan/resources/main/profile.jpg';
			var profileImagePath = item.profile_image ? '/photo/' + item.profile_image : defaultImagePath;
			content += '<div class="user-profile"><img src="' + profileImagePath + '"></div>';
          content += '<span class="username">' + item.nickname + '</span>';
          content += '</div>';
          
			if (loginInfo != null && (user_no == findBoardUserno || is_admin == 1)) {
        	  
        	  content += '<div class="post-btn-group">';
        	  content += '<button class="btn btn-dark" id="post-del-btn" data-post-id="' + item.post_id + '">삭제</button>';
        	  content += '<button class="btn btn-dark" id="post-edit-btn" data-post-id="' + item.post_id + '" data-feed-content="' + item.content + '">게시글 수정</button>';
        	  content += '</div>';
          }
          if (imageFiles.length > 1) {
              content += '<button class="btn btn-dark" id="past">이전</button>';
              content += '<button class="btn btn-dark" id="next">다음</button>';
          }
          for (var i = 0; i < imageFiles.length; i++) {
      	    var imageUrl = '/photo/' + imageFiles[i];
      	    content += '<div class="post-wrapper">';
      	    content += '<div class="post-img-slider"><img class="pstimg" src="' + imageUrl + '" style="width: 500px; height: 500px;"> </div>'; // 여기에서 너비와 높이를 조정하세요
      	    content += '</div>';
      	    
      	}
           
           content += '<div class="post-caption detailPostCaption">';
           content += '<div class="feed-content">' + item.content.replace(/\n/g, '<br>') + '</div>';
           content += '</div>';
           
          content += '<div class="post-comments">';
          content += '<div class="comment comments">';             
//           content += '<span class="username">' + item.comment_user_nickname + '</span> ';
          content += '<div class="detail-href">';
//           content += '<span class="comment">' + item.comment_text + '</span> '
            if (item.commentList) {
            drawcommentList(item.commentList);
        }
          
          
          content += '</div>';
          content += '</div>';
          content += '</div>';
          var date = new Date(item.date);
          var dateStr = date.toLocaleDateString("ko-KR");
          content += '<div class="tag-content" style="width:500px; color: #808080;">' + item.tag_content + '</div>';
          content += '<div class="post-time">' + dateStr + '</div>';
          content += '</div>';
          
       	  content += '<div class="comment-box">';
          content += '<input type="text" class="feedComment" name="feedComment" placeholder="댓글을 입력하세요...">';
          content += '<button class="btn btn-dark" id="comment-write-btn"data-post-id="' + item.post_id + '">작성</button>';
          content += '</div>';
          
          
          content += '<hr>';
      });

      $('#feedDetail').html(content);
      
      $('#next').on('click', function() {
    	    if (currentImageIndex < maxImageIndex) {
    	    	console.log('currentImageIndexNEXT:', currentImageIndex);
    	    	console.log('maxImageIndexNEXT:', maxImageIndex);
    	        currentImageIndex++;
    	        updateImageSlider();
    	        updateButtonStates();
    	    }
    	});

    	$('#past').on('click', function() {
    	    if (currentImageIndex > 0) {
    	    	console.log('currentImageIndexPAST:', currentImageIndex);
    	    	console.log('maxImageIndexPAST:', maxImageIndex);
    	        currentImageIndex--;
    	        updateImageSlider();
    	        updateButtonStates();
    	    }
    	});

    	function updateImageSlider() {
    	    var translateValue = -100 * currentImageIndex + 'vw';
    	    $('.post-wrapper').css('transform', 'translate(' + translateValue + ')');
    	}
    	function updateButtonStates() {
    		$('#next').prop('disabled', currentImageIndex === maxImageIndex);
    		$('#past').prop('disabled', currentImageIndex === 0);
    	}
    	
      // 비회원이 댓글작성했을떄 이벤트
      $('#feedDetail').on('click', '#comment-write-btn', function () {
		    if (loginInfo == null) {
		    	swal({
            	    title: "로그인이 필요합니다 !",
            	    text: "",
            	    icon: "error",
            	    allowOutsideClick: false //외부창 눌러서 끄기
            	}).then((result) =>{
            		if(result){
            			
            			location.href="/invegan/member/login.go";  
            		}
            	})
		    } else {
		        
		    }
		})
		
		
			
		
		
		
		
		
      // "수정" 버튼 클릭 이벤트 핸들러 등록
      $('#post-edit-btn').on('click', function () {
    	  swal({
      	      title: "게시글을 수정하시겠습니까???",
      	      text: "",
      	      icon: "info",
      	      buttons: ["아니오", "네"]
      	  }).then((YES) => {
      	      if (YES) {
      	          flag = false;
      	        var post_id = $(this).data('post-id');
                var feed_content = $(this).closest('.post').find('.feed-content');
                var postImgEditBtn = $(this).closest('.post').find('.post-btn-group');
                var postId = $(this).data('post-id');
                $(this).prop('disabled', true);
                console.log(feed_content.text());
                console.log(post_id);
                console.log('수정');
                
                
             	  // 현재 "feed-content"의 텍스트 내용 가져오기
                var originalContent = feed_content.text();
                postImgEditBtn.append('<button class="btn btn-dark" id="post-img-edit-btn">이미지수정</button>');
                // "feed-content"를 input 태그로 대체
                feed_content.html('<textarea name="content" class="feed-content-input" placeholder="내용을 입력하세요.." style="width: 600px; height: 200px;">' + originalContent + '</textarea>');
                // 저장 버튼과 취소 버튼 추가
                feed_content.append('<button class="btn btn-dark" id="save-button" data-post-id="' + post_id + '">저장</button>');
                feed_content.append('<button class="btn btn-dark" id="cancel-button">취소</button>');
                  
                
                var pstimgElements = $('.pstimg');
	            console.log(pstimgElements.length);
                
                // 수정 버튼 비활성화
				        $('#post-img-edit-btn').on('click', function () {
	                    	
						    swal({
						        title: "이미지를 수정하시겠습니까??",
						        text: "",
						        icon: "info",
						        buttons: ["아니오", "네"]
						    }).then((YES) => {
						        if (YES) {
						            flag = true;
						            $(this).prop('disabled', true);
						            
						            $('.pstimg').on('click', function () {
						                var currentImage = $(this);
						
						                swal({
						                    title: "이미지를 삭제하시겠습니까??",
						                    text: "선택하시면 해당이미지가 삭제됩니다.",
						                    icon: "warning",
						                    buttons: ["아니오", "네"]
						                }).then((YES) => {
						                    if (YES) {

						                        flag = true;

						
						                        if (pstimgElements.length === 1) {
						                            swal({
						                                title: "마지막 이미지를 삭제할 수 없습니다. 지우길 원하시면 게시글을 삭제해주세요",
						                                text: "",
						                                icon: "warning"
						                            });
						                            
						                        } else {
						                            var path = currentImage.attr('src');
						                            var fileName = path.substring(path.lastIndexOf('/') + 1);
						
						                            $.ajax({
						                                url: 'feedImgDel/delete',
						                                data: { fileName: fileName },
						                                success: function (data) {
						                                    currentImage.hide();
						                                    currentImage.remove();
						                                    console.log("사진 삭제 성공");
						                                    console.log(data);
						                                    maxImageIndex--;
						
						                                    // 이미지 삭제 후에 업데이트된 이미지 요소들 다시 선택
						                                    pstimgElements = $('.pstimg');
						                                    pstimgElements.length--;
						                                    
						                                    console.log(pstimgElements.length);
						                                },
						                                error: function (e) {
						                                    console.log("사진 삭제 에러" + e);
						                                },
						                            });
						                        }
						                    } else {
						                        flag = false;
						                    }
						                });
						            });
						        } else {
						            flag = false;
						        }
						    });
						});
                
            	
                
                
                
                
                $('#save-button').on('click', function () {
              	  swal({
                	      title: "게시글을 저장하시겠습니까??",
                	      text: "",
                	      icon: "warning",
                	      buttons: ["아니오", "네"]
                	  }).then((YES) => {
                	      if (YES) {
                	          flag = true;
                	        $('.pstimg').off('click');
                		  	$('#post-img-edit-btn').remove();
                		  	console.log('click');
                		  	$('#post-edit-btn').prop('disabled', false);
                          console.log(this);
                          var post_id = $(this).data('post-id');
                          var feed_content = $(this).parent().find('.feed-content-input'); // 수정된 내용을 가져옵니다.
                          console.log(post_id);
                          console.log(feed_content.val()); // 수정된 내용을 가져옵니다.
                          var formData = new FormData();
                          formData.append("feed_content", feed_content.val());
                          formData.append("post_id", post_id);
                          // 여기에서 수정된 내용을 서버로 전송하거나 다른 작업을 수행할 수 있습니다.
                          $.ajax({
                        	  type:'POST',
                        	  url:'feedUpdatePost/update',
                        	  data: formData,
                        	  processData: false,
                              contentType: false,
                        	  success:function(data){
                        		  console.log(data);
                        		  var editContent = feed_content.val();
                        		  var feedContent = '<div class="feed-content">' + editContent.replace(/\n/g, '<br>') + '</div>';
                        		  console.log(this);            		  
                        		  $('#feedDetail .post-caption').html(feedContent);
                        		  
                        	  },
                        	  error:function(e){
                        		  console.log('저장실패');
                        	  },
                          });
                	       	
                	      }else{
                	          flag = false;
                	      }
                	  });
                      
              	  
              	  
                    
                });
                
                $('#cancel-button').on('click', function () {
              	  
              	  swal({
                	      title: "게시글 수정을 취소하시겠습니까??",
                	      text: "",
                	      icon: "info",
                	      buttons: ["아니오", "네"]
                	  }).then((YES) => {
                	      if (YES) {
                	          flag = true;
                	        var feedContent = '<span class="feed-content">' + originalContent + '</span>'; // 원본 내용으로 복원
                          $('#feedDetail .post-caption').html(feedContent);
                          $('#post-img-edit-btn').remove();
                          $('#post-edit-btn').prop('disabled', false);
                	      }else{
                	          flag = false;
                	      }
                	  });
                });
      	      }else{
      	          flag = true;
      	      }
      	      
      	  });
    	  
    	  

       });
      
     

      // "삭제" 버튼 클릭 이벤트 핸들러 등록
      $('#post-del-btn').on('click', function () {
          var post_id = $(this).data('post-id'); 
 
          swal({
      	      title: "게시글을 삭제하시겠습니까??",
      	      text: "네 를 선택하시면 게시글이 삭제됩니다.",
      	      icon: "warning",
      	      buttons: ["아니오", "네"]
      	  }).then((YES) => {
      	      if (YES) {
      	          flag = true;
      	          deletePost(post_id);
      	      }else{
      	          flag = false;
      	      }
      	  });
          
      });
      function deletePost(post_id) {
    	  
    	  
    	    $.ajax({
    	        type: 'POST',
    	        url: 'feedDelPost/delete',
    	        data: { post_id: post_id },
    	        success: function (data) {
    	            console.log('게시글 삭제 성공!');
    	            swal({
                	    title: "게시글이 성공적으로 삭제되었습니다",
                	    text: "",
                	    icon: "success"
                	}).then((result) =>{
                		if(result){
                			location.href="list.go";  
                		}
                	})
    	                      
    	        },
    	        error: function (error) {
    	            console.log('게시글 삭제에 실패했습니다: ' + error);
    	        }
    	    });
    	}
      

    }

 	 
		  //댓글 작성
		  $(document).on('click', '#comment-write-btn', function() {
		    var comment_text = $(this).closest('.comment-box').find('.feedComment').val();
		    var post_id = $(this).data('post-id');
		    console.log(post_id);
		    console.log(comment_text);
		    console.log('click');
		     
		    if(comment_text.trim()== ""){
		    	swal({
            	    title: "댓글을 입력해주세요",
            	    text: "",
            	    icon: "warning"
            	});
		       return;
		    }
		    
		    
		    $.ajax({
		       type:'get',
		       url:'feedWriteComment',
		       data : {comment_text : comment_text,
		      		 post_id:post_id },
		         success: function (data) {
		           console.log(data);
		           console.log(data.user_no);
		           console.log(data.comment_text);
		           console.log(data.post_id);
		           console.log(data.comment_user_nickname);
		   
		            var newComment = '<div class="detail-href">'; // 수정
			        newComment += '<span class="username">' + data.comment_user_nickname + '</span> ';
			        newComment += '<span class="comment">' + data.comment_text + '</span> ';
			        newComment += '</div>';
		           // 댓글을 추가하려는 요소에 newComment를 추가
		           $('#feedDetail .post-comments').append(newComment);
		
		           // 입력 필드 비우기
		           $('.feedComment').val('');
		           drawcommentList(data.commentList, data.user_no);
		         },
		         error: function (e) {
		           console.log(e);
		           console.log("댓글 입력 에러 ");
		         }
		       
		    });
		    
		});
		  			 

  </script>

</html>