<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	
	<%@ page import="java.lang.ClassNotFoundException" %>
<%! 
public Connection do_conn()
{
	Connection conn = null; 
	 String url="jdbc:mysql://localhost:1234/projectWeb";
	 

		try
		{    	Class.forName("com.mysql.jdbc.Driver"); 

		conn= DriverManager.getConnection(url,"root","1234"); 
			 

		}
		catch(Exception e)
		{
			 System.out.print(e); 
		}
	 return conn;
}
	 
 	public void update_info(int id,String name,String email,String pass )
 	{
 		try
 		{
	 			Connection conn=do_conn();
	 			 String query="update user set name=? , email=? , pass=?  where id =? ";
 	 			 PreparedStatement preparedStmt = conn.prepareStatement(query);
	 			    preparedStmt.setString(1,name);
	 		        preparedStmt.setString(2,email);
	 		        preparedStmt.setString(3,pass);
	 		       preparedStmt.setInt(4,id);
	 		      preparedStmt.execute();
 		}
 		catch(Exception e)
			{
			 System.out.print(e); 
			}
 	}
 	public boolean check_num_int_exist( int[] array,int key)
 	{
 		for(int i=0;i<array.length;i++)
 		{
 			if(array[i]==key)
 			{
 				return true;
 			}
 		}
 		return false;
 	}
	 public void send_message(String content,int id_from,int id_to )
	 {
		 try{
				Connection conn=do_conn();
				String query="INSERT INTO message(from_id,to_id,date_send,content) VALUES (?,?,?,?)";
				PreparedStatement pr=null;
				 pr=(PreparedStatement) conn.prepareStatement(query);
				    pr.setInt(1, id_from);
			        pr.setInt(2, id_to);
			        pr.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			        pr.setString(4, content);
			        pr.execute();
			}
			catch(Exception e)
				{
				 System.out.print(e);
					 
				}
	 }
	public boolean check_user_exist(String name )
	{
		try{
			String query="SELECT COUNT(*) FROM customer WHERE name='"+name+"'";
			Connection conn=do_conn();
		    Statement st=conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			  rs.next();
		     int count = rs.getInt(1);
 			if(count>0)
		    	return true;
			else
				return false;

				
		}
		catch(Exception e)
			{
			 System.out.print(e);
				return false;
			 

			}
	}
%>