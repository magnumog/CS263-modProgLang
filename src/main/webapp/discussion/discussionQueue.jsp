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
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbar.jsp"></jsp:include>
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
					String StringUser = discussionTask.getProperty("User").toString();
					String topic = discussionTask.getProperty("Topic").toString();
					String post = discussionTask.getProperty("Post").toString();
					String date = discussionTask.getProperty("Date").toString();
					%>
					<%-- CANT SEEM TO GET THE NICKNAME FROM USER --%>
					<p>Hi, ${fn:escapeXml(user.nickname)} your topic was <%= topic %> and your post was <%= post %>. Your discussion post was posted on <%= date %></p>
					<%
				}
			} 
		%>
	</body>
</html>
<%-- //[END all] --%>