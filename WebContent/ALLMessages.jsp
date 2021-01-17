<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  include file = "fun.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	 if(null == session.getAttribute("id")){
			response.sendRedirect("login.jsp");
		}else{
			int from=0;
			String email="";
			String to= (String) request.getSession().getAttribute("id");
            int To=Integer.parseInt(to);
            int done=0;
            Connection con=do_conn();
            PreparedStatement pr=null;
            int rs= 0;
            ResultSet rs1=null;
            pr=con.prepareStatement("SELECT DISTINCT * FROM message WHERE to_id=?");
            pr.setInt(1,To);
            rs1=pr.executeQuery();
            while(rs1.next()){
            	from=rs1.getInt("from_id");
            	 pr=con.prepareStatement("SELECT * FROM user WHERE id=?");
                 pr.setInt(1,from);
                 rs1=pr.executeQuery();
                 while(rs1.next()){
                	 email=rs1.getString("email");%>
                	  <table border="1">
                            <tr>
                                <th>from</th>
                            </tr>
                            <tr>
                                <td><%= email %></td>
                            </tr>
                         
                        </table>
                <% }%> 
            <% }%>
		<%} %>
</body>
</html>