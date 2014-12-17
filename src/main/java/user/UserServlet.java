package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

/**
 * The Class UserServlet.
 */
public class UserServlet extends HttpServlet {
	
	/**
	 * doGet - user signs inn to application
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 * @throws ServletException
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
//		resp.setContentType("text/html");
//		resp.getWriter().println("Sign into PTD using your google account");
		
		if(user == null) {
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		} 
		//else {
//			resp.sendRedirect(userService.createLogoutURL(req.getRequestURI()));
//		}
		resp.sendRedirect("/index.jsp");
	}

}
