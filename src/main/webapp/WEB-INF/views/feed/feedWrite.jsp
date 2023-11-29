<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<style>
.previews {
	width: 500vw;
	transition: transform 0.1s;
}

.img-slider {
	width: 100vw;
	float: left;
}

.previews img {
	width: 400px;
	height: 300px;
}

#writeModal .modal-content {
	width: 700px;
}

#writeModal {
	padding-right: 500px !important;
}

.modal-backdrop.show {
	opacity: .2 !important;
}

#content {
	height: 200px;
}

#feedWriteCancle, #feedSave {
	float: right;
}

.previews-delbtn {
	width: 150px;
}

.past, .next {
	width: 60px;
}

.form-group {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.form-group label {
	/* align-self: flex-start; */
	margin-bottom: 10px;
	font-size: 18px;
	font-weight: bold;
}

.img-containerbox, .modal-title {
	font-size: 18px; /* 글자 크기 조절 */
	font-weight: bold;
}
</style>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- alert ,cofirm 창 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<title>Feed Write</title>
</head>

<body>


	<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" data-backdrop="static" id="writeModal">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myExtraLargeModalLabel">피드 게시글 작성</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>



				<div class="previews">
					<div class="img-containerbox">사진을 추가해주세요</div>
				</div>
				<div>
					<button class="past btn btn-secondary">이전</button>
					<button class="next btn btn-secondary">다음</button>
					<button class="previews-delbtn btn btn-secondary">이미지전체삭제</button>
				</div>

				<div>
					<div>
						<button type="button" class="btn btn-outline-dark" name="food">#식품</button>
						<button type="button" class="btn btn-outline-dark" name="beauty">#뷰티</button>
						<button type="button" class="btn btn-outline-dark" name="fashion">#패션</button>
						<button type="button" class="btn btn-outline-dark" name="daily">#일상</button>
						<button type="button" class="btn btn-outline-dark" name="restaurant">#식당</button>
						<button type="button" class="btn btn-outline-dark" name="recipe">#레시피</button>
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea name="content" placeholder="내용을 입력하세요.." style="width: 600px; height: 200px;"></textarea>
					</div>
					<div class="form-group">
						<label>태그</label>
						<textarea name="feedTag" placeholder="태그를 입력해주세요" style="width: 600px"></textarea>
					</div>
					<div class="form-group">
						<label>사진</label> <input type="file" id="photos" name="photos" multiple>
					</div>
					<div>
						<button id="feedWriteCancle" class="btn btn-secondary">취소</button>
						<button id="feedSave" class="btn btn-secondary">작성</button>
					</div>
				</div>


			</div>
		</div>
	</div>


</body>
<script>
  

    $(document).ready(function () {
    	
    	var previews = $('.previews');
        

        // 파일을 선택하기 전에 메시지를 표시
        

        $("#photos").on('change', function (e) {
        	var currentImageIndex = 0;
            var maxImageIndex = 0;
            var files = e.target.files;
            var previews = $('.previews'); // .previews 엘리먼트 선택
            $('.img-slider').empty(); // 기존 내용 비우기
            maxImageIndex = 0;
            maxImageIndex = files.length -1;
        	console.log(maxImageIndex);
            console.log(files);
            maxImageCount = 5; // 최대 5개 이미지
			
            if (files.length == 0) {
            	previews.append(message);
                $(".past, .next").prop("disabled", true);
            } else if (files.length > maxImageCount) {
                
            	swal({
            	    title: "이미지 최대개수 초과",
            	    text: "최대 이미지 5개까지 선택 할 수 있습니다.",
            	    icon: "warning" //"info,success,warning,error" 중 택1
            	});
                // 파일 입력을 비우고 이미지 업로드를 막음
                $('#photos').val('');
            } else {
                $('.img-containerbox').hide();
                $(".past, .next").prop("disabled", false);
                for (var i = 0; i < files.length; i++) {
                	
                    var file = files[i];
                    if (file) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var img = document.createElement("img");
                            img.setAttribute("src", e.target.result);

                            var slider = document.createElement("div");
                            slider.classList.add("img-slider");
                            slider.appendChild(img);

                            previews.append(slider);
                        };
                        reader.readAsDataURL(file);
                    }
                }
                
             // 이전 버튼 클릭 이벤트 핸들러
                $(".past").on('click', function () {
                    if (currentImageIndex > 0) {
                    	console.log('aa'+currentImageIndex);
            	    	console.log('bb'+maxImageIndex);
                        currentImageIndex--;
                        showCurrentImage();
                    }
                    
                });

                // 다음 버튼 클릭 이벤트 핸들러
                $(".next").on('click', function () {
                	console.log('aa'+currentImageIndex);
        	    	console.log('bb'+maxImageIndex);
                    if (currentImageIndex < maxImageIndex) {
                        currentImageIndex++;
                        showCurrentImage();
                    }
                    
                });
                
                // 현재 이미지를 표시하는 함수
                function showCurrentImage() {
                    // 현재 이미지 엘리먼트를 선택합니다.
                	var translateValue = -100 * currentImageIndex + 'vw';
            	    $('.previews').css('transform', 'translate(' + translateValue + ')');
                }
                
               
            }
        });
        
        $('.previews-delbtn').on('click', function () {

            swal({
      	      title: "이미지를 삭제하시겠습니까??",
      	      text: "이미지는 전체삭제 됩니다.",
      	      icon: "warning",
      	      buttons: ["아니오", "네"]
      	  }).then((YES) => {
      	      if (YES) {
      	          flag = false;
      	        $('.img-containerbox').show();
                $('.img-slider').empty();
                $('#photos').val('');
                message.textContent = "사진을 추가해주세요";
                previews.append(message);
      	      }else{
      	          flag = true;
      	      }
      	      
      	  });
            
            
        });
        

     
	
      
     


      // 버튼클릭 이벤트
     $('.btn-outline-dark').click(function () {
    	 var text = $(this).text();
    	    if (text !== "피드게시글 작성") {
    	        addToTextArea(text);
    	    }
	});

      function addToTextArea(textToAdd) {

        var currentValue = $('textarea[name="feedTag"]').val();

        if (currentValue.indexOf(textToAdd) == -1) {
          if (currentValue) {
            $('textarea[name="feedTag"]').val(currentValue + textToAdd);
          } else {
            $('textarea[name="feedTag"]').val(textToAdd);
          }
          console.log(textToAdd);
        }
      }


      // 작성 버튼 클릭 시 이벤트 처리
      $('#feedSave').click(function () {
    		
    	  swal({
    	      title: "게시글을 작성하시겠습니까??",
    	      text: "",
    	      icon: "info",
    	      buttons: ["아니오", "네"]
    	  }).then((YES) => {
    	      if (YES) {
    	          flag = true;
    	          var content = $('textarea[name="content"]').val();
      	        var feedTag = $('textarea[name="feedTag"]').val();
      	        var photos = $('#photos')[0].files;
  				
      	        if (content.trim() === "") {
      	        	swal({
                  	    title: "내용을 입력해 주세요 !",
                  	    text: "",
                  	    icon: "error" //"info,success,warning,error" 중 택1
                  	});
      	        } else if (feedTag.trim() === "") {
      	        	swal({
                  	    title: "태그를 입력해주세요 !",
                  	    text: "필수태그 =#식품,#뷰티,#패션,#일상,#식당,#레시피",
                  	    icon: "error" //"info,success,warning,error" 중 택1
                  	});
      	        } else if (photos.length === 0) {
      	        	swal({
                  	    title: "사진을 1개이상 선택해주세요 !",
                  	    text: "사진 최대갯수 5개",
                  	    icon: "error" //"info,success,warning,error" 중 택1
                  	});
      	        } else if (
      	          !feedTag.includes("#식품") &&
      	          !feedTag.includes("#패션") &&
      	          !feedTag.includes("#일상") &&
      	          !feedTag.includes("#레시피") &&
      	          !feedTag.includes("#뷰티") &&
      	          !feedTag.includes("#식당")
      	        ) {
      	        	swal({
                  	    title: "필수태그를 선택해주세요!",
                  	    text: "필수태그 =#식품,#뷰티,#패션,#일상,#식당,#레시피",
                  	    icon: "error" //"info,success,warning,error" 중 택1
                  	});
      	          return;
      	        } else {
      	          var formData = new FormData();
      	          formData.append("content", content);
      	          formData.append("feedTag", feedTag);

      	          for (var i = 0; i < photos.length; i++) {
      	            formData.append("photos", photos[i]);
      	          }

      	          // 이제 formData에 데이터가 정상적으로 추가되었으므로 서버로 요청을 보냅니다.
      	          $.ajax({
      	            type: 'post',
      	            url: 'write',
      	            data: formData,
      	            processData: false,
      	            contentType: false,
      	            success: function (e) {
      	              console.log(e);
      	            },
      	            error: function (e) {
      	              console.log(e);
      	            }
      	          });
      	          location.href = "list.go";
      	        }
    	      }else{
    	          flag = false;
    	      }
    	  });
    	  
    		 
    	  
    	 
              
      });






      $('#feedWriteCancle').on('click', function () {
    	  
    	  swal({
    	      title: "작성을 취소하시겠습니까?",
    	      text: "",
    	      icon: "info",
    	      buttons: ["아니오", "네"]
    	  }).then((YES) => {
    	      if (YES) {
    	          flag = true;
    	          location.href="list.go";
    	      }else{
    	          flag = false;
    	      }
    	  });
       


      });
    });



    


  </script>

</html>