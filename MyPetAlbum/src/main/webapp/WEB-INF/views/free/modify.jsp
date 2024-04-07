<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../common/header.jsp"%>
<link href="/resources/free/css/modify.css" rel="stylesheet" />

	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">수정 / 삭제</h1>
				<p class="lead fw-normal text-white-50 mb-0">Update&Delete</p>
			</div>
		</div>
	</header>

	<section>
		<div class="container h-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-9">
					<h1 class="text-white mb-4"></h1>

					<div class="card" >
						<form id="formObj" action="/free/modify" method="post">
							<div class="card-body">
								
								<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
							    <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
								
								<div class="row align-items-center pt-4 pb-3">

									<div class="col-md-3 ps-5">
										<h6 class="mb-0">번호(No)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="f_no" value='<c:out value="${free.f_no}"/>'  readonly="readonly"/>
									</div>
								</div>
								<hr class="mx-n3">
							
								<div class="row align-items-center pt-4 pb-3">

									<div class="col-md-3 ps-5">
										<h6 class="mb-0">제목(Title)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="f_title"  value='<c:out value="${free.f_title}"/>' />
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">작성자(Writer)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="f_writer" value='<c:out value="${free.f_writer}"/>'  readonly="readonly"/>
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">내용(Contents)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<textarea class="form-control" rows="5"  name="f_content"><c:out value="${free.f_content}"/></textarea>
									</div>
								</div>
								
								<hr class="mx-n3">
								
							<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">수정 날짜(Date)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input value='<fmt:formatDate pattern="yyyy-MM-dd" value="${free.f_udate}"/>'
											class="form-control form-control-lg" readonly="readonly"/>
									</div>
							</div>

								<hr class="mx-n3">

								<div class="px-5 py-4">
									<button type="button" id="uBtn" class="btn btn-primary btn-lg">수정</button>
									<button type="button" id="dBtn" class="btn btn-danger btn-lg">삭제</button>
									<button type="button" id="lBtn" class="btn btn-info btn-lg">목록</button>
								</div>
							
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</section>

	<script type="text/javascript">
		$(document).ready(function(){
			
			var formObj = $("#formObj");
			
			// 목록가기
			$("#lBtn").on("click",function(e){
					self.location="/free/list";
			})
			
			// 삭제버튼
			$("#dBtn").on("click",function(e){
					e.preventDefault();
					
					if(confirm("삭제 하시겠습니까?")){
						formObj.attr("action","/free/remove").submit();
					}else{
						return false;
					}
			})
			
			// 수정버튼
			$("#uBtn").on("click", function(e){
				e.preventDefault();
				
				if(confirm("수정 하시겠습니까?")){
					formObj.attr("action","/free/modify").submit();
				}else{
					return false;
				}
				
				
			})
			
		})
		
	</script>

	<%@include file="../common/footer.jsp"%>

</body>
</html>