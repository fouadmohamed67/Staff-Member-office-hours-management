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
			 String type=(String)session.getAttribute("type");
			  String email=request.getParameter("email_TA");
			    
			     Connection conn=do_conn();
		 	     String query="select * from user where  email='"+email+"' ";
		 		  Statement st=conn.createStatement();
		   			ResultSet rs = st.executeQuery(query);
		   			%>
		   				<div class="container mt-3">
						 	<div class="row">
							  <div class="col-6 col-sm-3 ">
							  <%
						    	  if(type.equals("TA") )
				   				{
				   					%><a class="btn btn-primary" href="homeTA.jsp">home</a><%
				   				}
				   		    	else
					   			{
				   			 		%><a class="btn btn-primary" href="homeStudent.jsp">home</a><%
					   			}
		   				%></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
		   				
		   				<div class="container mt-3">
		   			
		   				<ul class="list-group">
						 
						  
						
		   			<%  
		   			if(rs.next())
		   			{
		   			 String id=(String)session.getAttribute("id");
		   			 int id_int =Integer.parseInt(id);
		   				if(rs.getInt("id") == id_int)
		   				{
		   				 System.out.println(type);
		   					%>
		   						<div> you can not book meeting with yourself</div>
		   					<%
		   				}
		   				else
		   				{
		   					String type_email=rs.getString("type");
		   					%>
				   			
				   			<li class="list-group-item">name: <%out.print(rs.getString("name")); %></li>
				   			<li class="list-group-item">email: <%out.print(rs.getString("email")); %></li>
				   			<% if(type_email.equals("TA")|| type_email.equals("DR"))
				   			{
				   				%>
					   			<li class="list-group-item">office hours:<a href="officeHoursTA.jsp?id=<%out.print(rs.getString("id")); %>"> here </a></li>
					   			<%
				   			}
				   			else
				   			{
				   				%>
					   			<li class="list-group-item">student</li>
					   			<%
				   			}
					   			
		   				}
		   				
		   			}
		   			else
		   			{
		   				%>
		   				<div class="alert alert-danger">
		   				this email not found
		   				</div>
		   				<%
		   			}
		   			%>
		   			</ul>
		   			</div>
		   			<%
		 }
		%>
</body>
</html>