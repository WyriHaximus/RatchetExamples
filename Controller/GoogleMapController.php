<?php

App::uses('Security', 'Utility');

class GoogleMapController extends AppController {
    
    public $helpers = array(
        'Ratchet.Wamp',
    );
    
    public function index() {
        $this->set('channelId', Security::generateAuthKey());
    }
    
    public function control($channelId) {
        $this->layout = 'ajax';
        $this->set('channelId', $channelId);
    }
    
}