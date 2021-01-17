<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.lang.ClassNotFoundException" %>
<%	
	
session.invalidate(); 
response.sendRedirect("login.jsp");

	

%>