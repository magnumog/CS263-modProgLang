package map;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * The Class WorkoutInfo.
 */
public class WorkoutInfo extends HttpServlet {
	
	/** 
	 * doPost - posts the info of a workoutsession on to be stored later in the queue.
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		HttpSession session = req.getSession();
		session.setAttribute("WorkoutTopic",req.getParameter("name"));
		session.setAttribute("WorkoutDetails",req.getParameter("details"));
		session.setAttribute("Date",req.getParameter("date"));
		session.setAttribute("Time",req.getParameter("time"));
		resp.sendRedirect("/map/location.jsp");
	}

}
