package ass2;
 
import java.io.BufferedReader;
import java.io.File;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
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

import org.json.JSONObject;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.sun.jdi.connect.spi.Connection;
@WebServlet("/registeration")
public class registeration extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String type=request.getParameter("type");
		String cap=request.getParameter("g-recaptcha-response");
		  
		
		
		try {
	        String url = "https://www.google.com/recaptcha/api/siteverify",
	                params = "secret=" + "6LeiiiQaAAAAAKx2c4m1hRCk4sUteAF2ZBE2RUDt" + "&response=" + cap;

	        HttpURLConnection http = (HttpURLConnection) new URL(url).openConnection();
	        http.setDoOutput(true);
	        http.setRequestMethod("POST");
	        http.setRequestProperty("Content-Type",
	                "application/x-www-form-urlencoded; charset=UTF-8");
	        OutputStream out = http.getOutputStream();
	        out.write(params.getBytes("UTF-8"));
	        out.flush();
	        out.close();

	        InputStream res = http.getInputStream();
	        BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));

	        StringBuilder sb = new StringBuilder();
	        int cp;
	        while ((cp = rd.read()) != -1) {
	            sb.append((char) cp);
	        } 
	        boolean isFound = sb.indexOf("true") !=-1? true: false; 
	        res.close();
	        if(isFound)
	        {
	        	 Random rnd = new Random();
			      int number = rnd.nextInt(999999); 
				  String pass= String.format("%06d", number); 
				  SendEmail SE =new SendEmail();
				  String Mess="Dear "+name+" , "+"\n\n"+"Your Password is  ("+ pass+" ).";
				  String Sub="Password for your account";
				  SE.send( email, Mess, Sub);
				  try
					{
						 
					   functions f=new functions();
					   String id=  f.add_new_user(name, email, pass, type);
					   if(!id.equals(null))
					   	{
						    
						   response.sendRedirect(request.getContextPath() + "/login.jsp");
					       
					   	 } 
						 else
						 {
							 response.sendRedirect(request.getContextPath() + "/register.jsp");
						     
						 }
					}
					catch(Exception e)
						{
					    System.out.print(e); 
 
						}

	        }
	        else
	        {
	        	 HttpSession session=request.getSession();  
			        session.setAttribute("err_cap","err");
			        response.sendRedirect(request.getContextPath() + "/register.jsp");
	        }

	   
	         
	    } catch (Exception e) {
	       
	    }
		
		 
		     
			  

	}
	 
}
