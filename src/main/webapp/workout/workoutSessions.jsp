<%-- //[START ALL] --%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="java.util.List"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>
<%@page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<title>Your 31 latest workouts</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
				<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
			synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
			List<Entity> entity;
			entity = (List<Entity>) synCache.get(user.getUserId());
			if(entity==null) {
				System.out.println("Nothing in memcahce");
				Filter filter = new FilterPredicate("User",FilterOperator.EQUAL,user.getUserId());
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Query query = new Query("Workout").addSort("DateOfWorkout",Query.SortDirection.DESCENDING).setFilter(filter);
				entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
				synCache.put(user.getUserId(), entity);
			}
			if(entity.isEmpty()) {
		%>
				<p>You have not posted any wokout sessions yet</p>
		<%
			} else {
		%>
				<h1>Your last 31 training sessions</h1>
				<table>
					<tr>
						<td><h2>Date</h2></td>
						<td><h2>Workout Session</h2></td>
						<td><h2>Sets</h2></td>
						<td><h2>Weather</h2></td>
						<td><h2>Comments</h2></td>
						<td><h2>File</h2></td>
					</tr>
		<%
					for(Entity ent : entity) {
		%>
						<tr>
							<td><%=ent.getProperty("DateOfWorkout").toString() %></td>
							<td><%=ent.getProperty("WorkoutDetails").toString() %></td>
							<td><%=ent.getProperty("WorkoutSets").toString() %></td>
							<td><%=ent.getProperty("Weather").toString() %></td>
							<td><%=ent.getProperty("Comments").toString() %></td>
		<%
							if(ent.getProperty("file")!=null) {
		%>
								<td><a href=/serve?blob-key=<%=ent.getProperty("file").toString()%> target=_blank>File</a></td>
		<%						
							}
		%>
						</tr>
		<%
					}
		%>
				</table>
		<%	
			}
		%>
		
		
	</body>
</html>

<%-- //[END ALL] --%>