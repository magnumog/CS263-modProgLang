package message;

import java.io.IOException;
import java.util.logging.Level;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.memcache.ErrorHandlers;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

public class MessageEnqueue extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException,ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
		synCache.setErrorHandler(ErrorHandlers.getLogAndContinue(Level.INFO));
		synCache.delete(user.getUserId()+"message");
		
		//change the thing for online
		String toUser = req.getParameter("ToUser");
		String topic = req.getParameter("Topic");
		String post = req.getParameter("Message");
		
		if(user!=null) {
			Queue queue = QueueFactory.getDefaultQueue();
			queue.add(withUrl("/messageworker").param("ToUser", toUser).param("Topic", topic).param("Post", post).param("FromUser", user.getNickname()));
			resp.sendRedirect("/");			
		} else {
			resp.sendRedirect("/error.jsp");
		}
	}
}
