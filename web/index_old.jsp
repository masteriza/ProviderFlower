<!DOCTYPE html>
<title>Provider "Flower"</title>

<style>
    html, body {
        /*html, body, #map-canvas {*/
        height: 100%;
        margin: 0;
        padding: 0;
    }

    #map_canvas {
        width: 1024px;
        height: 768px;
        margin: auto;
    }

    #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
    }

    #panel, .panel {
        font-family: 'Roboto', 'sans-serif';
        line-height: 30px;
        padding-left: 10px;
    }

    #panel select, #panel input, .panel select, .panel input {
        font-size: 15px;
    }

    #panel select, .panel select {
        width: 100%;
    }

    #panel i, .panel i {
        font-size: 12px;
    }
</style>


<head>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=geometry"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        var map;
        var usermarker;
        array_provider_location = new Array(
                {
                    "providerlocationlat": "50.4501",
                    providerlocationlng: "30.5234",
                    "providertitle": "Kiev office"
                },
                {
                    "providerlocationlat": "49.9935",
                    providerlocationlng: "36.230383",
                    "providertitle": "Kharkiv office"
                },
                {
                    "providerlocationlat": "46.482526",
                    providerlocationlng: "30.7233095",
                    "providertitle": "Odessa office"
                },
                {
                    "providerlocationlat": "49.839683",
                    providerlocationlng: "24.029717",
                    "providertitle": "Lviv office"
                },
                {
                    "providerlocationlat": "48.464717",
                    providerlocationlng: "35.046183",
                    "providertitle": "Dnepropetrovsk office"
                }
        );


        $(function () {
            var UserLatLng = new google.maps.LatLng(50.4501, 30.5234);
            var mapOptions = {
                zoom: 10,
                center: UserLatLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                draggable: true
            };

            map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

            usermarker = new google.maps.Marker({
                map: map,
                draggable: true,
                position: markerLatLng

            });


            /*google.maps.event.addListener(map, 'click', function (event) {
             placeMarker(event.latLng);
             //alert(array_provider_location[0].providerlocationlat);   //Выведет "text1"
             //alert(array_provider_location[0].providerlocationlng);   //Выведет "text4"
             });*/

            google.maps.event.addListener(marker, 'drag', function () {
                alert('Fuck1');
                geocoder.geocode({'latLng': marker.getPosition()}, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            /*$('#address').val(results[0].formatted_address);
                             $('#latitude').val(marker.getPosition().lat());
                             $('#longitude').val(marker.getPosition().lng());*/
                            alert(results[0].formatted_address);
                        }
                    }
                });
            });

        });

        function initialize() {
            var indexprovider;
            for (indexprovider = 0; indexprovider < array_provider_location.length; indexprovider++) {
                if (indexprovider == 0) {
                    var centerLatLng = new google.maps.LatLng(array_provider_location[indexprovider].providerlocationlat, array_provider_location[indexprovider].providerlocationlng);
                    var providermarker = new google.maps.Marker({
                        map: map,
                        position: centerLatLng,
                        title: array_provider_location[indexprovider].providertitle
                    });
                } else {
                    var markerLatLng = new google.maps.LatLng(array_provider_location[indexprovider].providerlocationlat, array_provider_location[indexprovider].providerlocationlng);
                    var providermarker = new google.maps.Marker({
                        map: map,
                        position: markerLatLng,
                        title: array_provider_location[indexprovider].providertitle
                    });
                }
            }
            return (false);
        }

        var usermarker;
        function placeMarker(location) {
            if (usermarker) {
                usermarker.setPosition(location);
            } else {
                usermarker = new google.maps.Marker({
                    position: location,
                    draggable: true,
                    map: map
                });
            }
            //position_x = marker.getPosition().lat();
            //position_y = marker.getPosition().lng();

            var userlocation = new google.maps.LatLng(usermarker.getPosition().lat(), usermarker.getPosition().lng());
            for (indexprovider = 0; indexprovider < array_provider_location.length; indexprovider++) {
                var providerlocation = new google.maps.LatLng(array_provider_location[indexprovider].providerlocationlat, array_provider_location[indexprovider].providerlocationlng);
                var distancebetweenprovideruser = google.maps.geometry.spherical.computeDistanceBetween(userlocation, providerlocation);
                //alert(array_provider_location[indexprovider].providertitle + "   " + distancebetweenprovideruser);
            }
        }

        var geocoder = new google.maps.Geocoder();
        function codeAddress() {
            var address = document.getElementById('address').value;
            geocoder.geocode({'address': address}, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);
                    /*usermarker = new google.maps.Marker({
                     map: map,
                     draggable: true,
                     position: results[0].geometry.location
                     });*/
                    usermarker.position();
                } else {
                    alert('Your address is not found');
                    //alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }


    </script>
</head>
<body onload="initialize()">
<div id="map_canvas"></div>

<div id="panel">
    <label for="sityname">Your Disired Location is:</label>
    <input id="address" type="textbox" value="Kiev">
    <input type="button" value="Find" onclick="codeAddress()">
</div>

</body>
</html>




