package message;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class MessageWorker extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String toUser = req.getParameter("ToUser");
		String topic = req.getParameter("Topic");
		String post = req.getParameter("Post");
		String fromUser = req.getParameter("FromUser");
		Date date = new Date();
		
		Entity messageEntity = new Entity("Message");
		messageEntity.setProperty("ToUser", toUser);
		messageEntity.setProperty("Topic", topic);
		messageEntity.setProperty("Post", post);
		messageEntity.setProperty("FromUser", fromUser);
		messageEntity.setProperty("FromUserId", user.getUserId());
		messageEntity.setProperty("DateSendt", date);
		//Try to implement where user can tell if message is read or not
		messageEntity.setProperty("MessageRead", false);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(messageEntity);
	}

}
