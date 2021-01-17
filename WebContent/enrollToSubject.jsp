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
				 int id_int_user =Integer.parseInt(id);
				 String do_action=String.valueOf(request.getParameter("do"));
				 System.out.println(do_action);
				 if(null==do_action)
				 {
					 do_action="manage";
				 }
				 if(do_action.equals("manage"))
				 {
					 %>
						 <div class="container mt-3 mb-3">
						 	<div class="row">
							  <div class="col-6 col-sm-3 "><a class="btn btn-primary" href="homeStudent.jsp">home</a></div>
							  <div class="col-6 col-sm-3"><a class="btn btn-danger" href="logout.jsp">logout</a></div> 
							</div>
					 	</div>
					 	
					 <div class="container">
					 <%
					    Connection conn=do_conn();
				 		 
					    String query="select enroll.id , enroll.id_user,enroll.id_subject , subject.code from enroll INNER JOIN subject where  enroll.id_user=? and enroll.id_subject=subject.id ";
						 PreparedStatement preparedStmt = conn.prepareStatement(query);
					    preparedStmt.setInt(1,id_int_user);
				        
					    ResultSet rs= preparedStmt.executeQuery();
					    int[] id_subjects_enroll = new int[50];
					    int count=0;
					    %>
					    <div> your subjects</div>
					    <div>select to  remove</div>
					    
					    <form action="?do=remove_enroll" method="POST">
					     <select name="subject" class="form-control"  required  multiple="multiple"  >
					    <% 
					    while(rs.next())
					    {
					    	
					    	id_subjects_enroll[count]=	rs.getInt("id_subject");
					    	count++;
					    	%>
					    	 <option value="<%out.print(rs.getString("id")); %>"><%out.print(rs.getString("code")); %></option> 
					    	
 					    	<%
					    	 
					    }
					    
					 
					 %>
					         </select>
							  	 <button type="submit" class="btn btn-danger">delete</button>
					</form>
					 	<div>
					 	<form action="?do=add_to_db" method="POST" >
					 	 
					 	
						   <div> Choose ur subject:</div>
						   <select name="subject" class="form-control" required multiple="multiple"  >
						    <%
						   		    conn=do_conn(); 
								    query="select * from subject";
								    preparedStmt = conn.prepareStatement(query); 
							  	    rs= preparedStmt.executeQuery();
							  	    int no_registerd=0;
							  	  while(rs.next())
							  	  {
							  		  
							  		  int id_sub=rs.getInt("id");
										if( !check_num_int_exist(id_subjects_enroll,id_sub))
										{
										%>
											    <option value="<%out.print(rs.getString("id")); %>"><%out.print(rs.getString("code")); %></option> 
										<%
										}									     
									 
							  	  }
							  	  
							  	 %>
							   </select>
							  	 <button type="submit" class="btn btn-success"> add</button>
							  	 </form>
							  	  </div>
						 </div>
					 <%
				 }
				 else if(do_action.equals("add_to_db"))
				 {
					 Connection conn=null;
					 String query="";
					 PreparedStatement preparedStmt=null;
					 String id_user=(String)session.getAttribute("id");
					 id_int_user =Integer.parseInt(id_user);
					 
					 String[] values= request.getParameterValues("subject");
					 for(int i=0;i<values.length;i++)
					 {
						 int val=Integer.parseInt(values[i]);
						   conn=do_conn(); 
						   query="insert into enroll(id_user,id_subject) values(?,?)";
							   preparedStmt = conn.prepareStatement(query);
						    preparedStmt.setInt(1,id_int_user);
					        preparedStmt.setInt(2,val);
					        preparedStmt.execute();
						 
					 }
					 response.sendRedirect("enrollToSubject.jsp?do=manage");
				 }
				 else if(do_action.equals("remove_enroll"))
				 {
					 Connection conn=null;
					 String query="";
					 PreparedStatement preparedStmt=null;
					 String[] values= request.getParameterValues("subject");
					 for(int i=0;i<values.length;i++)
					 {
						 int id_enrill=Integer.parseInt(values[i]);
						   conn=do_conn(); 
						   query="delete from enroll where id=?";
							   preparedStmt = conn.prepareStatement(query);
						    preparedStmt.setInt(1,id_enrill);
					        
					        preparedStmt.execute();
						 
					 }
					 response.sendRedirect("enrollToSubject.jsp?do=manage");


				 }
			 }
			
			%>
</body>
</html>