<%-- //[START all] --%>
<%@page import="java.util.List"%>
<%@page import="com.google.appengine.api.datastore.Entity"%>
<%@page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@page import="com.google.appengine.api.datastore.Query"%>
<%@page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<title>Workout sessions</title>
		<jsp:include page="/csslink.jsp"></jsp:include>
		<meta charset="utf-8">
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
		<script type="text/javascript">
            var map;
            var marker;
            var geocoder; //2a
            var initialLocation = new google.maps.LatLng(34.41396,-119.84895);
            function init() {
            	geocoder = new google.maps.Geocoder(); 
                var duckOptions = {
                    zoom: 16,
                    center: initialLocation,
                    mapTypeId: google.maps.MapTypeId.STANDARD
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), duckOptions);
                marker = new google.maps.Marker({
                    position: initialLocation, 
                    map: map
                });
                google.maps.event.addListener(map, 'click', function(event) {
                    placeMarker(event.latLng);
                });
            }
            function placeMarker(location) {
            	marker.setMap(null);
                marker = new google.maps.Marker({
                    position: location,
                    map: map
                });
                document.getElementById('lat').value=location.lat();
            	document.getElementById('lng').value=location.lng();
            	                
                geocoder.geocode( { 'latLng': location}, function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                    	console.log(results[0].formatted_address);
                    	document.getElementById('address').value=results[0].formatted_address;
                    } else {
                        alert("Geocode was not successful for the following reason: " + status);
                    }
                });
                map.setCenter(location);
            }
        </script>
	</head>
	<body onload="init()">
		<jsp:include page="/navbars/navbar.jsp"></jsp:include>
		<h1>Find a workout session marked on the map close to you</h1>
		<div id="map_canvas" style="width:80%;height:400px;padding-left:10%;padding-right:10%"></div>
		<h2>workouts</h2>
		<%-- //[START User] --%>
<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		List<Entity> entity;
		if(user!=null) {
			%>
			<%-- //[START Datastore] --%>
			<%
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("Place").addSort("Date", Query.SortDirection.DESCENDING);
			entity = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(99));
			if(entity.isEmpty()) {
%>
				<p>There are no sessions set up today</p>				
<%
			} else {
%>
				<table>
					<tr>
						<td><h3>Topic</h3></td>
						<td><h3>Info</h3></td>
						<td><h3>Adress</h3></td>
						<td><h3>Date</h3></td>
						<td><h3>Time</h3></td>
					</tr>
<%
// 					for(Entity ent : entity) {
// 						//if(ent!=null) {
// 							String topic = ent.getProperty("Topic").toString();
// 							String info = ent.getProperty("Info").toString();
// 							String adr = ent.getProperty("Adress").toString();
// 							String date = ent.getProperty("Date").toString();
// 							String time = ent.getProperty("Time").toString();		
%>

<!-- 						<tr> -->
<%-- 							<td><%=topic %></td> --%>
<%-- 							<td><%=info %></td> --%>
<%-- 							<td><%=adr %></td> --%>
<%-- 							<td><%=date %></td> --%>
<%-- 							<td><%=time %></td> --%>
<!-- 						</tr> -->
<%-- <%					 --%>
<%--  						}--%>
<%-- 					}--%>
<%-- %> --%>
				</table>
<%				
			}
		}
%>
	<%-- //[END Datastore] --%>	
	<%-- //[END User] --%>
	</body>
</html>
<%-- //[END all] --%>