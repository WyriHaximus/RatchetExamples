<?php

class GoogleMapController extends AppController {
    
    public $helpers = array(
        'Ratchet.Wamp',
    );
    
    public function beforeFilter() {
        parent::beforeFilter();
        $this->Auth->allow(array(
            'index',
            'control',
        ));
    }
    
    public function index() {
        $this->set('channelId', Security::generateAuthKey());
    }
    
    public function control($channelId) {
        $this->layout = 'ajax';
        $this->set('channelId', $channelId);
    }
    
}