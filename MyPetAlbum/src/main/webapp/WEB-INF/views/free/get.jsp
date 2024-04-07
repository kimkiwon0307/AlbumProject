<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../common/header.jsp"%>
<link href="/resources/free/css/get.css" rel="stylesheet" />

<body>
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">조 회</h1>
				<p class="lead fw-normal text-white-50 mb-0">Read</p>
			</div>
		</div>
	</header>

	<section>
		<div class="container h-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-9">
					<h1 class="text-white mb-4"></h1>

					<div class="card" style="border-radius: 20px;">
							<div class="card-body">
								<div class="row align-items-center pt-4 pb-3">
										
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">제목(Title)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="f_title" value='<c:out value="${free.f_title}"/>' readonly="readonly"> 
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">작성자(Writer)</h6>
									</div>
									<div class="col-md-9 pe-5">

										<input type="text" class="form-control form-control-lg" name="f_writer" value='<c:out value="${free.f_writer}"/>' readonly="readonly"/>
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">

										<h6 class="mb-0">내용(Contents)</h6>

									</div>
									<div class="col-md-9 pe-5">
										<textarea class="form-control" rows="5" placeholder="300자 제한" name="f_content" readonly="readonly"><c:out value="${free.f_content}"/></textarea>
									</div>
								</div>
								
								<hr class="mx-n3">
								
								
								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">좋아요(Like)</h6>
									</div>
									<div class="col-md-9 pe-5">
										   <button type="button" id="likeBtn" class="btn btn-danger btn-circle btn-xl"><i class="bi bi-hand-thumbs-up"></i></button>
									</div>
								</div>
								
								<hr class="mx-n3">
								
								<input type="hidden" value="${free.f_no}" id="fNo">
								<div class="px-5 py-4" id="button-container">
								  <c:if test="${member !=null && member.m_id == free.f_writer}">
									<button type="button" id="uBtn" class="btn btn-primary btn-lg">수정</button>
								  </c:if>
									<button type="button" id="lBtn" class="btn btn-danger btn-lg">목록</button>
								</div>

							<form id='operForm' action="/free/modify" method="get">
								<input type='hidden' id='f_no' name='f_no' value='<c:out value="${free.f_no}"/>'>
							    <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
							    <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
							</form>
						</div>

						<!-- 댓글 -->
						<div class="bg-light py-5 h-100">
							<div class="container comment" style="">
								<!-- Section title -->
								<h3 class="mb-3">Comments</h3>
								
								<!--댓글 남기기 -->
								<div class="card shadow-sm mb-3">
									<div class="card-body">
									  <c:choose> 
									  	<c:when test="${member !=null}">
										<h5 class="card-title">댓글 남기기</h5>
										<form>
											<div class="form-group">
												<textarea id="message" rows="3" class="form-control" ></textarea>
											</div>
											<button type="submit" class="btn btn-primary btn-block" id="ReplyBtn">Comment</button>
										</form>
										</c:when>
										<c:when test="${member == null}">
											<h5 class="card-title">댓글 남기기</h5>
											
											<div class="form-group">
												<textarea id="message" rows="3" class="form-control" placeholder="로그인후 이용가능합니다." readonly="readonly"></textarea>
											</div>
											
										</c:when>
									  </c:choose>
									</div>
								</div>
							  
							  	
							
								<!-- 댓글 목록 -->
								<div class="card shadow-sm">
									<ul class="list-group list-group-flush" id="chat">
									</ul>
								</div>
							</div>
						</div>
						<!-- 댓글 -->
						
						
						
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
		
	 $(document).ready(function(){
			
		 var replyer = '<c:out value="${member.m_id}"/>';
		 
		 var f_no = '<c:out value="${free.f_no}"/>';
		 	
			$("#uBtn").on("click",function(e){
				e.preventDefault();
				
				operForm.submit();
			})
			
			
			var operForm = $("#operForm");
			
			
			$("#lBtn").on("click",function(e){
				e.preventDefault();
				
				operForm.attr("action","/free/list");
				operForm.submit();
				
			});//lbtn
			

			 replyService.get(3, function(data){
				console.log(data); 
			 });
			 
	 
	 var replyUL = $("#chat");
	 
	 showList(1);
	 
	 function showList(page){
		 
		 replyService.getList({f_no:f_no, page: page || 1}, function(list){
			
			 var str="";
			 if(list == null || list.length ==0){
				 replyUL.html("");
				 
				 return;
			 }
			 
			 for(var i=0, len = list.length || 0; i < len; i++){
				 str += " <li class='list-group-item' data-rno='"+list[i].rno+"'>";
				 str += " <h6 class='text-muted mb-1'><small>'"+list[i].replyer+"'</small></h6>";
				 str += "<p class='mb-0'>'"+list[i].reply+"'</p>";
				 str += "<div class='d-grid gap-2 d-md-flex justify-content-md-end'>";
				 str += "<button class='btn btn-primary me-md-2 uRplyBtn' type='button' data-rno='"+list[i].rno+"'>수정</button>";
				 str += "<button class='btn btn-primary dRplyBtn' type='button' data-rno='"+list[i].rno+"'>삭제</button></div>";
				 str += "</li>";
			 }
			 
				 replyUL.html(str);
			 
		 });
		 
	 }// showList(page)
	 
	// 댓글 등록 
	 $('#ReplyBtn').on("click",function(e){
		
		 e.preventDefault();
		 
		 var message = $("#message").val();
		 
		 if(message.trim() === '' ){
			 alert("댓글을 입력해주세요.");
		 }else{
			 replyService.add(
					{reply:message, replyer:replyer, f_no:f_no},
					function(result){
						alert("댓글이 등록되었습니다.")
						 $("#message").val('');
						showList(1);
					}
				);
		 }
		 
	 })	// 댓글 등록 
	 
	 
	 $('#likeBtn').on("click",function(e){
		 alert("좋아요");
		 
			
			$.ajax({
				url: '/free/like',
				data:{f_no:f_no},
				type:'POST',
				dataType:'json',
				success: function(result){
					console.log("좋아요+1");
				}
			}); //ajax
		 
	 })
	 
	 
	 
	// 삭제 버튼에 대한 이벤트 핸들러를 등록
	 $(document).on("click", ".dRplyBtn", function() {
	    
		var rno = $(this).data('rno');
		 
		  replyService.remove(rno, function(count){
			 
			 console.log(count);
			 
			 if (count === "success"){
				 alert("REMOVED");
				 showList(1);
			 }
		 }, function(err) {
			 alert("ERROR");
			 showList(1);
		 }); 
		 
	 }); // $(document).on("click", ".dRplyBtn", function()

      // 수정 버튼에 대한 이벤트 핸들러를 등록
	 $(document).on("click", ".uRplyBtn", function() {
	    
		var rno = $(this).data('rno');
		var newReply = prompt("수정할 내용을 입력하세요:"); // 사용자로부터 새로운 내용 입력 받기

		 
		replyService.update({
			 rno : rno,
			 f_no : f_no,
			 reply : newReply
		 }, function(result){
			 alert("수정완료");
			 showList(1);
		 }); 
		
		
	 });  // 수정 버튼에 대한 이벤트 핸들러를 등록
			 
	
	 
			 
	 
});
		
</script>
	<%@include file="../common/footer.jsp"%>
</body>
</html>