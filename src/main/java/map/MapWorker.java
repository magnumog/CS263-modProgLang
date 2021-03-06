package map;

import java.io.IOException;
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
 * The Class MapWorker.
 */
public class MapWorker extends HttpServlet {
	
	/**
	 * doPost - posts the location and the info of a new workoutsession
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String topic = req.getParameter("Topic");
		String detail = req.getParameter("Info");
		String date = req.getParameter("Date");
		String workoutAdr = req.getParameter("Adress");
		String lat = req.getParameter("Latitude");
		String lng = req.getParameter("Longtitude");
		String userString = req.getParameter("User");
		String time = req.getParameter("Time");
		
		Entity entity = new Entity("Place");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		entity.setProperty("Topic",topic);
		entity.setProperty("Info",detail);
		entity.setProperty("Date",date);
		entity.setProperty("Adress", workoutAdr);
		entity.setProperty("Latitude", lat);
		entity.setProperty("Longtitude", lng);
		entity.setProperty("User", userString);
		entity.setProperty("Time", time);
		
		datastore.put(entity);
	}

}
