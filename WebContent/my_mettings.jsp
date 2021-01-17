<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" href="design.css">

</head>
<body>	
		<%@ page import="java.io.*" %>
		<%@ page import="java.sql.*" %>
		<%@ page import="java.lang.ClassNotFoundException" %>
		<%@  include file = "fun.jsp"%>
		<%@ page import="ass2.SendEmail" %>
		<%
			 if(null == session.getAttribute("id"))
			 	{
					response.sendRedirect("login.jsp");
				}
			 else 
			   {
				 
					 String type=(String)session.getAttribute("type");
					 String id=(String)session.getAttribute("id");
					 if(type.equals("TA"))
					 {
						 response.sendRedirect("homeTA.jsp");
					 }
					 else
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
								    ur meetings
								  </div>
								  <div class="card-body">
								     
								 
					 <% 
					 int id_int_user =Integer.parseInt(id); Date time=null;
		             java.sql.Date today = new java.sql.Date(new java.util.Date().getTime()); 
		            
		             Connection conn=do_conn(); int sent=0;
		             String query="select metting.id, metting.id_office_hour , metting.id_f_person ,  metting.id_S_person,metting.sent , metting.startIN ,metting.endIN , metting.date_booking ,user.name  from metting INNER JOIN user where metting.id_f_person=? and user.id=? ";
		                PreparedStatement preparedStmt = conn.prepareStatement(query);
		                  preparedStmt.setInt(1,id_int_user);
		                preparedStmt.setInt(2,id_int_user);
		                  ResultSet rs= preparedStmt.executeQuery();
		              
		              
		                  while(rs.next())
		                  {
		                    time=rs.getDate("startIN");
		                    sent=rs.getInt("sent");
		                  
		                  
		                    if(today.compareTo(time)==1 && sent != 1){
		                    
		                    int first=0, second=0; Time from=null,to=null; String SName="", SEmail="", Tname="",Temail="",Ftype="",Stype="";
		      System.out.println(today);
		      System.out.println(time);
		         try {
		           Connection con=do_conn(); 
		        
		        PreparedStatement preparedStmt1=con.prepareStatement("select * from metting where Date(startIN)=?");
		        preparedStmt1.setDate(1,today);
		        ResultSet rs1 = preparedStmt1.executeQuery();
		        
		        if(rs1.next())
		        {
		           first=rs1.getInt("id_f_person");
		           System.out.println(first);
		           second=rs1.getInt("id_S_person");
		           System.out.println(second);
		           from=rs1.getTime("startIN");
		           to=rs1.getTime("endIN");
		        }
		        PreparedStatement prStmt=con.prepareStatement("select * from user where id=?");
		        prStmt.setInt(1,first );
		        ResultSet Rs = prStmt.executeQuery();
		        if(Rs.next())
		        {
		          SName=Rs.getString("name");
		          SEmail=Rs.getString("email");
		          Stype=Rs.getString("type");
		        }
		        
		        PreparedStatement Stmt=conn.prepareStatement("select * from user where id=?");
		        Stmt.setInt(1,second );
		        ResultSet RS = Stmt.executeQuery();
		        if(RS.next())
		        {
		          Tname=RS.getString("name");
		          Temail=RS.getString("email");
		          Ftype=RS.getString("type");
		        }
		        
		        
		        String Msgg="Dear "+Stype+" : "+SName+" , \n\n"+"You have Meeting Today From  "+(from)+" To "+(to) +" With " +Ftype+" : "+ Tname+" . "  ;
		        String sub="Meetings";
		        SendEmail se=new SendEmail();
		        se.send( SEmail, Msgg, sub);
		        
		        String Msg="Dear "+Ftype+" : "+Tname+" , \n\n"+"You have Meeting Today From  "+(from)+" To "+(to) +"  With "+Stype+" : "+SName+" . ";
		      se.send(Temail, Msg, sub);
		      System.out.println("id mee "+rs.getInt("metting.id"));
		      PreparedStatement Stmt1=con.prepareStatement("update metting set sent=? where id=? ");
		      Stmt1.setInt(1,1);
		      Stmt1.setInt(2,rs.getInt("metting.id"));
		     int rs11 = Stmt1.executeUpdate();
		        break;
		        
		      } catch (  SQLException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		      } }/*--------------------------------------------------------------------------------------*/
		                  }

		                    conn=do_conn();  
				               query="select metting.id, metting.id_office_hour , metting.id_f_person ,  metting.id_S_person,metting.sent , metting.startIN ,metting.endIN , metting.date_booking ,user.name  from metting INNER JOIN user where metting.id_f_person=? and user.id=? ";
				                  preparedStmt = conn.prepareStatement(query);
				                  preparedStmt.setInt(1,id_int_user);
				                preparedStmt.setInt(2,id_int_user);
				                    rs= preparedStmt.executeQuery();
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
						    <%
					         
					 }
			  }
		%>

</body>
</html>