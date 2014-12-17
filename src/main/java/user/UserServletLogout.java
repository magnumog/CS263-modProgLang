package user;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class UserServletLogout extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
		synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
		
		if(user != null) {
			synCache.delete(user.getUserId()+"workout");
			synCache.delete(user.getUserId()+"message");
			synCache.delete(user.getUserId()+"yourDiscussion");
			resp.sendRedirect(userService.createLogoutURL(req.getRequestURI()));
		}
		resp.sendRedirect("/index.jsp");
	}

}
