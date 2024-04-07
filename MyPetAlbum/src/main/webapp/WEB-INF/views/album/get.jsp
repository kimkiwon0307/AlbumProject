<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
<script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
 
<style>

body {
  background-color:#1d1d1d !important;
  font-family: "Asap", sans-serif;
  color:#989898;
  margin:10px;
  font-size:16px;
}

#demo {
  height:100%;
  position:relative;
  overflow:hidden;
}

.green{
  background-color:#6fb936;
}
        .thumb{
            margin-bottom: 30px;
        }
        
        .page-top{
            margin-top:85px;
        }

img.zoom {
    width: 100%;
    height: 200px;
    border-radius:5px;
    object-fit:cover;
    -webkit-transition: all .3s ease-in-out;
    -moz-transition: all .3s ease-in-out;
    -o-transition: all .3s ease-in-out;
    -ms-transition: all .3s ease-in-out;
}
 
.transition {
    -webkit-transform: scale(1.2); 
    -moz-transform: scale(1.2);
    -o-transform: scale(1.2);
    transform: scale(1.2);
}
    .modal-header {
   
     border-bottom: none;
}
    .modal-title {
        color:#000;
}
    .modal-footer{
      display:none;  
}

</style>
<title>Insert title here</title>
</head>
<body>
    <!-- Page Content -->
   <div class="container page-top">
        <div class="row">
  
        	
       </div>
       <div>
       	<form action="/album/deleteAlbum" method="post" id="formObj">
       		<input type="hidden" name="a_no" value="${a_no}" id="a_no"/>
       			<button type="button" class="btn btn-warning" id="Dbtn" >앨범삭제</button>
       		<button type="button" class="btn btn-danger" id="Bbtn">뒤로가기</button>
       	</form>
       </div>
    </div>
<script type="text/javascript">
$(document).ready(function(){
	
		var a_no = $("#a_no").val();
		    
	   (function(){
		    
		    $.getJSON("/album/getAttachList", {a_no: a_no}, function(arr){
		    	console.log(arr);
		    	
		    	var str = "";
		    	
		    	$(arr).each(function(i, attach){
		    		
		    		var fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
		    		
		        	str += " <div class='col-lg-3 col-md-4 col-xs-6 thumb'>";
		        	str += "<a href='/album/display?fileName=" + fileCallPath + "&auto=compress&cs=tinysrgb&h=650&w=940' class='fancybox' rel='lightbox'>";
		        	str += " <img src='/album/display?fileName=" + fileCallPath + "' class='zoom img-fluid' alt=''>";
		        	str += "  </a>";
		        	str += "</div>";
		    	});
		    	//$(".uploadResult ul").html(str);
		    	$(".row").html(str);
		    	
		    });//getjson
		   })(); //end function
	
		$("#Bbtn").on("click",function(e){
			self.location ="/album/list";
		});
		   
		$("#Dbtn").on("click",function(e){
			
			
			var formObj = $("#formObj");
			
			if(confirm("정말 삭제 하시겠습니까?")){
				
				formObj.submit();
			}else{
		    	return false;
			}
		}) 
		   
		   
		   
	  $(".fancybox").fancybox({
	        openEffect: "none",
	        closeEffect: "none"
	    });
	    
		   
	  $(".zoom").hover(function(){
			
		$(this).addClass('transition');
		}, function(){
			$(this).removeClass('transition');
		});
	   
	    
	});
	
	
	
	
	
	
	
	
</script>

</body>
</html>