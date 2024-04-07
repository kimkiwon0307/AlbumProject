<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../common/header.jsp"%>
<link href="/resources/album/css/list.css" rel="stylesheet" >     
<link href="/resources/album/css/styles.css" rel="stylesheet" >  

       
        <!-- Section-->
        <section class="py-5">
        	<div class="container px-4 px-lg-5 mt-5">
        	  <c:if test="${member !=null }">
        		<form action="/album/register" method="get">
        			<button type="submit" class="btn btn-success btn-lg" id="Rbtn">앨범등록</button>
        		</form>
        	 </c:if>
        	</div>
        	
	<div class="container p-5">
        <div class="row row-cols-1 row-cols-xs-2 row-cols-sm-2 row-cols-lg-4 g-3">
          
           <c:forEach items="${list}" var="album">	
            <div class="col">
                <div class="card h-100 shadow-sm">
                    <div class="text-center">
                        <div class="img-hover-zoom img-hover-zoom--colorize">
                            <img class="shadow" src="https://cdn.pixabay.com/photo/2022/12/19/17/18/photos-7666143_640.jpg" alt="Another Image zoom-on-hover effect">
                        </div>
                    </div>
           
                    <div class="card-body">
                        <div class="clearfix mb-3">
                        </div>


                        <div class="my-2 text-center">

                            <h1><c:out value="${album.a_title}"/></h1>

                        </div>
                        <div class="mb-3">

                            <h2 class="text-uppercase text-center role"><c:out value="${album.a_content}"/></h2>

                        </div>
                        <div class="box">
                            <div>
                                <ul class="list-inline">
                                    <li class="list-inline-item">
                                    	<i class="fas fa-book-reader"></i> 
                                    	<a href='/album/get?a_no=<c:out value="${album.a_no}"/>'>앨범 보기</a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
     	</c:forEach>
        </div>
    </div>
</section>
<%@include file="../common/footer.jsp"%>
    </body>
</html>
    