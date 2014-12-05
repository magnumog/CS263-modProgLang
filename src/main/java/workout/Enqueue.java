package workout;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class Enqueue extends HttpServlet {
	private BlobstoreService blob = BlobstoreServiceFactory.getBlobstoreService();
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		//blobstore
		Map<String, BlobKey> blobMap = blob.getUploadedBlobs(req);
		BlobKey blobKey = blobMap.get("file");
		
		String date = req.getParameter("date");
		String workout = req.getParameter("workout");
		String sets = req.getParameter("sets");
		String weatherConditions = req.getParameter("weather");
		String commentsToWorkout = req.getParameter("comments");
		String file = blobKey.getKeyString();
		
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/worker").param("user", user.getUserId()).param("date", date).param("workout", workout).param("sets", sets).param("weather",weatherConditions).param("comments", commentsToWorkout).param("file", file));
		
		resp.sendRedirect("/workout/workoutQueue.jsp?workout="+workout);
	}

}