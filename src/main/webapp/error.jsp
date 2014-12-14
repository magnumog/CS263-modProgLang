<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<jsp:include page="/csslink.jsp"></jsp:include>
		<title>ERROR</title>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user==null) {
		%>
				<h1>Error</h1>
				<p>You have encountered an error, are you sure you are signed inn?</p>
		<%
			} else {
		%>
				<h1>Error</h1>
				<p>You have encountered a unknown problem</p>
		<%
			}
		%>
	</body>
</html>
<%-- //[END all] --%>