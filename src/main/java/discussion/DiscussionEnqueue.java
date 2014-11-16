package discussion;

import javax.servlet.ServletException;

import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import static com.google.appengine.api.taskqueue.TaskOptions.Builder.withUrl;

public class DiscussionEnqueue extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String topic = req.getParameter("topic");
		String post = req.getParameter("post");
		
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/discussionworker").param("user", user.getUserId()).param("topic", topic).param("post", post));
		//NEED TO GET THIS WORKING IF NOT THE SAME MESSAGE WILL BE SHOWN EACH TIME
//		resp.sendRedirect("/discussionQueue.jsp?="+user.getUserId());
		resp.sendRedirect("/discussion/discussionQueue.jsp");
	}

}