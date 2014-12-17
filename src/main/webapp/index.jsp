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
%>
<%
		//Thanks to Hans-Olav for helping me with the this code
		//Config the twitter restAPI
		ConfigurationBuilder builder = new ConfigurationBuilder();
		//Didnt get it to work using the keys from my twitter application but works fine when
		//use friends application keys
		builder.setOAuthAccessToken("310273362-huWbROL2e1JbIFtV5nLalXF7VNFqh45MxY2i7lIN");
		builder.setOAuthAccessTokenSecret("cIkzguvKzFSY2HqVvI46JbeF4Pmt7mXxYlKDLavXL3WUg");
		builder.setOAuthConsumerKey("vh4vHyTPlYJniTtJMJLAKNwWx");
		builder.setOAuthConsumerSecret("UgG2KDFoiPUQsnFiGLO5dAdzeO7YZaVuq4zvcQHPy4iAulyIP9");
		Configuration configuration = builder.build();
		TwitterFactory tf = new TwitterFactory(configuration);
		Twitter twitter = tf.getInstance();
		
		//Query
		Query query = new Query("CS263Diary");
		QueryResult result = null;
		try {
			result = twitter.search(query);
		} catch (TwitterException e) {
			e.printStackTrace();
		}
		//list of tweets
		List<Status> tweetList = result.getTweets();
		if(!tweetList.isEmpty()){
			for (Status status : tweetList){
        		pageContext.setAttribute("twitterUser","@" + status.getUser().getScreenName());
        		pageContext.setAttribute("twitterText",status.getText());
		%>
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-lg-10">
					<div class="jumbotron twitter">
						<h3>${fn:escapeXml(twitterUser)}</h3>
						<p>${fn:escapeXml(twitterText)}</p>
					</div>
				</div>
			</div>
		</div>
<%	
	}
}
%>
	</body>

</html>
<%-- //[END all] --%>