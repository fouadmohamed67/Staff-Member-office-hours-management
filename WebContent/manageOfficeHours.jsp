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
	 	<%@ include file = "fun.jsp"%>
	 	 <%@ page import="java.text.SimpleDateFormat" %>
	 	  <%@ page import="java.util.Date" %>
	 
			<%	 	
	 	 if(null == session.getAttribute("id"))
	 	    {
				response.sendRedirect("login.jsp");
			}
		 else
			 {
			 
			 String id=(String)session.getAttribute("id");
			 String do_action=String.valueOf(request.getParameter("do"));
			 System.out.println(do_action);
			 if(null==do_action)
			 {
				 do_action="manage";
			 }
			 if(do_action.equals("manage"))
			 {
				    Connection conn=do_conn();
			 		String query="select * from office_hours where user_id="+id;
		   		    Statement st=conn.createStatement();
		   			ResultSet rs = st.executeQuery(query);
 				 %>
				 
				 
				 
				 
				 
				  <div class="container pt-20">
			          <div class="table-responsive p-10">
			          <a href="?do=addinform" class="btn btn-primary">add office_hours</a>
			          <a href="homeTA.jsp" class="btn btn-secondary">home</a>
					           <table class="table ">
						            <thead>
						                <tr>
						                   
						                    <th>from</th>
						                    <th>to</th>
						                    <th>busy</th>
						                    <th>action</th>
						                </tr>
						            </thead>
						            <tbody>
						            <% while(rs.next())
       								 {%>
       								 <tr>
       								 	<td><% out.print(rs.getTimestamp("date_start")); %></td>
       								 	 <td><% out.print(rs.getTimestamp("date_end")); %></td> 
       								 	 <td><%
       								 	 if(rs.getInt("busy")==0)
       								 	 {
       								 		out.print("free");
       								 	 }
       								 	 else
       								 	 {
       								 		out.print("busy");
       								 	 }
       								 	 %></td>
       								 	 <td>  	 
		       							    <form action="?do=delete&id=<%out.print(rs.getInt("id"));%>" method="POST">
		       							 	  <button class="btn btn-danger mb-2">delete</button>
		       						    	</form>
		       						    	<form action="?do=edit&id=<%out.print(rs.getInt("id"));%>" method="POST">
		       							 	  <button class="btn btn-success">edit</button>
		       						    	</form>
       								     </td>
       								 	
       								 </tr>
       								 <%} %>
						            </tbody>
					           </table>
			          </div>
	                </div>
				 
				 
				 
				 
				 
				 
				 <%
			 }
			 else if(do_action.equals("delete"))
			 {
				 
				 String id_office=String.valueOf(request.getParameter("id"));
				 int id_office_int =Integer.parseInt(id_office);
				 
				  Connection conn=do_conn();
				   String query="delete from office_hours where id=?";
				   java.sql.PreparedStatement preparedStmt = conn.prepareStatement(query);
				    
				    preparedStmt.setInt(1,id_office_int);
				   
			        preparedStmt.execute();
			        response.sendRedirect("manageOfficeHours.jsp?do=manage");
			        
			 }
			 else if(do_action.equals("edit"))
			 {
				 String id_office=String.valueOf(request.getParameter("id"));
				 int id_office_int =Integer.parseInt(id_office);
				 
				   Connection conn=do_conn();
			 		String query="select * from office_hours where  id="+id_office_int;
		   		    Statement st=conn.createStatement();
		   			ResultSet rs = st.executeQuery(query);
		   			while(rs.next())
		   			{
				 	
				 %>
				 	<div class="card d-flex justify-content-center" >
                        <div class="card-header">
                            <div class="h1 d-flex justify-content-center">edit officeOurs</div>
                        </div>
                        <div class="card-body">
                        	
                        	  <form action="?do=update_db&id=<%out.println(rs.getInt("id")); %>" method="POST" name="time" onsubmit="return ValidateOffice()">
				 	 
						 	      <div class="form-group  ">
									  <label for="example-datetime-local-input" class="col-2 col-form-label">Date start</label>
									  <div class="col-10">
									    <input class="form-control" value="<%out.print(rs.getTimestamp("date_start")); %>" name="start" type="datetime-local"  >
									  </div>
									</div>
									<div id="err1"></div>
									
									<div class="form-group  ">
									  <label for="example-datetime-local-input" class="col-2 col-form-label">Date end</label>
									  <div class="col-10">
									    <input class="form-control" value="<%out.print(rs.getTimestamp("date_end")); %>" name="end" type="datetime-local"  >
									  </div>
									</div>
									<div id="err2"></div>
									
									<button type="submit" class="btn btn-primary">update</button>
								 </form>
                        
                        
                        </div>
                     </div>
				 <%
				 
		   			}
			 }
			 else if(do_action.equals("update_db"))
			 {
				 String id_office=String.valueOf(request.getParameter("id"));
				 int id_office_int =Integer.parseInt(id_office);
				 System.out.println(id_office_int);
				 
				 String start =	 request.getParameter("start");
				 String end =	 request.getParameter("end");
				 
					 start += ":00";
					 end += ":00";
					 
				 
				 Timestamp s=	 Timestamp.valueOf(start.replace("T"," "));
				 Timestamp e=	 Timestamp.valueOf(end.replace("T"," "));
				 
				 Connection conn=do_conn();
				   String query="update office_hours set date_start=? ,date_end=? where id=?";
				   java.sql.PreparedStatement preparedStmt = conn.prepareStatement(query);
				    preparedStmt.setTimestamp(1, s);
				    preparedStmt.setTimestamp(2, e);
				    preparedStmt.setInt(3,id_office_int);
				   
			        preparedStmt.execute();
			        response.sendRedirect("manageOfficeHours.jsp?do=manage");
				 
			 }
			 else if(do_action.equals("addinform"))
			 {
				 %>
				 	 <div class="card d-flex justify-content-center" >
                        <div class="card-header">
                            <div class="h1 d-flex justify-content-center">add officeOurs</div>
                        </div>
                        <div class="card-body">
                        	
                        	  <form action="?do=add_to_db" method="POST" name="time" onsubmit="return ValidateOffice()">
				 	 
						 	      <div class="form-group  ">
									  <label for="example-datetime-local-input" class="col-2 col-form-label">Date start</label>
									  <div class="col-10">
									    <input class="form-control" name="start" type="datetime-local"  >
									  </div>
									</div>
									<div id="err1"></div>
									
									<div class="form-group  ">
									  <label for="example-datetime-local-input" class="col-2 col-form-label">Date end</label>
									  <div class="col-10">
									    <input class="form-control" name="end" type="datetime-local"  >
									  </div>
									</div>
									<div id="err2"></div>
									
									<button type="submit" class="btn btn-primary">add</button>
								 </form>
                        
                        
                        </div>
                     </div>
				 	 
				 	 
				 <%
			 }
			 else if(do_action.equals("add_to_db"))
			 {
				 if("POST".equals(request.getMethod())){
					 String id_user=(String)session.getAttribute("id");
					 int id_int =Integer.parseInt(id_user);
					  
					 
					 
					 String start =	 request.getParameter("start");
					 String end =	 request.getParameter("end");
					 
						 start += ":00";
						 end += ":00";
						 
					 System.out.println(start);
					 Timestamp s=	 Timestamp.valueOf(start.replace("T"," "));
					 Timestamp e=	 Timestamp.valueOf(end.replace("T"," "));
					 
					 Connection conn=do_conn();
					   String query="INSERT INTO office_hours(date_start,date_end,user_id,busy) VALUES( ?, ?, ?, ? )";
					   java.sql.PreparedStatement preparedStmt = conn.prepareStatement(query);
					    preparedStmt.setTimestamp(1, s);
					    preparedStmt.setTimestamp(2, e);
					    preparedStmt.setInt(3,id_int);
					    preparedStmt.setInt(4,0);
				        preparedStmt.execute();
				        response.sendRedirect("manageOfficeHours.jsp?do=manage");
					 
					 
			 
				
				
				 }
				 else
				 {
					 response.sendRedirect("homeTA.jsp");
				 }
			 }
				 
			 
			 
			 
			 }
			%>
	 		<script>  
			 
					function ValidateOffice(){  
					var start=document.time.start.value;  
					var end=document.time.end.value; 
					  
					 if(start.length == "")
						 { 
						 document.getElementById("err1").innerHTML="<div class='alert alert-danger'>  required field </div>";  
					 
						 return false;  
						 }
					 if(end.length == "")
						 { 
						 document.getElementById("err2").innerHTML="<div class='alert alert-danger'>required field </div>";  
					      return false;  
						 }
					 
					    return true
					  
						    
					}  
				</script> 
	 	

</body>
</html>