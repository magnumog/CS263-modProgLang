<%-- //[START all] --%>

<%@page import="twitter4j.Status"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.TwitterException"%>
<%@page import="twitter4j.QueryResult"%>
<%@page import="twitter4j.Query"%>
<%@page import="twitter4j.Twitter"%>
<%@page import="twitter4j.conf.Configuration"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Welcome to your personal training diary</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
	</head>
	<body>
	<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();		
	%>
	<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<% 	
			if(user != null) {
				pageContext.setAttribute("user",user);
		%>
		<div class="jumbotron">
 			 <h1>Hi, ${fn:escapeXml(user.nickname)} </h1>
 			 <p>Welcome to your personal training diary, here you can store workout sessions, discuss and set up a online session.</p>
		</div>
		<%
			} else {
		%>
		<div class="jumbotron">
  			<h1>Welcome</h1>
				<p>to your personal training diary please sign in to start using it</p>
				<p>You need a google account to start using the diary</p>
 
		</div>
			<%-- <h3>Twitter</h3>--%>
		<%
			}
// 		ConfigurationBuilder builder = new ConfigurationBuilder();
// 		builder.setOAuth2AccessToken("2933203662-24k5Fz7Y9ZUTfbVQQByOFvHoiZNlqpU5Crjhgmb");
// 		builder.setOAuthAccessTokenSecret("ZKivvn6fjZB1KIXMxZ3y8qv1HmexyEoAjnsJUDw8G2XVF");
// 		builder.setOAuthConsumerKey("igY7gB6Yj3X50IyafbEHbtMur");
// 		builder.setOAuthConsumerSecret("OjjD9QDqn3y1eFfSwuBqSYKv0Aj8gI5vE8LbJ8tf3vjtojoy9D");
// 		Configuration configuration = builder.build();
		
// 		TwitterFactory twitterFactory = new TwitterFactory(configuration);
// 		Twitter twitter = twitterFactory.getInstance();
		
// 		Query query = new Query("CS263Diary");
// 		QueryResult result = null;
// 		try {
// 			result = twitter.search(query);
// 		} catch(TwitterException e) {
// 			e.printStackTrace();
// 		}
// 		List<Status> list = result.getTweets();
		
// 		if(!list.isEmpty()) {
// 			for(Status status : list) {
// 				pageContext.setAttribute("User","@" + status.getUser().getScreenName());
// 		        pageContext.setAttribute("text",status.getText());
// 			}
// 		}
		%>
<!-- 		<div class="container"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-md-10 col-lg-10"> -->
<!-- 					<div class="jumbotron twitter"> -->
<%-- 						<h3>${fn:escapeXml(User)}</h3> --%>
<%-- 						<p>${fn:escapeXml(Text)}</p> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
	</body>

</html>
<%-- //[END all] --%>