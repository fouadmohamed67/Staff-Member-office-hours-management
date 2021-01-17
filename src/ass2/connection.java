package ass2;

 
 
import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class connection {
	public java.sql.Connection get_connection() throws ClassNotFoundException, SQLException
	{
 		Class.forName("com.mysql.jdbc.Driver"); 
		java.sql.Connection conn = null; 
		 String url="jdbc:mysql://localhost:1234/projectWeb";
		 conn= DriverManager.getConnection(url,"root","1234"); 
		 
		 return conn;
	}

}