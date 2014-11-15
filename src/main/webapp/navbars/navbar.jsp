<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();		
%>
	<div class="nav">
		<p>
		<%
			if(user == null) {
		%>
			<%-- To run local the jsp file need to be running --%>
			<%-- <a href="/sign">Sign in</a> --%>
			<a href="/">Home</a>
			<a href="/user/login.jsp">Sign in</a>
		<% 
			} else {
		%>
			<%-- <a href="/signOut">Sign out</a> --%>
			<a href="/">Home</a>			
			<a href="/user/login.jsp">Sign out</a>
			<a href="/workout/workout.jsp">Add exercise</a>
			<a href="/workoutsessions">View sessions</a>
			<a href="/discussion/discussion.jsp">Discussion</a>
			<a href="/message/message.jsp">Messages</a>
		<% 
			}
		%>				
		</p>			
	</div>