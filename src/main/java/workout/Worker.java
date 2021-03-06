package workout;

import javax.servlet.ServletException;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Level;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * The Class Worker.
 */
public class Worker extends HttpServlet {
	
	/**
	 * doPost - posts all the information from the queue to the datastore workout
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String userString = req.getParameter("user");
		String date = req.getParameter("date");
		String workout = req.getParameter("workout");
		String sets = req.getParameter("sets");
		String weatherConditions = req.getParameter("weather");
		String workoutComments = req.getParameter("comments");
		String file = req.getParameter("file");
		Date dateEntered = new Date();
		
//		Key workoutKey = KeyFactory.createKey("Workout", user.getUserId());
		Entity workoutEntity = new Entity("Workout");
		workoutEntity.setProperty("User", userString);
		workoutEntity.setProperty("DateEntered",dateEntered);
		workoutEntity.setProperty("DateOfWorkout", date);
		workoutEntity.setProperty("WorkoutDetails", workout);
		workoutEntity.setProperty("WorkoutSets", sets);
		workoutEntity.setProperty("Weather", weatherConditions);
		workoutEntity.setProperty("Comments", workoutComments);
		workoutEntity.setProperty("file", file);
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		datastore.put(workoutEntity);
		
//		MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
//		synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
//		synCache.delete(user.getUserId()+"workout");
				
	}

}
