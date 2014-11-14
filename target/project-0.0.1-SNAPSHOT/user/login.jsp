<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Sign inn to PTD</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbar.jsp"></jsp:include>
		<h1>Sign inn to PTD</h1>
		<% 
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user != null) {
				pageContext.setAttribute("user", user);
		%>
			<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
    			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
		<%
		} else {
		%>
		<p>Hello! <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a></p>
		<%
		}
		%>
		
	</body>
</html>
<%-- //[END all] --%>
