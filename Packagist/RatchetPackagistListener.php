<?php

App::uses('CakeEventListener', 'Event');
App::uses('Sanitize', 'Utility');

class RatchetPackagistListener implements CakeEventListener {

    private $client;
    
    public function implementedEvents() {
        return array(
            'Rachet.WampServer.construct' => 'construct',
            'Rachet.WampServer.Rpc.searchPackagist' => 'searchPackagist',
        );
    }
    
    public function construct($event) {
        $dnsResolverFactory = new React\Dns\Resolver\Factory();
        $dnsResolver = $dnsResolverFactory->createCached('8.8.8.8', $event->data['loop']);

        $factory = new React\HttpClient\Factory();
        $this->client = $factory->create($event->data['loop'], $dnsResolver);
    }

    public function searchPackagist($event) {
        $request = $this->client->request('GET', 'https://packagist.org/search.json?q=' . Sanitize::paranoid($event->data['params']['q']));

        $request->on('response', function ($response) use ($event) {
            $response->on('data', function ($data) use ($event) {
                $event->data['connection']->callResult($event->data['id'], array(
                    json_decode($data),
                ));
            });
        });
        $request->end();
    }
}