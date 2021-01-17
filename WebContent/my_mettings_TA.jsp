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
					 String id=(String)session.getAttribute("id");
					 if(type.equals("TA")||type.equals("DR"))
					 {
					 	%>
						 <div class="container mt-3">
						 	<div class="row">
							  <div class="col-6 col-sm-3 "><a class="btn btn-primary" href="homeStudent.jsp">home</a></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
					 	
					 	  <div class="container mt-3">
					 	  	<div class="card">
					 	 		 <div class="card-header">
								     meetings you did it
								  </div>
								  <div class="card-body">
								     
								 
					 <% 
						 int id_int_user =Integer.parseInt(id);
						 
						 Connection conn=do_conn(); 
						 String query="select metting.id, metting.id_office_hour , metting.id_f_person ,  metting.id_S_person , metting.startIN ,metting.endIN , metting.date_booking ,user.name  from metting INNER JOIN user where metting.id_f_person=? and user.id=? ";
							  PreparedStatement preparedStmt = conn.prepareStatement(query);
						  	  preparedStmt.setInt(1,id_int_user);
						  	preparedStmt.setInt(2,id_int_user);
						  	  ResultSet rs= preparedStmt.executeQuery();
						  	  
						  	  
						  	  
						  	 	    int count=0;
						  	 		while(rs.next())
								  	  {
						  	 			query="select * from user where id=?"; 
						  	 		 preparedStmt = conn.prepareStatement(query);
						  	 	 	 preparedStmt.setInt(1,rs.getInt("id_S_person"));
						  	 	    ResultSet rs2= preparedStmt.executeQuery();
						  	 	    if(rs2.next())
						  	 	    {
						  	 	    	
						  	 	   
						  	 			
						  	 			count++;
								  		  
								  		 // out.println(rs.getInt("id_f_person"));
								  		  //out.println(rs.getInt("id_S_person"));
 								  		 
								  		
								  		%>
								  		 <div class="border-bottom m-3">
								  		 		 <div>meeting with TA: <% out.println(rs2.getString("name"));%></div>
										  		  <div>start in : <% out.println(rs.getTimestamp("startIN"));%></div>
										  		  <div>end in : <% out.println(rs.getTimestamp("endIN"));%></div>
										  		  <div>date booking : <% out.println(rs.getTimestamp("date_booking"));%></div>
										  		  <form method="POST" action="cancel_meeting.jsp?id=<% out.print(rs.getInt("id"));%>&id_sec=<%out.print(rs.getInt("id_S_person"));%>&idOH=<%out.print(rs.getInt("id_office_hour")); %>">
									  		    	<button class="btn btn-danger ">cancel</button>
								  		  	
								  		 		  </form>
								  		 </div>
								  			
								  		<% 
								  		
								  	  }
								  	 }
						  	 		if(count==0)
						  	 		{
						  	 			%>
						  	 			<div class="alert alert-danger"> u do not have mettings</div>
						  	 			<%
						  	 		
						  	 		}
						  	 	 
						    %>
						     </div>
							</div>
				 	   	</div>
				 	   	
				 	   	
				 	   	<!-- meeting will be with you -->
				 	   	<div class="container mt-3">
					 	  	<div class="card">
					 	 		 <div class="card-header">
								     meetings with you
								  </div>
								  <div class="card-body">
								     
								 
					 <% 
						  id_int_user =Integer.parseInt(id);
						 
						   conn=do_conn(); 
						   query="select metting.id, metting.id_office_hour , metting.id_f_person ,  metting.id_S_person , metting.startIN ,metting.endIN , metting.date_booking ,user.name  from metting INNER JOIN user where metting.id_S_person=? and user.id=? ";
							    preparedStmt = conn.prepareStatement(query);
						  	  preparedStmt.setInt(1,id_int_user);
						  	preparedStmt.setInt(2,id_int_user);
						  	    rs= preparedStmt.executeQuery();
						  	  
						  	  
						  	  
						  	 	      count=0;
						  	 		while(rs.next())
								  	  {
						  	 			query="select * from user where id=?"; 
						  	 		 preparedStmt = conn.prepareStatement(query);
						  	 	 	 preparedStmt.setInt(1,rs.getInt("id_f_person"));
						  	 	    ResultSet rs2= preparedStmt.executeQuery();
						  	 	    if(rs2.next())
						  	 	    {
						  	 	    	
						  	 	   
						  	 			
						  	 			count++;
								  		  
								  		 // out.println(rs.getInt("id_f_person"));
								  		  //out.println(rs.getInt("id_S_person"));
 								  		 
								  		
								  		%>
								  		 <div class="border-bottom m-3">
								  		 		 <div>meeting with : <% out.println(rs2.getString("name"));%></div>
										  		  <div>start in : <% out.println(rs.getTimestamp("startIN"));%></div>
										  		  <div>end in : <% out.println(rs.getTimestamp("endIN"));%></div>
										  		  <div>date booking : <% out.println(rs.getTimestamp("date_booking"));%></div>
										  		  <form method="POST" action="cancel_meeting.jsp?id=<% out.print(rs.getInt("id"));%>&id_sec=<%out.print(rs.getInt("id_S_person"));%>&idOH=<%out.print(rs.getInt("id_office_hour")); %>">
									  		    	<button class="btn btn-danger ">cancel</button>
								  		  	
								  		 		  </form>
								  		 </div>
								  			
								  		<% 
								  		
								  	  }
								  	 }
						  	 		if(count==0)
						  	 		{
						  	 			%>
						  	 			<div class="alert alert-danger"> u do not have mettings</div>
						  	 			<%
						  	 		
						  	 		}
						  	 	 
						    %>
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
</body>
</html>