<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@include file="../common/header.jsp"%>
<link href="/resources/free/css/register.css" rel="stylesheet" />


	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">등 록</h1>
				<p class="lead fw-normal text-white-50 mb-0">Register</p>
			</div>
		</div>
	</header>

	<section>
		<div class="container h-100">
			<div class="row d-flex justify-content-center align-items-center">
				<div class="col-xl-9">
					<h1 class="text-white mb-4"></h1>
					<div class="card">
						
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
						
						<form action="/free/register" method="post">
							<div class="card-body">
								<div class="row align-items-center pt-4 pb-3">

									<div class="col-md-3 ps-5">
										<h6 class="mb-0">제목(Title)</h6>
									</div>
									<div class="col-md-9 pe-5">
										<input type="text" class="form-control form-control-lg" name="f_title" />
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">
										<h6 class="mb-0">작성자(Writer)</h6>
									</div>
									<div class="col-md-9 pe-5">

										<input type="text" class="form-control form-control-lg" name="f_writer"  value="${member.m_id}"  readonly />
									</div>
								</div>

								<hr class="mx-n3">

								<div class="row align-items-center py-3">
									<div class="col-md-3 ps-5">

										<h6 class="mb-0">내용(Contents)</h6>

									</div>
									<div class="col-md-9 pe-5">
										<textarea class="form-control" rows="5" placeholder="300자 제한" name="f_content"></textarea>
									</div>
								</div>
							
								<hr class="mx-n3">

								<div class="px-5 py-4">
									<button type="submit" class="btn btn-primary btn-lg">작성</button>
									<button type="button" id="cBtn" class="btn btn-danger btn-lg">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</section>

	<script type="text/javascript">
		$(document).ready(function(e){
				
			$("#cBtn").on("click",function(e){
				e.preventDefault();
				self.location="/free/list";
			});
		});
		
	</script>
	
	<%@include file="../common/footer.jsp"%>
</body>
</html>