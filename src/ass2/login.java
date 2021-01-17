package ass2;


import java.io.File;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.sun.jdi.connect.spi.Connection;

 
@WebServlet("/logincheck")
public class login extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		String email=request.getParameter("email");
		String pass=request.getParameter("pass");
		 
		 functions f=new functions();
		try {
			 String id= f.validate_login(email, pass);
			 PrintWriter out = response.getWriter();
			  
			 if(id.equals("0"))
			 {
			        // out.print(false);
			        response.sendRedirect(request.getContextPath() + "/login.jsp");
			      //  System.out.println("HERE");
			       
			 }
			 else
			 {
				    HttpSession session=request.getSession();  
			        session.setAttribute("id",id); 
				    String type=f.get_type(email);
				    session.setAttribute("type",type);
				    
			        if(type.equals("student"))
			         {
			        	 response.sendRedirect(request.getContextPath() + "/homeStudent.jsp");
			         }
			         else
			         {
			        	 response.sendRedirect(request.getContextPath() + "/homeTA.jsp");
			         }
				   
				    
			 }
		}
		catch(Exception e)
		{
			System.out.print(e); 
		}


	}
}