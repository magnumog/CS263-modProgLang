package map;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WorkoutInfo extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		HttpSession session = req.getSession();
		session.setAttribute("WorkoutTopic",req.getParameter("name"));
		session.setAttribute("WorkoutDetails",req.getParameter("details"));
		session.setAttribute("Date",req.getParameter("time"));
		resp.sendRedirect("/map/location.jsp");
	}

}
