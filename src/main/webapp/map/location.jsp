<%-- //[START all] --%>
<html>
	<head>
		<title>Location of workout</title>
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
		<div class="map">
			<h1>Choose your wokout location</h1>
			<div id="map_canvas" style="width:100%;height:400px"></div>
			<div id="marker_data">
		        <form id="createWorkoutSession" action="/placeinfo" method="post" accept-charset="utf-8">
		            <input type="text" name="address" id="address" class="form-control">
		            <input type="hidden" name="lat" id="lat" class="form-control">
		            <input type="hidden" name="lng" id="lng" class="form-control">
		            <button type="submit" class="btn btn-primary">Save</button>
		        </form>
		    </div>
		</div>
	</body>
</html>
<%-- //[END all] --%>