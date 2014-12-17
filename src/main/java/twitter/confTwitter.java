package twitter;

import java.util.List;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.Configuration;
import twitter4j.conf.ConfigurationBuilder;

/**
 * The Class confTwitter.
 */
public class confTwitter {
	
	/** The twitter. */
	private Twitter twitter;

	/**
	 * Instantiates a new conf twitter.
	 */
	public confTwitter() {
		ConfigurationBuilder builder = new ConfigurationBuilder();
//		cb.setDebugEnabled(true)
		
		builder.setOAuthAccessToken("2933203662-24k5Fz7Y9ZUTfbVQQByOFvHoiZNlqpU5Crjhgmb");
		builder.setOAuthAccessTokenSecret("ZKivvn6fjZB1KIXMxZ3y8qv1HmexyEoAjnsJUDw8G2XVF");
		builder.setOAuthConsumerKey("igY7gB6Yj3X50IyafbEHbtMur");
		builder.setOAuthConsumerSecret("OjjD9QDqn3y1eFfSwuBqSYKv0Aj8gI5vE8LbJ8tf3vjtojoy9D");
		Configuration configuration = builder.build();
		
		TwitterFactory tf = new TwitterFactory(configuration);
		Twitter twitter = tf.getInstance();
		
	    Query query = new Query("TRONDHEIM");
	    QueryResult result;
		try {
			result = twitter.search(query);
			for (Status status : result.getTweets()) {
		        System.out.println("@" + status.getUser().getScreenName() + ":" + status.getText());
		    }
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    
		
	}
	
	/**
	 * Gets the twitter.
	 *
	 * @return the twitter
	 */
	public Twitter getTwitter(){
		return this.twitter;
	}
	
}