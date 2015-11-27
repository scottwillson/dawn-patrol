'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var config = require('config');
var expect = chai.expect;
var fs = require('fs');
var nock = require('nock');

chai.use(chaiAsPromised);

describe('echoServer', function() {
  var echoServer;

  before(function() {
    echoServer = require('../src/echo_server').echoServer;
    return echoServer;
  });

  describe('line event', function() {
    var apiServer;

    before(function() {
      fs.closeSync(fs.openSync(config.get('echoServer.webServerLogFilePath'), 'a'));
      apiServer = nock('http://0.0.0.0:3000').get('/events/0/results.json').reply(200);
      return apiServer;
    });

    it('echoes Rails API requests from nginx log to app', function() {
      return echoServer.emit('line', '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "-"');
    });

    after(function() {
      return apiServer.done();
    });
  });

  describe('#isDawnPatrolRequest', function() {
    it('recognizes user agent from log line', function() {
      var line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "-"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(false);

      line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(false);

      line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "dawn-patrol"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(true);
    });
  });

  describe('#eventId', function() {
    it('finds event ID in log line', function() {
      var line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/19/results.json HTTP/1.1" 200 5013 "-" "dawn-patrol"';
      expect(echoServer.eventId(line)).to.eq('19');

      line = '[echo] url: 173.164.122.113 - - [07/Aug/2015:17:05:07 -0700] "GET /events/7476/results.json HTTP/1.1" 302 109 "-" "-"';
      expect(echoServer.eventId(line)).to.eq('7476');
    });
  });
});
