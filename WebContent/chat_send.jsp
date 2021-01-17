
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
  <%@  include file = "fun.jsp" %>
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
    <div class="card-header">ur messages </div>
   

   <%
    String to= (String) request.getSession().getAttribute("id");
            int id_user=Integer.parseInt(to);
            
   String id=request.getParameter("id-from");
    int id_int_from =Integer.parseInt(id);
      id=request.getParameter("id-to");
    int id_int_to =Integer.parseInt(id);
    String email="";
    Connection con=do_conn();
    PreparedStatement  pr=con.prepareStatement("select   user.name,user.id , user.email ,   message.from_id, message.to_id ,message.date_send, message.content from message INNER JOIN user where ((from_id=? and to_id=?) or (from_id=? and to_id=?)) and ( user.id=from_id ) ORDER BY date_send");
             pr.setInt(1,id_int_from);//72
             pr.setInt(2,id_int_to);//46
             pr.setInt(3,id_int_to);//46
             pr.setInt(4,id_int_from);//72
             
             ResultSet  rs1=pr.executeQuery();
              
            
             while(rs1.next())
             {                  
              if(id_user == rs1.getInt("from_id")){
              %>
              <div class="from d-flex flex-row-reverse pt-3 mr-3"> 
              <span class="badge badge-light"> : you</span>
               <div class="mr-3"><% out.println(rs1.getString("content") );%></div>
              </div>
              <% 
              }
              else{
               email=rs1.getString("email");
              %>
              
              <div class="from d-flex flex-row pt-3 ml-3"> 
              <span class="badge badge-dark"><% out.println(rs1.getString("email"));%> : </span>
               <div class="ml-3"><% out.println(rs1.getString("content") );%></div>
              </div>
               
              <%
              }
             }
             %>
            
             <li class="list-group-item">
       <form action="MessagesHandler?To=<%out.print(email); %>" method="POST">
        <textarea class="form-control" placeholder="Type message.." name="msg" id="msg"></textarea>
         <button class="btn btn-success">send message</button>
       </form>
       </li>
            
             <% 
    }
  %>
</body>
</html>
