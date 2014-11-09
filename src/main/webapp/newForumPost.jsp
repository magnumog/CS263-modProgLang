<%-- //[START all] --%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<html>
	<head>
		<title>New forum post</title>
		<link type="text/css" rel="stylesheet" href="/main.css">
	</head>
	<body>
	<h1>New forum post</h1>
		<form action="/newPost" method="post">
			<input type="text" name="head">
			<textarea name="yourPost" rows="3" cols="60"></textarea>
			<input type="submit" value="Post new discussion">
		</form>
	</body>

</html>

<%-- //[END all] --%>