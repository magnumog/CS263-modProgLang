<%-- //[START all] --%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<title>Discussion forum</title>
<!-- 		<link type="text/css" rel="stylesheet" href="/main.css"> -->
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Discussion forum for your personal training diary</h1>
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		List<Entity> entity;		
		if(user!=null) {
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("Discussion").addSort("Date",Query.SortDirection.DESCENDING);
			entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(1000));
			if(entity.isEmpty()) {
%>	
				<p>There are no discussions posted</p>
<%
			} else {
%>
				<table>
					<tr>
						<td>Discussions</td>
					</tr>
<%
					for(Entity ent : entity) {
%>
						<tr>
							<td><a href="/discussion/post.jsp?Topic=<%=ent.getProperty("Topic")%>"><%=ent.getProperty("Topic")%></a></td>
						</tr>
<%
					}
%>
				</table>
<%			
			}
		}
%>
	</body>
</html>
<%-- //[END all] --%>