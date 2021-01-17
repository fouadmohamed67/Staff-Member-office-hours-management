 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>

  <div class="card d-flex justify-content-center" >
        <div class="card-header">
             <div class="h1 d-flex justify-content-center">login now</div>
        </div>
        <div class="card-body">

            <form action="logincheck" name="login_form" method="POST" class="form">
                <div class="form-group">
                    <label for="email">email : </label>
                    <input type="text" class="form-control" name="email" id="email" >
                </div>
                <div id="err1"></div>
 
                <div class="form-group">
                    <label for="password">password : </label>
                    <input type="password" class="form-control" name="pass" id="pass" onblur="login()">
                </div>
                <div id="err2"></div>
                <div class="form-group">
                    <input type="submit" value="login" class="btn btn-primary" name="submit">   
                    
                </div>
            
            </form>
            <a href="register.jsp">register ? </a>

        </div>
    </div>
</div>
			 <script>  
			 	
			 	
			 function login()
	            {
				 	var email = document.getElementById("email").value;
				 	var pass = document.getElementById("pass").value;
	                var xmlhttp = new XMLHttpRequest();
	                xmlhttp.open("POST", "process_ajax", true);
	                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	                xmlhttp.send("email=" + email+"&pass="+pass);
	                xmlhttp.onreadystatechange = function ()
	                {
	                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
	                    {
	                    	 var check=xmlhttp.responseText;
	                         if(check==="true"){
	                        	 return true;
	                         }
	                         else{
	                        	 document.getElementById("err1").innerHTML="<div class='alert alert-danger'>This email doesn't match with this password </div>";  
	    						 return false;  
	                         }
	                    }
	                   
	                }


	            }
			
			 /*
					function ValidateLogin(){  
					var email=document.login_form.email.value;  
					var pass=document.login_form.pass.value; 
					   
					 if(email.length < 1)
						 { 
						 document.getElementById("err1").innerHTML="<div class='alert alert-danger'>email is required </div>";  
					 
						 return false;  
						 }
					 if(pass.length < 6)
						 { 
						 document.getElementById("err2").innerHTML="<div class='alert alert-danger'>pass must be 6 letters </div>";  
					      return false;  
						 }
					 
					    return true
					  
						    
					}  */
					
				</script> 
</body>
</html>