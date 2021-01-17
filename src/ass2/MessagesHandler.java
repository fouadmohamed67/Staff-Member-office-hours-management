package ass2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import ass2.connection;

/**
 * Servlet implementation class MessagesHandler
 */
@WebServlet("/MessagesHandler")
public class MessagesHandler extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message=request.getParameter("msg");
		String To=request.getParameter("To");
		String toID="";
		String From= (String) request.getSession().getAttribute("id");
		 
		connection conn=new connection();
		try {
			Connection c=conn.get_connection();
			PreparedStatement pr=null;
			String query="SELECT * FROM user WHERE email=?";
			  pr = (PreparedStatement) c.prepareStatement(query);
			  pr.setString(1,To);
			  ResultSet rs=pr.executeQuery();
			  
				 while(rs.next())
				 {
					 toID=rs.getString("id");
				 }
				 
			
	        pr=(PreparedStatement) c.prepareStatement("INSERT INTO message(from_id,to_id,date_send,content) VALUES (?,?,?,?)");
	        pr.setInt(1,Integer.parseInt(From));
	        pr.setInt(2,Integer.parseInt(toID));
	        pr.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
	        pr.setString(4, message);
	        pr.execute();
	        
	        HttpSession session=request.getSession();  
	        String type=(String)session.getAttribute("type");
	        PreparedStatement prStmt=(PreparedStatement) c.prepareStatement("select * from user where id=?");
			prStmt.setInt(1,Integer.parseInt(From));
			ResultSet Rs = prStmt.executeQuery();
			String SName="";
			if(Rs.next())
			{
				SName=Rs.getString("name");
				
			}
			
	        String ms="You have new message from "+SName;
	        String subject="Messages";
	        SendEmail se=new SendEmail();
	        se.send(To, ms, subject);
	        	 response.sendRedirect(request.getContextPath() + "/chat_send.jsp?id-from="+From+"&id-to="+toID);
	         
	         
	        
	        		
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
