'use strict';

var config = require('config');
var http = require('http');
var Tail = require('always-tail2');

function log(text) {
  if (process.env.NODE_ENV !== 'test') {
    console.log('[echo] ' + text);
  }
}

var tail = new Tail(config.get('echoServer.webServerLogFilePath'));
log('tail: ' + config.get('echoServer.webServerLogFilePath'));

tail.on('line', function(data) {
  log('url: ' + data);
  http.get('http://0.0.0.0:3000/events/0/results.json', function(res) {
    log('app: ' + res.statusCode);
  }).on('error', function(e) {
    log('app error: ' + e.message);
  });
});

tail.on('error', function(error) {
  log('error: ', error);
});

module.exports.echoServer = tail;
