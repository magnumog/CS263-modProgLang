package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class UserServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		resp.setContentType("text/html");
		resp.getWriter().println("Sign into PTD using your google account");
		
		if(user == null) {
			resp.getWriter().println("<a href='" + userService.createLoginURL(req.getRequestURI())+ "'> Sign in </a>");
		} else {
			resp.getWriter().println("<a href='" + userService.createLogoutURL(req.getRequestURI())+ "'> Sign out </a>");
		}
	}

}
