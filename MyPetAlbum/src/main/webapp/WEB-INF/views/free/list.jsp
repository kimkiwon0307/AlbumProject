<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../common/header.jsp"%>
<link href="/resources/free/css/list.css" rel="stylesheet" />




 <section class="py-5">
	<div id="container">
		<c:if test="${member !=null }">
			<button type="button" class="btn btn-success btn-lg" id="rBtn">등록하기</button>
		</c:if>

		<table class="table table-hover table-bordered">
			<thead>
				<tr class="table-primary">
					<th scope="col" class="number-header">번호</th>
					<th scope="col" class="title-header">제목</th>
					<th scope="col" class="name-header">이름</th>
					<th scope="col" class="date-header">등록일</th>
					<th scope="col" class="views-header">조회</th>
					<th scope="col" class="likes-header">좋아요</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${list}" var="free">
					<tr>
						<th scope="row"><c:out value="${free.f_no}" /></th>
						<td>
							<a class='move' href='<c:out value="${free.f_no}"/>'>
								<c:out value="${free.f_title}" />
							</a>
						</td>
						<td><c:out value="${free.f_writer}" /></td>
						<td><c:out value="${free.f_date}" /></td>
						<td><c:out value="${free.f_count}" /></td>
						<td><c:out value="${free.f_like}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	<!--  Pagination -->
	<nav aria-label="..."  class="custom-nav">
		<ul class="pagination pagination-sm">
				<c:if test="${pageMaker.prev}">
						<%-- <li class="page-item disabled">  
							<a class="page-link" href="${pageMaker.startPage -1}" tabindex="-1" aria-disabled="true">Previous</a>
						</li> --%>
					<li class="page-item"> 
						<a class="page-link" href="${pageMaker.startPage -1}">Previous</a>
					</li>
						
				</c:if>
							
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }">
				  <li class="page-item">
				  	<a class="page-link" href="${num}">${num}</a>
				  </li>
				</c:forEach>
							
				<c:if test="${pageMaker.next}">
					<li class="page-item"> 
						<a class="page-link" href="${pageMaker.endPage + 1}">Next</a>
					</li>
				</c:if>
			</ul>	
      </nav>
      
      <form id ='actionForm' action="/free/list" method="get">
      	<input type="hidden" name="pageNum" value = '${pageMaker.cri.pageNum}'>
      	<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
      </form>
	<!--  end Pagination -->
</div>
</section>

	<script type="text/javascript">
	
		$(document).ready(function(){

			var actionForm = $("#actionForm");
			

			// 작성하기버튼
			$("#rBtn").on("click",function(e){
				
				e.preventDefault();
				
				self.location="/free/register";
				
			}); // 작성하기버튼 END
			
			
			// 페이지네이션 a태그 클릭시
			$(".page-item a").on("click", function(e){
				e.preventDefault(); 
				actionForm.find("input[name='pageNum']").val($(this).attr("href")); 
				actionForm.submit();
			})
			
			// 조회 페이지로 이동
			$(".move").on("click",function(e){
				e.preventDefault();
				
				alert("hi");
				
				var f_no = $(this).attr("href");
				
				$.ajax({
					url: '/free/count',
					data:{f_no:f_no},
					type:'POST',
					dataType:'json',
					success: function(result){
						alert("조회+1");
					}
				}); //ajax
				
				
				actionForm.append("<input type='hidden' name='f_no' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/free/get");
				actionForm.submit();
			})
		})
	</script>
	
	<%@include file="../common/footer.jsp"%>
	
</body>
</html>