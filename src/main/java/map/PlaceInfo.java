package map;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.files.dev.Session;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;


/**
 * The Class PlaceInfo.
 */
public class PlaceInfo extends HttpServlet {
	
	/**
	 * doPost - Posts the entity from the location and info into place datastore
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
		synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
		synCache.delete(user.getUserId()+"map");
		
		String workoutAdr = req.getParameter("address");
		String lat = req.getParameter("lat");
		String lng = req.getParameter("lng");
		String userString = user.getUserId().toString();
//		String userString = "Shot";
		
		if(user!=null) {
			HttpSession session = req.getSession();
			Queue queue = QueueFactory.getDefaultQueue();
			queue.add(withUrl("/mapworker").param("Topic", session.getAttribute("WorkoutTopic").toString()).param("Info", session.getAttribute("WorkoutDetails").toString()).param("Date",session.getAttribute("Date").toString()).param("Adress", workoutAdr)
					.param("Latitude", lat).param("Longtitude", lng).param("User", userString).param("Time", session.getAttribute("Time").toString()));
			resp.sendRedirect("/map/map.jsp");
			
		} else {
			resp.sendRedirect("/error.jsp");
		}
		
		
	}
}
