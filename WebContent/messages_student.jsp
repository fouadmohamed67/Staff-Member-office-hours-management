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
			 
			 %>
			 
						 <li class="list-group-item">
				   			<form action="MessagesHandler" method="POST">
				   				<textarea required class="form-control" placeholder="Type message.." name="msg" ></textarea>
				   				   
 				   				 <input required class="form-control"   placeholder="email" name="To" ></input>
				   				 <button class="btn btn-success">send message</button>
  				   			</li>
			 <%
		 }
			%>
</body>
</html>