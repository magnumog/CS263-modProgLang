<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if(user != null) {
%>
		<div class="nav">		
			<a href="/message/sendMessage.jsp">Send new message</a>
		</div>
<%
	}
%>
<%-- //[END all] --%>