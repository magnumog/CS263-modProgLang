<%-- //[START all] --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<title>Welcome to your personal training diary</title>
	<jsp:include page="/csslink.jsp"></jsp:include>
	
</head>
<body> 
	<jsp:include page="/navbars/navbar.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 col-lg-12">
		<%
		if(null != session.getAttribute("twitter")){
		%>		
		    <form action="/post" method="post">
		    	<h3 name="title">I am using a new training diary </h3><br>
				<h3 name="link">http://notional-buffer-748.appspot.com</h3>
		        <textarea cols="80" rows="2" name="text" placeholder="and add additional text if you want!" ></textarea>
		        <input type="submit" name="post" value="Tweet!"/>
	
		    </form>
		    <a class="btn btn-primary" href="/logout">logout</a>
		 <%
		}else{
		 %>
		 <h3>Sign in with your Twitter account to tweet!</h3>
		 <a class="btn btn-primary" href="/signin">Sign in!</a>

		  <%} %>
		</div>
	</div>
</div>

</body>
</html>
<%-- //[END all] --%>