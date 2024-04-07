<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	    
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
  <link rel="stylesheet" href="style.css">
  <style>
  body, html {
    height: 100%;
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
}

.signup-container {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f4f4f4;
}

.signup-form {
    width: 400px; 
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   
    margin: auto; 
}

.signup-form h2 {
    margin: 0 0 20px;
}

.signup-form input {
    width: calc(100% - 24px); 
    height: 40px;
    margin-top: 20px; 
    padding: 0 8px; 
    border: 1px solid #ddd;
    border-radius: 20px;
    outline: none;
    transition: border-color 0.3s ease;
}

.signup-form input:hover {
    border-color: #007bff; 
}

.signup-form button {
    width: calc(100%); 
    height: 40px;
    border: none;
    background-color: #007bff;
    color: white;
    border-radius: 20px;
    cursor: pointer;ф
    margin-left: -10px; 
    transition: background-color 0.3s ease;
}

.signup-form button:hover {
    background-color: #0056b3; 
}
#s_nick_check_success,#s_pwd_check_success{
	color:green;
	display:none;
}
#s_nick_check_fail,#s_pwd_check_fail{
	color:red;
	display:none;
}

form button{
	margin-top:20px;
}

  </style>
</head>

<body>
  <div class="signup-container">
  
    <form class="signup-form" action="/member/register" method="post">
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
      <h2>회원가입</h2>
      <input type="text" id="nick_check" placeholder="아이디"  name='m_id' required>
      	<span  class="input-group" id="s_nick_check_success">사용 가능한 닉네임 입니다.</span>
	 	<span  class="input-group" id="s_nick_check_fail">존재하는 닉네임 입니다.</span>
      
      <input type="email" placeholder="이메일" name='m_email'   required>
      
      <input type="password" placeholder="비밀번호"  name= 'm_pwd' required>
      
      <input type="password"   id="check_pw" placeholder="비밀번호 확인" required>
     	 <span  class="input-group" id="s_pwd_check_success">비밀번호가 같습니다.</span>
	 	 <span  class="input-group" id="s_pwd_check_fail">비밀번호가 다릅니다.</span>
      
      <button type="submit">회원가입</button>
      <button type="button" class="btn btn-danger" id="loginBtn">로그인</button>
    </form>
  </div>
 <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
 <script type="text/javascript">
	$(document).ready(function(){
			
		// 아이디 중복검사
		$('#nick_check').on("propertychange change keyup paste input", function(){
				
			var m_nick = $('#nick_check').val();
			var data = {m_nick : m_nick};
			
			if($(this).val() != 0){
				
			$.ajax({
					
				type: "post",
				url : "/member/m_nick_check",
				data : data,
				success : function(result){
				console.log(result);
					if(result != 'fail'){
						$("#s_nick_check_fail").css("display","none");
						$("#s_nick_check_success").css("display","inline-block");
						$("#signUp_btn").attr("type","submit");
					}else{
						$("#s_nick_check_fail").css("display","inline-block");
						$("#s_nick_check_success").css("display","none");
						$("#signUp_btn").attr("type","button");
					}
				}
			}); // ajax 
		   }else {
			   $("#s_nick_check_fail").css("display","none");
			   $("#s_nick_check_success").css("display","none");
		   }// if
		}); // 아이디 중복검사
		
		
		
		
		$('#check_pw').on("propertychange change keyup paste input", function(){
			
			var inputname = $('input[name=m_pwd]').val()
			
			if($(this).val() == 0){
				$("#s_pwd_check_fail").css("display","none");
				$("#s_pwd_check_success").css("display","none");
			}
			else if($(this).val() == inputname){
				$("#s_pwd_check_success").css("display","inline-block");
				$("#s_pwd_check_fail").css("display","none");
			}else{
				$("#s_pwd_check_success").css("display","none");
				$("#s_pwd_check_fail").css("display","inline-block");
			}
			
		});
		
		$("#loginBtn").on("click",function(e){
			
			self.location ="/member/login";
			
		})
		
		
		
	})
</script>
  
 
</body>

</html>