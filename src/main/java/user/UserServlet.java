package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class UserServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		
		String thisURL = req.getRequestURI();
		
		resp.setContentType("text/html");
		if(req.getUserPrincipal() != null) {
			resp.getWriter().println("<p>Hello, " + req.getUserPrincipal().getName() + "! you can <a href=\"" + userService.createLogoutURL(thisURL) + "\">Sign out</a>.</p>");
			resp.sendRedirect("/index.jsp");
		} else {
			resp.getWriter().println("<p>Please <a href=\"" +
                                     userService.createLoginURL(thisURL) +
                                     "\">sign in</a>.</p>");
		}
	}

}
