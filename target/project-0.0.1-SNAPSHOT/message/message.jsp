<%-- //[START all] --%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.appengine.api.memcache.ErrorHandlers"%>
<%@page import="com.google.appengine.api.memcache.MemcacheServiceFactory"%>
<%@page import="com.google.appengine.api.memcache.MemcacheService"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<html>
	<head>
		<title>Messages</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Your messages</h1>
		<%-- //[START User] --%>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user != null) {
		%>
		<%-- //[START Memcahce] --%>
		<%
				MemcacheService synCache = MemcacheServiceFactory.getMemcacheService();
				synCache.setErrorHandler(ErrorHandlers.getConsistentLogAndContinue(Level.INFO));
				List<Entity> entity;
				entity = (List<Entity>)synCache.get(user.getUserId()+"message");
				if(entity==null || entity.isEmpty()) {
		%>
		<%-- //[START Datastore] --%>
		<%
					Filter filter = new FilterPredicate("ToUser", FilterOperator.EQUAL, user.getNickname());
					DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
					Query query = new Query("Message").addSort("DateSendt",Query.SortDirection.DESCENDING).setFilter(filter);
					entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
					synCache.put(user.getUserId()+"message", entity);
			
				}
				if(entity.isEmpty()) {
		%>
					<p>You have no messages</p>
		<%
				} else {
		%>
					<table>
						<tr>
							<td>Topic</td>
							<td>Message</td>
							<td>From user</td>
							<td>Date sendt</td>
							<td>Respond</td>
						</tr>
		<%
					for(Entity ent : entity) {
						String topic = ent.getProperty("Topic").toString();
						String message = ent.getProperty("Post").toString();
						String fromUser = ent.getProperty("FromUser").toString();
						String date = ent.getProperty("DateSendt").toString();
		%>
						<tr>
							<td><%=topic %></td>
							<td><%=message %></td>
							<td><%=fromUser %></td>
							<td><%=date %></td>
							<td><a href="/message/respondMessage.jsp?FromUser=<%=ent.getProperty("FromUser")%>&Topic=<%=topic%>&Post=<%=message%>">respond</a></td>
						</tr>
		<% 
					}
		%>
					</table>
		<%
				}
			} else {
		%>
				<p>You need to sign inn to see your messages</p>
		<%
			}
		%>
		<%-- //[END Datastore] --%>
		<%-- //[END Memcahce] --%>
		<%-- //[END User] --%>
	</body>
</html>
<%-- //[END all] --%>