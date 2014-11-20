<%-- //[START all] --%>
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
		<jsp:include page="/navbars/messagenav.jsp"></jsp:include>
		<h1>Your messages</h1>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if(user != null) {
				Filter filter = new FilterPredicate("ToUser", FilterOperator.EQUAL, user.getNickname());
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				//FOR FUTURE
				//Query query = new Query("Message").addSort("DateSendt",Query.SortDirection.DESCENDING).setFilter(filter).addSort("MessageRead",Query.SortDirection.DESCENDING);
				Query query = new Query("Message").addSort("DateSendt",Query.SortDirection.DESCENDING).setFilter(filter);
				List<Entity> entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
				if(entity.isEmpty()) {
		%>
					<p>You have no messages</p>
		<%
				} else {
		%>			<div class="centertable">
					<table>
						<tr>
							<td>Topic</td>
							<td>Message</td>
							<td>From user</td>
							<td>Date sendt</td>
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
				<p>You need to sign inn to see your messages</p>
		<%
			}
		%>
	</body>
</html>
<%-- //[END all] --%>