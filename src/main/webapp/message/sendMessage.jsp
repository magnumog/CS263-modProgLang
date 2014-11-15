<%-- //[START all] --%>
<html>
	<head>
		<title>Send message to other users</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Send message to other users</h1>
		<form action="/messageenqueue" method="post">
			<input type="text" placeholder="Username" name="ToUser">
			<textarea name="Message" placeholder="Message" rows="3" cols="60"></textarea>
			<input type="submit" value="Send message">
		</form>
	</body>
</html>
<%-- //[END all] --%>