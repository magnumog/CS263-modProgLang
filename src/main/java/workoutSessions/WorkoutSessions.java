package workoutSessions;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class WorkoutSessions extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		resp.setContentType("text/html");
		PrintWriter out = resp.getWriter();
		Filter filter = new FilterPredicate("User",FilterOperator.EQUAL,user.getUserId());
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Workout").addSort("DateOfWorkout",Query.SortDirection.DESCENDING).setFilter(filter);
		List<Entity> entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
		out.println("<html>");

		//Header
		out.println("<head>");
		out.println("<title>Your training sessions</title>");
		out.println("<link type=\"text/css\" rel=\"stylehseet\" href=\"/main.css\"");
		out.println("</head>");
		
		//body
		out.println("<body>");
		out.println("<h1>Your registered training sessions</h1>");
		if(entity.isEmpty()) {
			out.println("<p>You have not added anything yet</p>");
		} else {
			out.println("<table>");
			out.println("<tr>");
			out.println("<td>" + "Date" + "</td>");
			out.println("<td>" + "Workout session" + "</td>");
			out.println("<td>" + "Sets" + "</td>");
			out.println("<td>" + "Weather" + "</td>");
			out.println("<td>" + "Comments" + "</td>");
			out.println("</tr>");
			for(Entity ent : entity) {
				String date = ent.getProperty("DateOfWorkout").toString();
				String session = ent.getProperty("WorkoutDetails").toString();
				String sets = ent.getProperty("WorkoutSets").toString();
				String weather = ent.getProperty("Weather").toString();
				String comments = ent.getProperty("Comments").toString();
				
				out.println("<tr>");
				out.println("<td>" + date + "</td>");
				out.println("<td>" + session + "</td>");
				out.println("<td>" + sets + "</td>");
				out.println("<td>" + weather + "</td>");
				out.println("<td>" + comments + "</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		}
		out.println("</body>");
		
		out.println("</html>");	
	}

}
