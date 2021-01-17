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
		 if(null == session.getAttribute("id"))
		 	{
				response.sendRedirect("login.jsp");
			}
		 else
		 {
			 String subject = request.getParameter("id_subject");
			
						%>
							<li class="list-group-item">
				   			<form action="message_all.jsp?id_subject=<%out.print(subject);%>" method="POST">
				   				<textarea class="form-control" placeholder="Type message.." name="msg" id="msg"></textarea>
				   				 <button class="btn btn-success">send message</button>
				   			</form>
				   			</li>
				   	  <%
				   		
		}
		%>
</body>
</html>