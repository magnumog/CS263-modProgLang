package message;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		String toUser = req.getParameter("ToUser");
		String topic = req.getParameter("Topic");
		String post = req.getParameter("Message");
		
		Queue queue = QueueFactory.getDefaultQueue();
		queue.add(withUrl("/messageworker").param("ToUser", toUser).param("Topic", topic).param("Post", post).param("FromUser", user.getNickname()));
		resp.sendRedirect("/message/messageQueue.jsp");
	}
}
