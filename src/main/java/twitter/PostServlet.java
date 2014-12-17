package twitter;

import twitter4j.Twitter;
import twitter4j.TwitterException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * The Class PostServlet.
 */
public class PostServlet extends HttpServlet {
    
    /**
     * doPost - Post a new tweet on twitter.
     *
     * @param request the request
     * @param response the response
     * @throws ServletException the servlet exception
     * @throws IOException Signals that an I/O exception has occurred.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String text = "I am using a new training diary! #CS263Diary \n" 
        + "http://notional-buffer-748.appspot.com \n"+request.getParameter("text");
        Twitter twitter = (Twitter)request.getSession().getAttribute("twitter");
        
        try {
            twitter.updateStatus(text);
        } catch (TwitterException e) {
            throw new ServletException(e);
        }
        response.sendRedirect(request.getContextPath()+ "/");
    }
}