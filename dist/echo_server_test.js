'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var echoServer = require('./echo_server').echoServer;
var nock = require('nock');

chai.use(chaiAsPromised);

describe('echoServer', function () {
  var apiServer;

  before(function () {
    apiServer = nock('http://0.0.0.0:3000').get('/events/0/results.json').reply(200);
    return apiServer;
  });

  it('echoes Rails API requests from nginx log to app', function () {
    return echoServer.emit('line', '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "-"');
  });

  after(function () {
    return apiServer.done();
  });
});