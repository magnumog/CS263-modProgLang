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
		<div class="jumbotron">
 			 <h1>Hi, ${fn:escapeXml(user.nickname)} </h1>
 			 <p>Welcome to your personal training diary, here you can store workout sessions, discuss and set up a online session.</p>
		</div>
		<%
			} else {
		%>
		<div class="jumbotron">
  			<h1>Welcome</h1>
				<p>to your personal training diary please sign in to start using it</p>
				<p>You need a google account to start using the diary</p>
 
		</div>
			
		<%
			}
		%>
	
	</body>

</html>
<%-- //[END all] --%>