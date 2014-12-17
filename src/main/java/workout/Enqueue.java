package workout;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.IOException;
import java.util.Map;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * The Class Enqueue.
 */
public class Enqueue extends HttpServlet {
	
	/** The blob. */
	private BlobstoreService blob = BlobstoreServiceFactory.getBlobstoreService();
	
	/**
	 * doPost - gets all info and passes it on to worker with queue
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		MemcacheService synCahce = MemcacheServiceFactory.getMemcacheService();
		synCahce.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
		synCahce.delete(user.getUserId()+"workout");
		
		//blobstore
		Map<String, BlobKey> blobMap = blob.getUploadedBlobs(req);
		BlobKey blobKey = blobMap.get("file");
		
		String date = req.getParameter("date");
		String workout = req.getParameter("workout");
		String sets = req.getParameter("sets");
		String weatherConditions = req.getParameter("weather");
		String commentsToWorkout = req.getParameter("comments");
		String file="";
		if(blobKey!=null) {
			file = blobKey.getKeyString();			
		}
		
		if(user!=null) {
			Queue queue = QueueFactory.getDefaultQueue();
			queue.add(withUrl("/worker").param("user", user.getUserId()).param("date", date).param("workout", workout).param("sets", sets).param("weather",weatherConditions).param("comments", commentsToWorkout).param("file", file));
			resp.sendRedirect("/");
			
		} else {
			resp.sendRedirect("/error.jsp");
		}
		
	}

}