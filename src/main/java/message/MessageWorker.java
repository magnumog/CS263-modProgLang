package message;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

// TODO: Auto-generated Javadoc
/**
 * The Class MessageWorker.
 */
public class MessageWorker extends HttpServlet {
	
	/**
	 * doPost - Posts all message information to the message datastore
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
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
		//this is not working
//		messageEntity.setProperty("FromUserId", user.getUserId().toString());
		messageEntity.setProperty("DateSendt", date);
		//Try to implement where user can tell if message is read or not
		messageEntity.setProperty("MessageRead", false);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(messageEntity);
		
//		MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
//		synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
//		synCache.delete(user.getUserId()+"message");
	}

}
