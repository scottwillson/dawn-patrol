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

log(`start: ${process.env.NODE_ENV}`);
var path = config.get('echoServer.webServerLogFilePath');
var fileSize = fs.statSync(path).size;
var tail = new Tail(path, '\n', { start: fileSize });
log('tail: ' + path);

tail.isDawnPatrolRequest = function(line) {
  return line.indexOf('dawn-patrol') > -1;
};

tail.eventId = function(line) {
  var matches = /events\/(\d+)\/results.json/g.exec(line);
  if (matches === null) {
    return null;
  } else {
    return matches[1];
  }
};

tail.echoRequest = function(eventId) {
  http.get(`http://0.0.0.0:3000/events/${eventId}/results.json`, function(res) {
    log('app: ' + res.statusCode);
  }).on('error', function(e) {
    log('app error: ' + e.message);
  });
};

tail.on('line', function(data) {
  log('url: ' + data);
  if (!this.isDawnPatrolRequest(data)) {
    var eventId = this.eventId(data);
    if (eventId !== null) {
      this.echoRequest(eventId);
    }
  }
});

tail.on('error', function(error) {
  log('error: ', error);
});

module.exports.echoServer = tail;
