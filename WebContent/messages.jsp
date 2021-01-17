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
		}else{%>
	<form action="MessagesHandler" method="POST">
		<h1>Messages</h1>
		<textarea placeholder="Type message.." name="msg" id="msg"></textarea>
		<label> To: <input type="text" name="To" id="To"> </label><br>
		<button type="submit"> Send </button>
	</form>
	<%} %>
</body>
</html>