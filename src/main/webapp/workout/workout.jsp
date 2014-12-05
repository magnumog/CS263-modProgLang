<%@page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%
	BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
<html>
	<head>
		<title>Workout</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Add workout</h1>
		<form action="<%= blobstoreService.createUploadUrl("/enqueue")%>" method="post" enctype="multipart/form-data">
				<input type="date" name="date">
				<br>
				<textarea name="workout" placeholder="Training session" rows="9" cols="60"></textarea>
				<br>
				<textarea name="sets" placeholder="Number of sets completed" rows="3" cols="60"></textarea>
				<br>
				<textarea name="weather" placeholder="Weather conditions" rows="3" cols="60"></textarea>
				<br>
				<textarea name="comments" placeholder="Comments" rows="3" cols="60"></textarea>
				<br>
				<input type="file" name="file">
			<input type="submit" value="submit workout">
		</form>
	</body>
</html>