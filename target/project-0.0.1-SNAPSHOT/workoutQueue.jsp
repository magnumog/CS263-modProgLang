<%-- //[START all] --%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@page import="com.google.appengine.api.datastore.Key"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/main.css"/>
		<title>Workout session added</title>	
	</head>
	<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		if(user == null) {
	%>
		<p>Cannot add your workout because you are not <a href="/sign">Signed in</a></p>
	<%
		} else {
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Key key = KeyFactory.createKey("workout",user.getUserId());
			Query query = new Query("workout",key);
			List<Entity> workoutData = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
			if(workoutData.isEmpty()) {
			%>
				<p>Data has not been added to datastore but it will be done shortly</p>
			<%
			} else {
				Entity workoutTask = workoutData.get(workoutData.size()-1);
				String date = workoutTask.getProperty("date").toString();
				String workout = workoutTask.getProperty("workout").toString();
				String sets = workoutTask.getProperty("sets").toString();
				String weather = workoutTask.getProperty("weather").toString();
				String comments = workoutTask.getProperty("comments").toString();
				%>
				<p>Your workout was: <%= workout %></p>
				<%
			}
		}
	%>
	
	</body>
</html>

<%-- //[END all] --%>