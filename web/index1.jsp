<!DOCTYPE html>
<title>Provider "Flower"</title>

<style>
    /*html, body {

        height: 100%;
        margin: 0;
        padding: 0;
    }

    #map_canvas {
        width: 1024px;
        height: 768px;
        margin: auto;
    }


    .ui-autocomplete {
        background-color: white;
        width: 300px;
        border: 1px solid #cfcfcf;
        list-style-type: none;
        padding-left: 0px;
    }*/
</style>


<head>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&libraries=geometry"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/selectlocation.css"/>


    <script type="text/javascript">
        function initialize() {   //Определение карты
            array_provider_location = new Array(
                    {
                        "providerlocationlat": "50.45095993",
                        providerlocationlng: "30.52259982",
                        "providertitle": "Main office"
                    },
                    {
                        "providerlocationlat": "50.4282552",
                        providerlocationlng: "30.4529175",
                        "providertitle": "Solomenka office"
                    },
                    {
                        "providerlocationlat": "50.4535873",
                        providerlocationlng: "30.601521",
                        "providertitle": "Darnitsa office"
                    },
                    {
                        "providerlocationlat": "50.397944",
                        providerlocationlng: "30.634579",
                        "providertitle": "Pozniaki office"
                    },
                    {
                        "providerlocationlat": "50.526944",
                        providerlocationlng: "30.492778",
                        "providertitle": "Obolon office"
                    }
            );





            var latlng = new google.maps.LatLng(50.4501, 30.5234);
            var options = {
                zoom: 11,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            map = new google.maps.Map(document.getElementById("map_canvas"), options);
            geocoder = new google.maps.Geocoder();//Определение геокодера
            usermarker = new google.maps.Marker({ //определение маркера
                map: map,
                draggable: true
            });


            var indexprovider;
            for (indexprovider = 0; indexprovider < array_provider_location.length; indexprovider++) {
                if (indexprovider == 0) {
                    var centerLatLng = new google.maps.LatLng(array_provider_location[indexprovider].providerlocationlat, array_provider_location[indexprovider].providerlocationlng);
                    var providermarker = new google.maps.Marker({
                        map: map,
                        position: centerLatLng,
                        title: array_provider_location[indexprovider].providertitle
                    });
                    providermarker.setIcon('img/flower.png');
                } else {
                    var markerLatLng = new google.maps.LatLng(array_provider_location[indexprovider].providerlocationlat, array_provider_location[indexprovider].providerlocationlng);
                    var providermarker = new google.maps.Marker({
                        map: map,
                        position: markerLatLng,
                        title: array_provider_location[indexprovider].providertitle
                    });
                    providermarker.setIcon('img/marker_blue.png');
                }

            }





        }

        $(document).ready(function () {

            initialize();

            $(function () {
                /*function codeAddress() {
                 var address = document.getElementById('address').value;
                 geocoder.geocode({'address': address}, function (results, status) {
                 if (status == google.maps.GeocoderStatus.OK) {
                 map.setCenter(results[0].geometry.location);
                 usermarker.position(results[0].geometry.location);
                 } else {
                 alert('Your address is not found');
                 //alert('Geocode was not successful for the following reason: ' + status);
                 }
                 });
                 }*/

                google.maps.event.addListener(usermarker, 'drag', function () {
                    geocoder.geocode({'latLng': usermarker.getPosition()}, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results[0]) {
                                /*$('#address').val(results[0].formatted_address);
                                 $('#latitude').val(marker.getPosition().lat());
                                 $('#longitude').val(marker.getPosition().lng());*/
                                $('#address').val(results[0].formatted_address);
                                //alert(results[0].formatted_address);
                            }
                        }
                    });
                });

                google.maps.event.addListener(map, 'click', function (event) {
                    //placeMarker(event.latLng);
                    usermarker.setPosition(event.latLng);
                    geocoder.geocode({'latLng': usermarker.getPosition()}, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results[0]) {
                                $('#address').val(results[0].formatted_address);
                            }
                        }
                    });
                });

                $("#address").autocomplete({
                    //Определяем значение для адреса при геокодировании
                    source: function (request, response) {
                        geocoder.geocode({'address': request.term}, function (results, status) {
                            response($.map(results, function (item) {
                                return {
                                    label: item.formatted_address,
                                    value: item.formatted_address,
                                    latitude: item.geometry.location.lat(),
                                    longitude: item.geometry.location.lng()
                                }
                            }));
                        })
                    },
                    //Выполняется при выборе конкретного адреса
                    select: function (event, ui) {
                        //$("#latitude").val(ui.item.latitude);
                        //$("#longitude").val(ui.item.longitude);
                        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
                        usermarker.setPosition(location);
                        map.setCenter(location);
                    }
                });


                //End FuncReady
            });

            //Добавляем слушателя события обратного геокодирования для маркера при его перемещении


        });

        function codeAddress() {
            var address = document.getElementById('address').value;
            geocoder.geocode({'address': address}, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);
                    usermarker.setPosition(results[0].geometry.location);
                    //map.setZoom(11);
                    usermarker.setMap(map);
                } else {
                    alert('Your address is not found');
                    //alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>
</head>
<body>
<div id="panel">
    <label>Your Disired Location is:</label>
    <input id="address" type="text" value="Kiev">
    <input type="button" value="Find" onclick="codeAddress()">
</div>

<div id="map_canvas"></div>


</body>
</html>




