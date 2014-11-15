
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user != null) {
%>
		<div class="nav">
			<a href="/discussion/newForumPost.jsp">New post</a>
			<a href="/discussion/yourDiscussionPosts.jsp">Your posts</a>
		</div>
<%
	}
%>