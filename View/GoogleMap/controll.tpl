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
                center: new google.maps.LatLng(-34.397, 150.644),
                zoom: 8,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("google_map_canvas"), mapOptions);
            
            setTimeout(function() {
                var pushMapFunc = function() {
                    data = {
                        zoom: map.getZoom(),
                        lat: map.getCenter().lat(),
                        lng: map.getCenter().lng(),
                        mapTypeId: map.getMapTypeId()
                    };
                    cakeWamp.publish('ratchetExamples.googleMap.channel.{{- channelId -}}', data);
                };

                google.maps.event.addListener(map, 'zoom_changed', function() {
                    pushMapFunc();
                });

                google.maps.event.addListener(map, 'dragend', function() {
                    pushMapFunc();
                });
                
                google.maps.event.addListener(map, 'maptypeid_changed', function() {
                    pushMapFunc();
                });
            }, 2000);
        </script>
    </body>
</html>