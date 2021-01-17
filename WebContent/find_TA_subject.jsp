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
			 %>
			 			 <div class="container mt-3 mb-3">
						 	<div class="row">
							  <div class="col-6 col-sm-3 "><a class="btn btn-primary" href="homeStudent.jsp">home</a></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
					 	<div class="container">
					 	<div class="card">
					 	<div class="card-header">TA of an subject</div>
					 	<div class="card-body">
					 	
			 
			 <%
			 String type_user=(String)session.getAttribute("type");
			
			 String id=(String)session.getAttribute("id");
			 int id_user =Integer.parseInt(id);
			 String subject = request.getParameter("subject");
			 int id_subject =Integer.parseInt(subject);
			 Connection conn=do_conn(); 
			 String query=" select enroll.id ,user.type ,user.name,user.id ,user.email , enroll.id_subject from enroll INNER JOIN user where enroll.id_subject=? and user.id=enroll.id_user  ";
				 PreparedStatement preparedStmt = conn.prepareStatement(query);
			    preparedStmt.setInt(1,id_subject);
			    ResultSet rs= preparedStmt.executeQuery();
			    int count=0;
			    if(type_user.equals("student"))
				 {
					%>
					<a class="btn btn-primary" href="message_all_form.jsp?id_subject=<%out.print(id_subject);%>">message all</a>
					<% 
				 }
			    while(rs.next())
			    {
			    	count++;
			    	String type=rs.getString("type");
			    	if((type.equals("TA") || type.equals("DR")) && rs.getInt("user.id")!=id_user)
			    	{
			    	%>
			    	<div class="mt-3">
			    		<span class="badge badge-dark">TA no : <%out.print(count); %></span>
			    		<ul class="list-group">  
				   			<li class="list-group-item"><%out.print(rs.getString("type")); %>: <%out.print(rs.getString("name")) ;%></li>
				   			<li class="list-group-item">email: <%out.print(rs.getString("email")); %></li>
				   			<li class="list-group-item">office hours:<a href="officeHoursTA.jsp?id=<%out.print(rs.getString("user.id")); %>"> here </a></li>
				   			<li class="list-group-item">
				   			<form action="MessagesHandler?To=<%out.print(rs.getString("user.email")); %>" method="POST">
				   				<textarea  class="form-control" placeholder="Type message.." name="msg" id="msg"></textarea>
				   				 <button class="btn btn-success">send message</button>
				   			</form>
				   			</li> 
		   				</ul>
			    	</div>
			    	<% 
			    	}
			    }
			    if(count==0)
			    {
			    	%>
			    	<div class="alert alert-danger">no result</div>
			    	<%
			    }
			    %>
			    </div>
			    </div>
			    </div>
			    <%
			    
		 }
		%>
</body>
</html>