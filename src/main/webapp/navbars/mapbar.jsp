<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user!= null) {
%>
		<a href="/map/addWorkout.jsp">Setup workout session</a>
<% 
	}
%>
<%-- //[END all] --%>