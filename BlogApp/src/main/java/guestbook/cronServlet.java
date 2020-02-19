package guestbook;

import java.io.IOException;
import java.util.*;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class cronServlet extends HttpServlet {
	private static final Logger _logger = Logger.getLogger(cronServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		//String login = req.getParameter("login");
		String to = "hurdkenan@gmail.com";
		String from = "tpnanek.com";
		String host ="localhost";
		
		Properties properties = System.getProperties();
		properties.setProperty("mail.smtp.host", host);
		Session session = Session.getDefaultInstance(properties);
		try {
			_logger.info("Cron Job has been executed");
			//Put your logic here
			//BEGIN
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject("cron");
			message.setText("Is it working?");
			
			Transport.send(message);
			System.out.println("message sent");
			//END
		}
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
			ex.printStackTrace();
		}
	}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}