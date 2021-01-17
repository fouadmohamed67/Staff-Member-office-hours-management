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
			String id=request.getParameter("id");
			 int id_int =Integer.parseInt(id);
			 Connection conn=do_conn();
		 	  String query="select user.name , user.email , office_hours.date_start , office_hours.date_end,office_hours.id , office_hours.busy from office_hours INNER JOIN user where office_hours.user_id="+id_int + " and user.id="+id_int;
		 	  Statement st=conn.createStatement();
  			  ResultSet rs = st.executeQuery(query);
  			
  			%>
  						<div class="container mt-4">
						 	<div class="row">
							  <div class="col-6 col-sm-3 "><a class="btn btn-primary" href="homeStudent.jsp">home</a></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
  			<div class="container mt-3">
  			<%
  			while(rs.next())
  			{
  				
  			
		
		%>
		<div class="card">
		  <div class="card-header">
		   name:  <% out.print(rs.getString("name")); %>
		  </div>
		  <div class="card-body">
		    <h5 class="card-title">email :  <% out.print(rs.getString("email")); %></h5>
		    <p class="card-text">slot from :  <% out.print(rs.getString("date_start")); %></p>
		    <p class="card-text">slot from :  <% out.print(rs.getString("date_end")); %></p>
		    <%
		    if(rs.getInt("busy")==0)
		    {%>
			    <a href="book_office_hour.jsp?id=<%out.print(rs.getInt("id")); %>&id_ta=<% out.print(id);%>" class="btn btn-primary">book now</a>
			<%
		    }
		    else
		    { %>
		    	<div class="alert alert-danger">can not book</div>
		      <%
		    }
		    %>
		  </div>
		  </div>
		  <%} %>
</div>
</body>
</html>