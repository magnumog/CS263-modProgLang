<%-- //[START all] --%>
<%@page contentType="text/html; charset=utf-8" %>
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<jsp:include page="/csslink.jsp"></jsp:include>
		<title>Workout session added</title>	
	</head>
	<body>
	<jsp:include page="/navbars/navbar.jsp"></jsp:include>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String workout = request.getParameter("workout");
		if(user == null) {
	%>
		<p>Cannot add your workout because you are not <a href="/sign">Signed in</a></p>
	<%
		} else {
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 			Key key = KeyFactory.createKey("Workout",workout);
			Query query = new Query("Workout",key);
			List<Entity> workoutData = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
			if(workoutData.isEmpty()) {
			%>
				<p>Data has not been added to datastore but it will be done shortly</p>
			<%
			} else {
				Entity workoutTask = workoutData.get(workoutData.size()-1);
				String date = workoutTask.getProperty("DateOfWorkout").toString();
				//String workout = workoutTask.getProperty("WorkoutDetails").toString();
				String sets = workoutTask.getProperty("WorkoutSets").toString();
				String weather = workoutTask.getProperty("Weather").toString();
				String comments = workoutTask.getProperty("Comments").toString();
				%>
				<%-- fix so if comments and weather is empty show other message --%>
				<p>Hi Knut ${fn:escapeXml(user.nickname)} your registered workout was: <%= workout %> the number of sets was: <%= sets %> and you did this on <%= date %>
				the weather conditions during your workout was <%= weather %> and your comments <%= comments %></p>
				<%
			}
		}
	%>
	
	</body>
</html>

<%-- //[END all] --%>