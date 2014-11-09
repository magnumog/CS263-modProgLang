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
		<div class="header">
			<p>
				<a href="/sign">Sign inn</a>
				<a href="/workout.html">Add exercise</a>
				<a href="/discussion.jsp">Discussion</a>
			</p>			
		</div>
		<% 	
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user != null) {
				pageContext.setAttribute("user",user);
		%>
		<h1>Hi ${fn:escapeXml(user.nickname)} Welcome to your personal training diary known as PTD</h1>
		<%
			} else {
		%>
		<h1>Welcome to your personal training diary please sign in to start using it</h1>
		<%
			}
		%>
	
	</body>

</html>
<%-- //[END all] --%>