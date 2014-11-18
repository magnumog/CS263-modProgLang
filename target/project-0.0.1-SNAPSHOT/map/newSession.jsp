<%-- //[START all] --%>
<html>
	<head>
		<title>New workout session</title>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
	</head>
	<body>
		<h1>Create a new workout session which other can join</h1>
		<form action="/workoutinfo" method="post">
			<input type="text" placeholder="Session name" name="name">
			<textarea placeholder="Session details" rows="3" cols="60" name="details"></textarea>
			<input type="datetime" name="time">
			<input type="submit" value="continue to set location"> 
		</form>
	</body>
</html>
<%-- //[END all] --%>