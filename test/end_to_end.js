'use strict';

var expect = require('chai').expect;
var request = require('sync-request');

if (typeof process.env.END_TO_END_HOST === 'undefined') {
  var host = '0.0.0.0:3000';
}
else {
  var host = process.env.END_TO_END_HOST;
}

var res = request('GET', 'http://' + host + '/event_results/0.json');
var body = res.getBody().toString();
expect(body).to.be.a('string');
