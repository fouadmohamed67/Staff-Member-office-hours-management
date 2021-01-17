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
		 if(null == session.getAttribute("id"))
		 	{
				response.sendRedirect("login.jsp");
			}
		 else 
		   {
			 String id_oh=request.getParameter("idOH");
		 	 int id_oh_int =Integer.parseInt(id_oh);


					 String id_metting=request.getParameter("id");
				 	 int id_int_metting =Integer.parseInt(id_metting);
				 	 String id_sec=request.getParameter("id_sec");
				 	 int id_int_sec =Integer.parseInt(id_sec);
				     System.out.println(id_oh_int);
				 	 
				 	
				 	Connection conn=do_conn(); 
				    String query="update office_hours set  busy=? where  id=?  ";
					 PreparedStatement preparedStmt = conn.prepareStatement(query);
				    preparedStmt.setInt(1,0);
			        preparedStmt.setInt(2,id_oh_int);
			         
			        preparedStmt.execute();
			        
			        conn=do_conn(); 
			          int Fid=0,Sid=0,ID=0; java.sql.Timestamp S=null,E=null;  String se=(String)session.getAttribute("id"); String Sname="",Tname="",Semail="",Temail="",typeF="",typeS="";
			          ID= Integer.parseInt(se);
			          System.out.println(ID);
			                    PreparedStatement prStmt=conn.prepareStatement("select * from metting where id=?");
			          prStmt.setInt(1,id_int_metting);
			          ResultSet Rs = prStmt.executeQuery(); 
			          if(Rs.next())
			          {
			            Fid=Rs.getInt("id_f_person");
			            Sid=Rs.getInt("id_S_person");
			            S=Rs.getTimestamp("startIN");
			            E=Rs.getTimestamp("endIN");
			          }
			          PreparedStatement pr=conn.prepareStatement("select * from user where id=?");
			           pr.setInt(1,Fid);
			            ResultSet RS = pr.executeQuery(); 
			            if(RS.next())
			            {
			              Sname=RS.getString("name");
			              Semail=RS.getString("email");
			              typeS=RS.getString("type");
			            }
			              PreparedStatement Stmt=conn.prepareStatement("select * from user where id=?");
			              Stmt.setInt(1,Sid);
			              ResultSet rs = Stmt.executeQuery(); 
			              if(rs.next())
			              {
			                Tname=rs.getString("name");
			                Temail=rs.getString("email");
			                typeF=rs.getString("type");
			              }
			              SendEmail Se=new SendEmail();
			          if(Fid==ID)
			          {
			            String msgg="Dear " +typeF+" : "+ Tname+ " , \n\n"+typeS+" : "+ Sname + " cancelled a slot From " + S + " To " +E + " .";
			            String s="Cancelling Meetings.";
			            
			            Se.send(Temail, msgg, s);
			            
			          }
			          else if(Sid==ID)
			          {
			            String msgg="Dear " + typeS +" : "+Sname+ " , \n\n"+typeF+" : "+ Tname + " cancelled a slot From " + S + " To " +E + " .";
			            String s="Cancelling Meetings.";
			            
			            Se.send(Semail, msgg, s);
			          }
			        
			            conn=do_conn(); 
				        query="delete from metting where id=? ";
					    preparedStmt = conn.prepareStatement(query);
					    preparedStmt.setInt(1,id_int_metting); 
				        preparedStmt.execute();
				        response.sendRedirect("my_mettings.jsp");
			        
			 	
		   }
		
		
		%>
</body>
</html>