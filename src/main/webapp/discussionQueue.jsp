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
		<title>New discussion added</title>
		<link type="text/css" rel="stylesheet" href="/main.css"/>s
	</head>
	<body>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user==null) {
		%>
				<p>You need to be signed in to post in the discussion forum</p>
		<%
			} else {
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Query query = new Query("Discussion");
				List<Entity> discussionData = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
				if(discussionData.isEmpty()) {
				%>
					<p>Your will be added to the discussion forum shortly</p>
				<%
				} else {
					Entity discussionTask = discussionData.get(discussionData.size()-1);
					String StringUser = discussionTask.getProperty("user").toString();
					String topic = discussionTask.getProperty("topic").toString();
					String post = discussionTask.getProperty("post").toString();
					String date = discussionTask.getProperty("date").toString();
					%>
					<%-- NEEDS FIXING IT DOES NOT WORK PROPERLY --%>
					<p>Hi, '${fn:escapeXml(user.nickname)}' your topic was <%= topic %> and your post was <%= post %>. They where posted at <%= date %></p>
					<%
				}
			} 
		%>
	</body>
</html>

<%-- //[END all] --%>