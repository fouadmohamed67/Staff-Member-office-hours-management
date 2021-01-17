<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
 
  
 <%@ page import="java.util.*" %>
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
     <div class="card-header">TA of an subject</div>
    
 
    <%
            String to= (String) request.getSession().getAttribute("id");
            int To=Integer.parseInt(to);
            Connection con=do_conn();
          
            int rs= 0;
            
             
            PreparedStatement  pr=con.prepareStatement("select user.name , user.email , message.id, message.from_id, message.to_id ,message.date_send, message.content from message INNER JOIN user where message.to_id=? and user.id=message.from_id ORDER BY date_send DESC");
            pr.setInt(1,To);
             
            ResultSet  rs1=pr.executeQuery();
           
            %>
                  <table class="table table-dark">
                                <tr>
                                    <th>message</th>
                                    <th>from</th>
                                    <th>date</th>
                                    <th>action</th>
                                </tr>
            <%
            Set<String> my_set= new HashSet<String>();
            while (rs1.next()){
             if(my_set.contains(rs1.getString("email")))
             {
              continue;
             }
             else
             {
              my_set.add(rs1.getString("email"));
                  
             }
              
                    %>
                          
                                
                                <tr>
                                    <td><%out.print(rs1.getString("content"));  %></td>
                                    <td> <%out.print(rs1.getString("email"));  %></td>
                                    <td><%out.print(rs1.getTimestamp("date_send"));  %> </td>
                                     <td><a class="btn btn-light" href="chat_send.jsp?id-from=<%out.print(rs1.getInt("from_id"));%>&id-to=<%out.print(rs1.getInt("to_id"));%>">mesaage him</a>  </td>
                                    
                                </tr>
                                <%}%>
                            </table>
                            
   <% }%>

</body>
</html>