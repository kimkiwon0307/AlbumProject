<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	    
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">


    <title>Login Bootstrap 5</title>
    
   <style>
   html, body, .container{
  height: 100%;
}

.login-form {
  width: 400px;
  padding: 2rem 1rem 1rem;
}

form {
  padding: 1rem;
}
   </style> 
   
</head>

<body>
    <div class="container">
        <div class="wrapper d-flex align-items-center justify-content-center h-100">
            <div class="card login-form">
                <div class="card-body">
                    <h5 class="card-title text-center"><a href="/album/list"> <i class="bi bi-house-door-fill"></i> </a></h5>
                     <a href="/member/register" style="float:right">회원가입</a>
                    <form action="/member/login" method="post">
                        <div class="mb-3">
                            <label for="exampleInputEmail1" class="form-label">아이디</label>
                            <input type="text" class="form-control" name="m_id" id="checkId" aria-describedby="emailHelp" required>
                        </div>
                        <div class="mb-3">
                            <label for="exampleInputPassword1" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" name="m_pwd" id="exampleInputPassword1"  required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100" id="loginBtn">로그인</button>
                        <div class="sign-up mt-4">
                          
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
	
</body>

</html>