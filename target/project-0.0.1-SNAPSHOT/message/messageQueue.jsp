<%-- //[START all] --%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Your messages</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<%-- //[START User] --%>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user==null) {
		%>
				<p>You need to be signed inn to send a message to another user</p>
		<%		
			} else {
		%>
		<%-- //[START Datastore] --%>
		<%
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Query query = new Query("Message");
				List<Entity> messages = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
				if(messages.isEmpty()) {
		%>
					<p>Your message will be sendt shortly</p>
		<%
				} else {
					Entity message = messages.get(messages.size()-1);
					String ToUser = message.getProperty("ToUser").toString();
					String topic = message.getProperty("Topic").toString();
					String post = message.getProperty("Post").toString();
		%>
					<p>Hi, ${fn:escapeXml(user.nickname)} <br>
					you sendt a message to <%= ToUser %> with the topic <%= topic %> <br>
					you wrote <%= post %></p>
		<%
				}
			}
		%>
		<%-- //[END Datastore] --%>
		<%-- //[END User] --%>
	</body>
</html>
<%-- //[END all] --%>