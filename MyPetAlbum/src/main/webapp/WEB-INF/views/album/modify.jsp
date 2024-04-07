<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../common/header.jsp"%>
<link href="/resources/album/css/register.css" rel="stylesheet" >  
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">수 정</h1>
				<p class="lead fw-normal text-white-50 mb-0">Modify</p>
			</div>
		</div>
	</header>

	<section>
		<div class="container h-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-9">
					<h1 class="text-white mb-4"></h1>

					<div class="card">
						<form role="form" action="/album/register" method="post" id="Rform" >
							<div class="card-body">
							    <c:if test="${not empty errors}">
                                <div class="alert alert-danger" role="alert">
                                    <strong>유효성 검사 에러:</strong>
                                    <ul>
                                        <c:forEach items="${errors}" var="error">
                                            <li>${error.defaultMessage}<br></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>
								<div class="row align-items-center pt-4 pb-3">

									<div class="col-md-3 ps-5">
										<h6 class="mb-0">제목(Title)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="a_title" />
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">작성자(Writer)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="a_writer" value="${member.m_id}"  readonly/>
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">

										<h6 class="mb-0">내용(Contents)</h6>

									</div>
									<div class="col-md-9 pe-5">
										<textarea class="form-control" rows="5" placeholder="간단한 앨범 설명" name="a_content"></textarea>
									</div>
								</div>
								
								
							
								<hr class="mx-n3">

								<div class="px-5 py-4" style="float: right;">
									<button type="submit" class="btn btn-primary btn-lg" id='uploadBtn'>수정</button>
									<button type="button" class="btn btn-danger btn-lg" id="cBtn">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section>
		<div class="container h-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-9">
					<h1 class="text-white mb-4"></h1>
					<div class="card" style="border-radius: 20px;">
							<div class="row align-items-center py-3">
								<div class="col-md-3 ps-5">
									<h6 class="mb-0">사진파일(Image)</h6>
								</div>
								<div class="col-md-9 pe-5">
									<input class="form-control form-control-lg" name="uploadFile" type="file" multiple accept="image/gif, image/jpeg, image/png">
									<div class="small text-muted mt-2">이미지 최대 5MB 제한</div>
								</div>
								
								<div id='uploadResult'>
									<ul id="uUl">
									
									</ul>
								</div>
							</div> 
					</div>
				</div>
			</div>
		</div>
	</section>
	


	<script type="text/javascript">
		$(document).ready(function(e){
			
			var maxSize = 5242880; //5mb 제한
			var formObj = $("form[role='form']");
			
		 	$('#uploadBtn').on("click",function(e){
				e.preventDefault();
			
				var str = "";
				
				$("#uploadResult ul li").each(function(i, obj){
					
					var jobj = $(obj);
					
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"; 
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>"; 
					
				});		
					formObj.append(str).submit();
			})
			
			// 취소버튼
			$("#cBtn").on("click",function(){
				self.location = "/album/list";
			})
			
			
			function checkImage(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 최대 5MB");
					return false;
				}
				
				return true;
			}//checkImage
			
	
			$("input[type='file']").change(function(e){
				
				e.preventDefault();
				
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files = inputFile[0].files;
				
				console.log(files);
				
				for(var i=0; i < files.length; i++){
					
					if(!checkImage(files[i].name, files[i].size)){
						return false;
					}
					
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/album/uploadAjaxAlbum',
					processData:false,
					contentType:false,
					data:formData,
					type:'POST',
					dataType:'json',
					success: function(result){
						showUploadResult(result);
					}
				}); //ajax
		
			}) //uploadBtn
		
			
		})//$(document).ready(function(e)
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0) {return ;}
			
			var uploadUL = $("#uploadResult ul");
			var str ="";
			
			$(uploadResultArr).each(function(i, obj){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					console.log(fileCallPath);
					console.log(decodeURIComponent(fileCallPath));
					
					str += "<li style='float:left; list-style-type:none; margin-left:10px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='true'><div>";
					str += "<span> " + obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' class='btn btn-default btn-circle btn-xl'><i class='bi bi-trash'></i></button></br>";
					str += "<img src='/album/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
			});
			
			uploadUL.append(str);
		}//showUploadResult
			
		
		$("#uploadResult").on("click","button", function(e){
			
			var targetLi = $(this).closest("li");
			var targetFile = $(this).data("file");
			
			
			$.ajax({
				url: '/album/deleteFile',
				data: {fileName: targetFile},
				dataType: 'text',
				type: 'POST',
				success: function(result){
					alert(result);
					targetLi.remove();
				}
			})
			
			
			
		})
				
	</script>

</body>
<%@include file="../common/footer.jsp"%>
</html>