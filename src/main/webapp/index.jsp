<%-- //[START all] --%>

<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Welcome to your personal training diary</title>
		<link type="text/css" rel="stylesheet" href="/main.css">
	</head>
	<body>
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
				<a href="/login.jsp">Sign in</a>
			<% 
				} else {
			%>
				<%-- <a href="/signOut">Sign out</a> --%>
				<a href="/login.jsp">Sign out</a>
			<% 
				}
			%>				
				<a href="/workout.html">Add exercise</a>
				<a href="/workoutsessions">View sessions</a>
				<a href="/discussion.jsp">Discussion</a>
			</p>			
		</div>
		<% 	
			if(user != null) {
				pageContext.setAttribute("user",user);
		%>
		<h1>Hi ${fn:escapeXml(user.nickname)} Welcome to your personal training diary known as PTD</h1>
		<%
			} else {
		%>
		<h1>Welcome to your personal training diary please sign in to start using it</h1>
		<h2>You need a google account to start using the diary</h2>
		<%
			}
		%>
	
	</body>

</html>
<%-- //[END all] --%>