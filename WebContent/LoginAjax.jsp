<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@  include file = "fun.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Got You</title>
</head>
<body>

	<%
	 PrintWriter write = response.getWriter();
	 Connection c=do_conn();
	 String email = request.getParameter("email");
	 PreparedStatement pr=null;
	 String query="SELECT * FROM user WHERE email=?";
	 pr = (PreparedStatement) c.prepareStatement(query);
	 pr.setString(1,email);
	 ResultSet rs=pr.executeQuery();
	 if(rs.first()){
		 write.print(true);
	 }
	 else{
		 write.print(false);
	 }
		
	%>

</body>
</html>