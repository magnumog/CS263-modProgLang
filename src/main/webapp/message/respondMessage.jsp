<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<title>Respond to message</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user!=null) {
			
		String toUser=request.getParameter("FromUser");
		String Topic=request.getParameter("Topic");
		String message=request.getParameter("Post");
%>
		<div class="jumbotron">
 			<h1>Respond to message from <%=toUser%></h1>
 			<h2>Topic <%=Topic %></h2>
 			<p><%=message %></p>
		</div>
		<form action="/messageenqueue" method="post">
			<input type="text" placeholder="Username" name="ToUser" hidden="true" value="<%=toUser%>">
			<br>
			<input type="text" placeholder="Topic" name="Topic" hidden="true" value="<%=Topic%>">
			<br>
			<textarea name="Message" placeholder="Message" rows="3" cols="60"required></textarea>
			<br>
			<input type="submit" value="Send message">
		</form>
<% 
		}
%>		
	</body>
</html>
<%-- //[END all] --%>