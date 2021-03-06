package workoutSessions;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * The Class WorkoutSessions.
 */
public class WorkoutSessions extends HttpServlet {

	/**
	 * doGet - Gets the data from the datastore workout and shows in in your browser
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user!=null) {
			resp.setContentType("jsp");
			List<Entity> entity;
			MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
			synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
			entity = (List<Entity>) synCache.get(user.getUserId());
			if(entity==null) {
				System.out.println("Nothing in memcahce");
				Filter filter = new FilterPredicate("User",FilterOperator.EQUAL,user.getUserId());
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Query query = new Query("Workout").addSort("DateOfWorkout",Query.SortDirection.DESCENDING).setFilter(filter);
				entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
				synCache.put(user.getUserId(),entity);
			}
			PrintWriter out = resp.getWriter();
			
			out.println("<html>");

			//Header
			out.println("<head>");
			out.println("<title>Your training sessions</title>");
			out.println("<link type=\"text/css\" rel=\"stylehseet\" href=\"/main.css\"");
			out.println("</head>");

			//body
			out.println("<body>");
//			out.println("<jsp:include page=/navbars/navbar.jsp></jsp:include>");
			out.println("<h1>Your registered training sessions</h1>");
			if(entity.isEmpty()) {
				out.println("<p>You have not added anything yet</p>");
			} else {
				out.println("<table>");
				out.println("<tr>");
				out.println("<td>" + "<h2>Date</h2>" + "</td>");
				out.println("<td>" + "<h2>Workout session</h2>" + "</td>");
				out.println("<td>" + "<h2>Sets</h2>" + "</td>");
				out.println("<td>" + "<h2>Weather</h2>" + "</td>");
				out.println("<td>" + "<h2>Comments</h2>" + "</td>");
				out.println("<td>" + "<h2>file</h2>" + "</td>");
				out.println("</tr>");
				for(Entity ent : entity) {
					String date = ent.getProperty("DateOfWorkout").toString();
					String session = ent.getProperty("WorkoutDetails").toString();
					String sets = ent.getProperty("WorkoutSets").toString();
					String weather = ent.getProperty("Weather").toString();
					String comments = ent.getProperty("Comments").toString();

					out.println("<tr>");
//					out.println("<td>" + date + "</td>");
					out.println("<td>" + session + "</td>");
					out.println("<td>" + sets + "</td>");
					out.println("<td>" + weather + "</td>");
					out.println("<td>" + comments + "</td>");
					if(ent.getProperty("file")!=null) {

						out.println("<td>" +"<a href=/serve?blob-key="+ent.getProperty("file").toString()+" target=_blank>File</a>"+"</td>");
					}
					out.println("</tr>");
				}
				out.println("</table>");
			}
			out.println("</body>");
			out.println("</html>");	
		} else {
			resp.sendRedirect("/error.jsp");
		}
	}

}
