<html>
	<head>
		<title>Workout</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Add workout</h1>
		<form action="/enqueue" method="post">
				<input type="date" name="date">
				<textarea name="workout" placeholder="Training session" rows="9" cols="60"></textarea>
				<textarea name="sets" placeholder="Number of sets completed" rows="3" cols="60"></textarea>
				<textarea name="weather" placeholder="Weather conditions" rows="3" cols="60"></textarea>
				<textarea name="comments" placeholder="Comments" rows="3" cols="60"></textarea>
			<input type="submit" value="submit workout">
		</form>
	</body>
</html>