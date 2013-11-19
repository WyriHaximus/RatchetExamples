<?php $this->Wamp->init(); ?>

<div>
    <div class="span8" id="google_map_canvas" style="height: 400px"></div>
    <div class="span3" id="google_map_qr_code">
        <?php echo $this->Html->image('http://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=' . rawurlencode($this->Html->url(array(
            'plugin' => 'ratchet_examples',
            'controller' => 'google_map',
            'action' => 'control',
            0 => $channelId,
        ), true)) . '&choe=UTF-8', array(
			'url' => array(
				'plugin' => 'ratchet_examples',
				'controller' => 'google_map',
				'action' => 'control',
				0 => $channelId,
			)
		)); ?>
    </div>
    <div style="clear: both;"></div>
</div>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true"></script>

<script>
    var mapOptions = {
        center: new google.maps.LatLng(52.376857, 4.904022),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("google_map_canvas"), mapOptions);
    
    cakeWamp.subscribe('ratchetExamples.googleMap.channel.<?php echo $channelId; ?>', function (topic, event) {
        map.setZoom(event.zoom);
        map.setCenter(new google.maps.LatLng(event.lat, event.lng));
        map.setMapTypeId(event.mapTypeId);
    });
</script>