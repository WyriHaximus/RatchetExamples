<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style type="text/css">
            html {
                height: 100%
            }
            body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            #google_map_canvas {
                height: 100%;
            }
        </style>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true"></script>
        
        {{ wamp.init() }}
        {{ _view.fetch('script') }}
        
    </head>
    <body>
        <div id="google_map_canvas" style="height: 100%; width: 100%;"></div>
        <script>
            var mapOptions = {
                center: new google.maps.LatLng(52.376857, 4.904022),
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("google_map_canvas"), mapOptions);
            
            setTimeout(function() {
                var pushMapFunc = function(latLng) {
                    data = {
                        zoom: map.getZoom(),
                        lat: latLng.lat(),
                        lng: latLng.lng(),
                        mapTypeId: map.getMapTypeId()
                    };
                    cakeWamp.publish('ratchetExamples.googleMap.channel.{{- channelId -}}', data);
                };

                google.maps.event.addListener(map, 'zoom_changed', function() {
                    pushMapFunc(map.getCenter());
                });

                google.maps.event.addListener(map, 'dragend', function() {
                    pushMapFunc(map.getCenter());
                    console.log(event);
                });
                
                google.maps.event.addListener(map, 'maptypeid_changed', function() {
                    pushMapFunc(map.getCenter());
                });
                
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function(position) {
                        pushMapFunc(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
                        map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
                    });
                }
            }, 2000);
        </script>
        
        {{ _view.fetch('scriptBottom') }}
    </body>
</html>