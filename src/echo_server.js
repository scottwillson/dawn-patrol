'use strict';

var config = require('config');
var fs = require('fs');
var http = require('http');
var Tail = require('always-tail');

function log(text) {
  if (process.env.NODE_ENV !== 'test') {
    console.log('[echo] ' + text);
  }
}

var path = config.get('echoServer.webServerLogFilePath');
var fileSize = fs.statSync(path).size;
var tail = new Tail(path, '\n', { start: fileSize });
log('tail: ' + path);

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
