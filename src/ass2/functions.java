package ass2;

 
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import com.ibm.icu.util.BytesTrie.Result;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

public class functions {

	public String add_new_user(String name,String email,String pass ,String type) throws ClassNotFoundException, SQLException
	{
	       connection c=new connection();
		   Connection conn=(Connection) c.get_connection();
		   String query="INSERT INTO user(name,email,pass,type) VALUES( ?, ?, ?, ? )";
		   java.sql.PreparedStatement preparedStmt = conn.prepareStatement(query);
		    preparedStmt.setString(1,name);
	        preparedStmt.setString(2,email);
	        preparedStmt.setString(3,pass);
	        preparedStmt.setString(4,type);
	        preparedStmt.execute();
	        
	        query="select id from user where email=?";
		  preparedStmt = conn.prepareStatement(query);
		  preparedStmt.setString(1,email);
		  ResultSet rs=preparedStmt.executeQuery();
		 
		
		  if(rs.next())
	        {
			  return rs.getString("id");
 
	        }
	        
	        return null;
		   
	}
	public String validate_login(String email ,String pass) throws ClassNotFoundException, SQLException

	{
		 
		 connection c=new connection();
		   Connection conn=  (Connection) c.get_connection();
		   String query="select * FROM user WHERE email='" + email +"' and pass ='"+ pass + "'";
		    
		   Statement st=(Statement) ((java.sql.Connection) conn).createStatement();
			ResultSet rs = st.executeQuery(query);
			 while(rs.next())
			 {
				 return rs.getString("id");
			 }
			 return "0";
			  
			  
			  
	       
	       
	}
	public String get_type(String email) throws ClassNotFoundException, SQLException
	{
		   connection c=new connection();
		   Connection conn=  (Connection) c.get_connection();
		   String query="select * FROM user WHERE email='" + email +"'";
		   Statement st=(Statement) ((java.sql.Connection) conn).createStatement();
			ResultSet rs = st.executeQuery(query);
			 while(rs.next())
			 {
				 return rs.getString("type");
			 }
		return null;
	}
}
