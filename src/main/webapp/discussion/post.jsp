<%-- //[START all] --%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<title>Discuss topic</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<%-- //[START User] --%>
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String topic = request.getParameter("Topic");
		if(user!= null) {
%>
			<%-- //[START Datastore] --%>
<%
			Filter filter = new FilterPredicate("Topic",FilterOperator.EQUAL,topic);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("Discussion").addSort("Date",Query.SortDirection.ASCENDING).setFilter(filter);
			List<Entity> entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100));
%>			
			<h1><%=topic%></h1>
<%
			if(entity.isEmpty()) {
%>
				<p>Nothing have been discussed</p>
<%
			} else {
%>
				<table>
<%
					for(Entity ent : entity) {
%>
						<tr>
							<td></td>
							<td><%=ent.getProperty("Post")%><br></td>
							<td></td>
						</tr>
<%
					}
%>
				</table>
				<form action="/discussionenqueue" method="post">
					<input name="topic" placeholder="topic" hidden="true" value="<%=topic%>">
					<br>
					<textarea name="post" placeholder="Discuss" rows="3" cols="60"></textarea>
					<br>
					<input class="btn btn-primary" type="submit" value="Post new discussion">
				</form>				
<%
			}
		}

%>
		<%-- //[END Datastore] --%>
		<%-- //[END User] --%>
	</body>
</html>
<%-- //[END all] --%>