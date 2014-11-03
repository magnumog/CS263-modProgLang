<%-- //[START all] --%>
<html>
	<head>
		<title>Workout</title>
		<link type="text/css" rel="stylesheet" href="/main"> 
	</head>
	<body>
		<h1>Add workout</h1>
		<form action="/sign" method="post">
			<div><textarea name="workout" name="workout" rows="9" cols="60"></textarea></div>
			<div><textarea name="sets" name="sets" rows="3" cols="60"></textarea></div>
			<div><textarea name="weather" name="weather" rows="3" cols="60"></textarea></div>
			<div><textarea name="comments" name="comments" rows="3" cols="60"></textarea></div>
			<input type="submit" value="post exercise">
		</form>
	</body>
</html>




<%-- //[END all] --%>