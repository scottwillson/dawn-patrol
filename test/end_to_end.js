'use strict';

var expect = require('chai').expect;
var request = require('sync-request');

if (typeof process.env.TARGET_HOST === 'undefined') {
  var host = '0.0.0.0:8001';
}
else {
  var host = process.env.TARGET_HOST;
}

var res = request('GET', 'http://' + host + '/event_results/0.json');
var body = res.getBody().toString();
expect(body).to.be.a('string');
expect(body).to.eq('OK');
