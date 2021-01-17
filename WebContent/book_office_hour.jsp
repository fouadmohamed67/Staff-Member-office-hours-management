<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<%@ page import="java.io.*" %>
	    <%@ page import="java.sql.*" %>
	    <%@ page import="java.lang.ClassNotFoundException" %>
	 	<%@  include file = "fun.jsp"%>
	 	<%@ page import ="ass2.SendEmail" %>
	 	<%
	 	 if( null != session.getAttribute("id"))
		 {	
	 		 
	 		
	 		String id_TA=request.getParameter("id_ta");
	 	 String id_user=(String)session.getAttribute("id");
	 	String id_oH=request.getParameter("id");
	 	 int id_int_user =Integer.parseInt(id_user);
	 	 int id_int_oH =Integer.parseInt(id_oH);
	 	int id_int_TA =Integer.parseInt(id_TA);
	 	 
	 		Connection conn=do_conn();
	 		System.out.print(id_TA);
		 String query="update office_hours set  busy=? where id=? ";
			 PreparedStatement preparedStmt = conn.prepareStatement(query);
		    preparedStmt.setInt(1,id_int_user);
	        preparedStmt.setInt(2,id_int_oH);
	        preparedStmt.execute();
	        
	        query="select * from office_hours where id=? ";
	        preparedStmt = conn.prepareStatement(query);
		    preparedStmt.setInt(1,id_int_oH);
		    ResultSet rs= preparedStmt.executeQuery();
		    java.sql.Timestamp start = null,end=null;
		    if(rs.next())
		    {
		    	java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
		    	query="insert into metting(id_f_person,id_S_person,startIN,endIN,date_booking,id_office_hour) values(?,?,?,?,?,?)";
		    	 preparedStmt = conn.prepareStatement(query);
		    	  preparedStmt.setInt(1,id_int_user);
		    	  preparedStmt.setInt(2,id_int_TA);
		    	  preparedStmt.setTimestamp(3, rs.getTimestamp("date_start"));
		    	  preparedStmt.setTimestamp(4, rs.getTimestamp("date_end"));
		    	  preparedStmt.setTimestamp(5, date);
		    	  preparedStmt.setInt(6,id_int_oH);

		    	  preparedStmt.execute();
		    	  start=rs.getTimestamp("date_start");
		    	  end=rs.getTimestamp("date_end");
		    	  
		    }
		    String TAName="",SName="", TEmail="", typeA="",typeS="",Semail="";
		    
		    PreparedStatement prStmt=conn.prepareStatement("select * from user where id=?");
	          prStmt.setInt(1,id_int_TA);
	          ResultSet Rs = prStmt.executeQuery(); 
	          if(Rs.next())
	          {
	            TAName=Rs.getString("name");
	            TEmail=Rs.getString("email");
	            typeA=Rs.getString("type");
	          }
	           PreparedStatement pr=conn.prepareStatement("select * from user where id=?");
	           pr.setInt(1,id_int_user);
	            ResultSet RS = pr.executeQuery(); 
	            if(RS.next())
	            {
	              SName=RS.getString("name");
	              typeS=RS.getString("type");
	              Semail=RS.getString("email");
	            }
	            String msgg="Dear " +typeA+" : "+ TAName+ " , \n\n"+ typeS+" : "+SName + " reserved a slot From " + start+ " To " +end + " .";
	            String s="Reserving Slots";
	            SendEmail Se=new SendEmail();
	            Se.send(TEmail, msgg, s);
	            String msg="Dear " +typeS+" : " + SName+ " , \n\n" +  " You reserved a slot From " + start+ " To " +end + " Successfully"+"  With " +typeA+ " : "+TAName+" . ";
	            Se.send(Semail, msg, s);
	        response.sendRedirect("officeHoursTA.jsp?id="+id_TA); 
		 }
	 	 else
	 	 {
	 		 
	 		response.sendRedirect("homeStudent.jsp");
	 	 }
	 	%>

</body>
</html>