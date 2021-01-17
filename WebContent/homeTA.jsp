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
 		<%@ page import="java.io.*" %>
	    <%@ page import="java.sql.*" %>
	    <%@ page import="java.lang.ClassNotFoundException" %>
	 	<%@  include file = "fun.jsp"%>
<%
		 if(null == session.getAttribute("id")){
				response.sendRedirect("login.jsp");
			}
		 else {
			 String type=(String)session.getAttribute("type");
			 String id=(String)session.getAttribute("id");
			 if(type.equals("TA") ||type.equals("DR"))
			 {
				 //page 
				 
				 %>
				 <div id="ree">
					  <div class="container mt-4">
						 	<div class="row">
 							  <div class="col-md-2"><a class="btn btn-secondary" href="edit_profile.jsp">edit profile</a></div>
 							  <div class="col-md-3"><a class="btn btn-light" href= "manageOfficeHours.jsp?do=manage">manage office hours</a></div> 
 							  <div class="col-md-2"><a class="btn btn-info" href="messages_student.jsp">Message</a></div> 
 							  <div class="col-md-2"><a class="btn btn-info" href="Viewmessages.jsp">View Messages</a></div> 
							  <div class="col-md-2"><a class="btn btn-info" href="my_mettings_TA.jsp">view my mettings</a></div> 
							  <div class="col-md-2"><a class="btn btn-success" href="enrollToSubject.jsp?do=manage">enroll subject</a></div> 
							  <div class="col-md-2"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
					 	
					 	
 				  <div class="m-5 col">
							<div class="row">
								<div>find TA OR student using email</div>
							 <form method="POST" class="form-inline"> 
							  <div class="form-group mx-sm-3 mb-2">
							    <label for="inputPassword2" class="sr-only">email</label>
							     <input required type="text" required name="email_TA" class="form-control"  placeholder="email TA" id="email_TA">
							  </div>
							  <button type="button" class="btn btn-primary mb-2" onclick="reg();">find TA</button>
							</form>
							</div>
							
							
							
							<%
							Connection conn=do_conn();
					 		 
							 String query="select * from subject  ";
							 PreparedStatement preparedStmt = conn.prepareStatement(query);
							 ResultSet rs= preparedStmt.executeQuery();
							 
							%>
							<div class="row">
								<div>find TA using subject</div>
							 <form action="find_TA_subject.jsp"  method="POST" class="form-inline"> 
							  <div class="form-group mx-sm-3 mb-2">
							    <label for="inputPassword2" class="sr-only">subject</label>
							    <div class="form-group">
							    <select name="subject" class="form-control" required  >
						    	
						    		<% while(rs.next())
								    	{
								    		%>
								    		<option value="<%out.print(rs.getString("id")); %>"><%out.print(rs.getString("code")); %></option> 
								    		<%
								    	}
											    
								   %>	  
										
							   </select>
							   </div>
 							  </div>
							  <button type="submit" class="btn btn-primary mb-2">find TA</button>
							</form>
							</div>
						</div>
					 </div>

				 <%
			 }
			 else
			 {
				 response.sendRedirect("homeStudent.jsp");
			 }
			}

 %>
 <script>
 function reg()
	{
	 var TAemail = document.getElementById("email_TA").value;
		var xmlhttp = new XMLHttpRequest();
		 xmlhttp.open("POST", "find_TA.jsp", true);
		 xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	     xmlhttp.send("email_TA="+TAemail);
     	xmlhttp.onreadystatechange = function() {
         if (this.readyState == 4 && this.status == 200) {
             document.getElementById("ree").innerHTML = this.responseText;
         }
     };
    
	}
		
 </script>
 
</body>
</html>