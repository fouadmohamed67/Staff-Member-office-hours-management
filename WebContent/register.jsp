<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
 <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Lato:300,400,500' rel='stylesheet' type='text/css'>
     
</head>
<body>

	<%
	 
	%>

        <%@ page import="java.io.*" %>
	    <%@ page import="java.sql.*" %>
	    <%@ page import="java.lang.ClassNotFoundException" %>
	 	<%@  include file = "fun.jsp"%>
	 
	 	 
	 
	 
<div class="container">
                <div class="card d-flex justify-content-center" >
                        <div class="card-header">
                            <div class="h1 d-flex justify-content-center">register</div>
                        </div>
                        <div class="card-body">
                            <form action="registeration" onsubmit="return ValidateRegister()" name="login_form" method="POST" >
                             
                                        <div class="form-group">
                                            <label for="name">your name : </label>
                                            <input type="text" class="form-control"   name="name" required="required" >
                                        </div>
                                      	<div id="err1"></div>
                                          
                                        <div class="form-group">
                                            <label for="address">email(gmail) : </label>
                                            <input type="text" class="form-control" name="email" id="email" required="required" onblur="register()" >
                                        </div>
                                        <div id="err2"></div>
                                        <div id="err3"></div>
                                        
                                        <div class="form-group">
                                                  <label for="type">type : </label>
											 	  <select class="form-control" name="type">
												      <option>student</option>
												      <option>TA</option> 
												      <option>DR</option>
											      </select>           
		                 	            </div>
                                        
                                        
	                               <!-- 6LeiiiQaAAAAANWnk4r5GrBeNB-LiUrt0IlxWC1Z -->
	                               <!-- 6LeiiiQaAAAAAKx2c4m1hRCk4sUteAF2ZBE2RUDt -->   
                                        
                                         <div   class="g-recaptcha" data-sitekey="6LeiiiQaAAAAANWnk4r5GrBeNB-LiUrt0IlxWC1Z"></div>
                                         <div >
                                         	
                                         	
                                         	<%
                                         	if(null != session.getAttribute("err_cap")) 
                                         		
                                         		{
                                         			%>
                                         			<div class="alert alert-danger">pleace mark captcha in the right way</div>
                                         			<% 

                                         		}
                                         	%>
                                         </div>
                                          <div class="form-group">
                                            <input type="submit" class="btn btn-primary" value="register" name="submit" id="">   
                                        
                                        </div>
                                         
                            </form>
                            <a href="login.jsp">you have account ?</a>
                        </div>
                </div>
         </div>

	        <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
	        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
	        	 <script>  
	        	 function register()
		            {
					 	var email = document.getElementById("email").value;
		                var xmlhttp = new XMLHttpRequest();
		                xmlhttp.open("POST", "register_ajax", true);
		                xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		                xmlhttp.send("email=" + email);
		                xmlhttp.onreadystatechange = function ()
		                {
		                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
		                    {
		                    	var check=xmlhttp.responseText;
		                   
		                         if(check==="true"){
		                        	 document.getElementById("err3").innerHTML="<div class='alert alert-danger'>This email exists </div>";
		                        	 return false;
		                        	
		                         }
		                         else{
		                        	 return true;
		                         }
		                         
		                    }
		                   
		                }


		            }
			 
					function ValidateRegister(){  
					var name=document.login_form.name.value;  
					var email=document.login_form.email.value; 
					  
					 
					 if(name.length < 3)
						 { 
						 document.getElementById("err1").innerHTML="<div class='alert alert-danger'>name should be more 3 letters </div>";  
					 
						 return false;  
						 }
					 if(email.length < 3)
						 { 
						 document.getElementById("err2").innerHTML="<div class='alert alert-danger'>address should be more 3 letters </div>";  
					      return false;  
						 }
					 
					    return true
					  
						    
					}  
				
				</script> 
</body>
</html>