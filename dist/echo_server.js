'use strict';

var Tail = require('tail').Tail;

var tail = new Tail('tmp/nginx.log');
var http = require('http');

tail.on('line', function (data) {
  console.log('[echo] url: ' + data);
  http.get('http://0.0.0.0:3000/events/0/results.json', function (res) {
    console.log('[echo] app: ' + res.statusCode);
  }).on('error', function (e) {
    console.log('[echo] app error: ' + e.message);
  });
});

tail.on('error', function (error) {
  console.log('[echo] error: ', error);
});

module.exports.echoServer = tail;