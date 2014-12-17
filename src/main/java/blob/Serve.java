/**
 * @author Magnus Mogstad
 */
package blob;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

/**
 * The Class Serve.
 */
public class Serve extends HttpServlet {
	
	/** The blobstore service. */
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	
	/**
	 * doGet Blobstore - gets the file in blobstore
	 * @param HttpServletRequest req
	 * @param HttpServletRespons resp
	 * @throws IOException
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		BlobKey blobKey = new BlobKey(req.getParameter("blob-key"));
		blobstoreService.serve(blobKey, resp);
	}
}
