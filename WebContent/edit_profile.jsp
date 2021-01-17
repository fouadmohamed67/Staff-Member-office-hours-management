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
	 if("POST".equals(request.getMethod()))
	 {
		 
		 String id=(String)session.getAttribute("id");
		 int id_int =Integer.parseInt(id);
		    String email=request.getParameter("email");
			String pass=request.getParameter("pass");
			String name=request.getParameter("name");
		 update_info(id_int,name,email,pass);
		 
		
		 String type=(String)session.getAttribute("type");
		 
		 if(type.equals("TA"))   response.sendRedirect("homeTA.jsp");
		 else response.sendRedirect("homeStudent.jsp");
	 }
	 if(null == session.getAttribute("id")){
			response.sendRedirect("login.jsp");
		}
	 	 
	 	
	  

	 else {
		 %>
		 
		 				 <div class="container mt-3 mb-3">
						 	<div class="row">
							  <div class="col-6 col-sm-3 "><a class="btn btn-primary" href="homeStudent.jsp">home</a></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
					 	<div class="container">
					 	<div class="card">
					 	<div class="card-header">edit your info</div>
					 	<div class="card-body">
		 <% 
	 
		 String id=(String)session.getAttribute("id");
		 int id_int =Integer.parseInt(id);
		 String query="SELECT * FROM user WHERE id="+id_int+"";
		 Connection conn=do_conn();
		 Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			String old_name="",old_email="",old_pass="";
			while(rs.next())
			{
				old_name=rs.getString("name");
				old_email=rs.getString("email");
				old_pass=rs.getString("pass");
			}
		
	%>


			<form action="" method="POST">
			  <div class="form-group row">
			    <label for="name" class="col-sm-2 col-form-label">name</label>
			    <div class="col-sm-10">
			      <input type="text"   class="form-control-plaintext" name="name" value="<% out.print(old_name); %>">
			    </div>
			  </div>
			  
			  
			  <div class="form-group row">
			    <label for="name" class="col-sm-2 col-form-label">email</label>
			    <div class="col-sm-10">
			      <input type="text"   class="form-control-plaintext" name="email" value="<% out.print(old_email); %>">
			    </div>
			  </div>
			  
			  <div class="form-group row">
			    <label for="name" class="col-sm-2 col-form-label">pass</label>
			    <div class="col-sm-10">
			      <input type="text"   class="form-control-plaintext" name="pass" value="<% out.print(old_pass); %>">
			    </div>
			  </div>
			  
			  <button type="submit" class="btn btn-primary mb-2">UPDATE</button>
			</form>
			<% } %>
		
</body>
</html>