<%-- //[START all] --%>

<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Welcome to your personal training diary</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
	<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();		
	%>
	<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<% 	
			if(user != null) {
				pageContext.setAttribute("user",user);
		%>
		<h1>Hi ${fn:escapeXml(user.nickname)} Welcome to your personal training diary</h1>
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