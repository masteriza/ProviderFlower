<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Service provider "Flower"</title>

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <style>
        .ui-autocomplete {
            background-color: white;
            width: 300px;
            border: 1px solid #cfcfcf;
            list-style-type: none;
            padding-left: 0px;
        }
    </style>


    <script type="text/javascript">

        var geocoder;
        var map;
        var marker;

        function initialize() {
//Определение карты
            var latlng = new google.maps.LatLng(56.329917, 44.009191999999985);
            var options = {
                zoom: 11,
                center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            map = new google.maps.Map(document.getElementById("map_canvas"), options);

            //Определение геокодера
            geocoder = new google.maps.Geocoder();

            marker = new google.maps.Marker({
                map: map,
                draggable: true
            });

        }

        $(document).ready(function () {

            initialize();

            $(function () {
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
                        $("#latitude").val(ui.item.latitude);
                        $("#longitude").val(ui.item.longitude);
                        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
                        marker.setPosition(location);
                        map.setCenter(location);
                    }
                });
            });

            //Добавляем слушателя события обратного геокодирования для маркера при его перемещении
            google.maps.event.addListener(marker, 'drag', function () {
                geocoder.geocode({'latLng': marker.getPosition()}, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            $('#address').val(results[0].formatted_address);
                            $('#latitude').val(marker.getPosition().lat());
                            $('#longitude').val(marker.getPosition().lng());
                        }
                    }
                });
            });

        });


    </script>
</head>
<body>
<label>Адрес для поиска: </label><input id="address" style="width:600px;" type="text"/>

<div id="map_canvas" style="width:800px; height:600px"></div>
<br/>
<label>Широта (latitude): </label><input id="latitude" type="text"/><br/>
<label>Длогота (longitude): </label><input id="longitude" type="text"/>
</body>
</html>
