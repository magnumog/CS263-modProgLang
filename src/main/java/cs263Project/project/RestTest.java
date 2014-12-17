package cs263Project.project;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 * The Class RestTest.
 */
@Path("/jerseyws")
public class RestTest {

    /**
     * Test method.
     *
     * @return the string
     */
    @GET
    @Path("/test")
    public String testMethod() {
        return "this is a test";
    }
}

