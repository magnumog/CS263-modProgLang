<html>
	<head>
		<title>New forum post</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>New forum post</h1>
		<form action="/discussionenqueue" method="post">
				<textarea name="topic" placeholder="topic" rows="3" cols="60"></textarea>
				<textarea name="post" placeholder="Discuss" rows="3" cols="60"></textarea>
			<input type="submit" value="Post new discussion">
		</form>
	</body>
</html>