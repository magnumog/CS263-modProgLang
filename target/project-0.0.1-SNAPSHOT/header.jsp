<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<body>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
%>

<div class="header">
		<p>
		<%
			if(user == null) {
		%>
			<a href="/sign">Sign in</a>
		<% 
			} else {
		%>
			<a href="/signOut">Sign out</a>
		<% 
			}
		%>				
			<a href="/workout.html">Add exercise</a>
			<a href="/discussion.jsp">Discussion</a>
		</p>			
</div>
	</body>
</html>