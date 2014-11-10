package discussion;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;

public class DiscussionWorker extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
//		String user = req.getParameter("user");
		String topic = req.getParameter("topic");
		String yourPost = req.getParameter("yourPost");
		Date date = new Date();
		
		Entity discussionEntity = new Entity("Discussions");
//		discussionEntity.setProperty("User", user);
		discussionEntity.setProperty("topic", topic);
		discussionEntity.setProperty("Post",yourPost);
		discussionEntity.setProperty("Date", date);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(discussionEntity);
	}
}
