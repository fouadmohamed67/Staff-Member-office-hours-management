package ass2;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SendEmail {
	
	
	public static void sendEmail(Session session, String toEmail, String subject, String body){
		try
	    {
	      MimeMessage msg = new MimeMessage(session);
	      //set message headers
	      msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      msg.addHeader("format", "flowed");
	      msg.addHeader("Content-Transfer-Encoding", "8bit");

	      msg.setFrom(new InternetAddress("samaanadaeman@gmail.com", "Staff Member office hours management"));

	      msg.setSubject(subject, "UTF-8");

	      msg.setText(body, "UTF-8");

	      msg.setSentDate(new Date());

	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
	      System.out.println("Message is ready");
    	  Transport.send(msg);  

	      System.out.println("EMail Sent Successfully!!");
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
	}
		public void send( String Email , String Mess , String Subject)
		{
			final String fromEmail = "samaanadaeman@gmail.com"; //requires valid gmail id
			final String password = "NESR1_eman"; // correct password for gmail id
			final String toEmail = Email;// can be any email id 
			
			System.out.println("TLSEmail Start");
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
			props.put("mail.smtp.port", "587"); //TLS Port
			props.put("mail.smtp.auth", "true"); //enable authentication
			props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			
		            //create Authenticator object to pass in Session.getInstance argument
			Authenticator auth = new Authenticator() {
				//override the getPasswordAuthentication method
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
			};
			String S=Mess; 
			Session session = Session.getInstance(props, auth);
			sendEmail(session, toEmail,Subject,S);
		}

	/*public static void main(String[] args) {
			//SendEmail SE= new SendEmail();
			 
			//SE.send("Menna", "12345", "menna12345678910mohamed@gmail.com","HIII ");		
		
		 java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
		//Timestamp date = null ;
		System.out.println(sqlDate);
		}*/

}
