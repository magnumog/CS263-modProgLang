<%-- //[START all] --%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>
<%@page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%-- THIS KEEPS CRASHING WHEN RUNNING LOCALY BUT NOT --%> 
<%-- WHEN RUNNING ON APPSPOT --%>
<html>
	<head>
		<title>Your discussion posts</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			MemcacheService synCahce = MemcacheServiceFactory.getMemcacheService();
			synCahce.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
			List<Entity> entity;
			entity = (List<Entity>) synCahce.get(user.getUserId()+"yourDiscussion");
		%>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Discussion topics you have contributed to</h1>
		<%
		if(user!= null) {
			if(entity==null || entity.isEmpty()) {
				Filter filter = new FilterPredicate("User", FilterOperator.EQUAL, user.getUserId());
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				Query query = new Query("Discussion").addSort("Date",Query.SortDirection.DESCENDING).setFilter(filter);
				entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(31));
				synCahce.put(user.getUserId()+"yourDiscussion", entity);
			}
			if(entity.isEmpty()) {
		%>
				<p>You have not posted any discussion posts</p>
		<% } else {
		%>
				<p>Your discussion posts so far</p>
				<div class="centertable">
				<table>
				<tr>
					<td><h2>Topic</h2></td>
					<td><h2>Post</h2></td>
					<td><h2>Date Posted</h2></td>
				</tr>
		<%
				for(Entity ent : entity) {
					String date = ent.getProperty("Date").toString();
					String post = ent.getProperty("Post").toString();
					String topic = ent.getProperty("Topic").toString();
		%>
					<tr>
						<td><%=topic %></td>
						<td><%=post %></td>
						<td><%=date %></td>
					</tr>
		<%
				}
		%>
				</table>
				</div>
		<%
			}
		} else {
		%>
		<h1>You need to sign in to use this function</h1>
		<%
		}
		%>
	</body>
</html>
<%-- //[END all] --%>