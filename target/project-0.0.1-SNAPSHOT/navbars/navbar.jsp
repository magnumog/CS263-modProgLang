<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
%>
<html>
<head>
	<jsp:include page="/js/script.jsp"></jsp:include>
</head>
<body>
<%
	if (user == null) {
%>
		<div class="navbar navbar-default">
			<div class="navbar-collapse collapse navbar-responsive-collapse">
				<ul class="nav navbar-nav">
					<li><a href="/">Home</a></li>
					<%-- <li><a href="/user/login.jsp">Sign in</a></li>--%>
					<li><a href="/sign">Sign in</a></li>
				</ul>
			</div>
		</div>
<%-- To run local the jsp file need to be running --%>

<%
	} else {
%>

<div class="navbar navbar-default">
	<div class="navbar-header">
 		<a class="navbar-brand" href="/">Home</a>
  	</div>
  	<div class="navbar-collapse collapse navbar-responsive-collapse">
    	<ul class="nav navbar-nav">
			<%--<li><a href="/user/login.jsp">Sign out</a></li>--%>
   			<li><a href="/signOut">Sign out</a></li>
      		<li class="dropdown">
        		<a href="/workout/workout.jsp" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Workout <b class="caret"></b></a>
        		<ul class="dropdown-menu">
          			<li><a href="/workout/workout.jsp">Add Exercise</a></li>
          			<li><a href="/workout/workoutSessions.jsp">View sessions</a></li>
        		</ul>
      		</li>
      		<li class="dropdown">
      			<a href="/discussion/discussion.jsp" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Discussion <b class="caret"></b></a>
   				<ul class="dropdown-menu">
   					<li><a href="/discussion/discussion.jsp">Discussions</a>
					<li><a href="/discussion/newForumPost.jsp">New post</a></li>
					<li><a href="/discussion/yourDiscussionPosts.jsp">Your posts</a></li>
				</ul>
			</li>
			<li class="dropdown">
      			<a href="/message/message.jsp" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Messages <b class="caret"></b></a>
   				<ul class="dropdown-menu">
   					<li><a href="/message/message.jsp">Messages</a></li>
					<li><a href="/message/sendMessage.jsp">Send new message</a></li>
				</ul>
			</li>
			<li class="dropdown">
      			<a href="/map/map.jsp" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Map <b class="caret"></b></a>
   				<ul class="dropdown-menu">
   					<li><a href="/map/map.jsp">Find close workouts</a></li>
					<li><a href="/map/newSession.jsp">Setup session</a></li>
				</ul>
			</li>
			<li><a href="/twitter/SignInTwitter.jsp">Twitter</a></li>
   		</ul>
  </div>
</div>
<%
	}
%>
</body>
</html>
