package discussion;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
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

/**
 * The Class DiscussionWorker.
 */
public class DiscussionWorker extends HttpServlet {
	
	/**
	 * doPost - Posts the discussion posts into datastore
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String userString = req.getParameter("user");
		String topic = req.getParameter("topic");
		String post = req.getParameter("post");
		Date date = new Date();
		
		Entity discussionEntity = new Entity("Discussion");
		discussionEntity.setProperty("User", userString);
		discussionEntity.setProperty("Topic", topic);
		discussionEntity.setProperty("Post",post);
		discussionEntity.setProperty("Date", date);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(discussionEntity);		
	}
}
