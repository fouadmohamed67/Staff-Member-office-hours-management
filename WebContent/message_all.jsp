<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="ass2.SendEmail" %>
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
			 String id=(String)session.getAttribute("id");
			 int id_user =Integer.parseInt(id);
			 String subject = request.getParameter("id_subject");
			 int id_subject =Integer.parseInt(subject);
			 String message = request.getParameter("msg");
			 System.out.print(id_subject);
			 Connection conn=do_conn(); 
			 String query="select  user.name , user.email, user.id,user.type , enroll.id_user from enroll INNER JOIN user where enroll.id_subject=? and (user.type='TA' or user.type='DR') and (user.id= enroll.id_user)";
				  PreparedStatement preparedStmt = conn.prepareStatement(query);
			  	  preparedStmt.setInt(1,id_subject);
			  	  ResultSet rs= preparedStmt.executeQuery(); 
			  	 // String q="select * from user where id="+id_user;
			  	 // PreparedStatement pr=conn.prepareStatement(q);
			  	 // ResultSet r= pr.executeQuery();
			  	 // String FROM="";
			  	 // if(r.next()){
			  	//	  FROM=r.getString("email");
			  	 // }
			  	 		while(rs.next())
			  	 		{	
			  	 			
			  	 			  
			  	 			send_message(message,id_user,rs.getInt("user.id"));
			  	 			PreparedStatement prStmt=(PreparedStatement) conn.prepareStatement("select * from user where id=?");
			  				prStmt.setInt(1,id_user);
			  				ResultSet Rs = prStmt.executeQuery();
			  				String SName="";
			  				if(Rs.next())
			  				{
			  					SName=Rs.getString("name");
			  					
			  				}
			  				
			  		        String ms="You have new message from "+SName;
			  		        String sub="Messages";
			  		        SendEmail se=new SendEmail();
			  		        se.send(rs.getString("user.email"), ms, sub);
			  	 		}
			  	 		response.sendRedirect("homeStudent.jsp");
			 
		 }
		%>
</body>
</html>