process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const expect = chai.expect;
const fs = require('fs');
const nock = require('nock');

chai.use(chaiAsPromised);

describe('echoServer', () => {
  const echoServer = require('../src/echo_server').echoServer;

  describe('line event', () => {
    const apiServer = nock('http://0.0.0.0:3000').get('/events/0/results.json').reply(200);

    before(() => {
      fs.closeSync(fs.openSync(config.get('echoServer.webServerLogFilePath'), 'a'));
    });

    it('echoes Rails API requests from nginx log to app', () => {
      return echoServer.emit('line', '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "-"');
    });

    after(() => {
      return apiServer.done();
    });
  });

  describe('#isDawnPatrolRequest', () => {
    it('recognizes no user agent', () => {
      const line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "-"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(false);
    });

    it('recognizes Safari', () => {
      const line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/600.7.12 (KHTML, like Gecko) Version/8.0.7 Safari/600.7.12"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(false);
    });

    it('recognizes dawn-patrol user agent', () => {
      const line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/0/results.json HTTP/1.1" 200 5013 "-" "dawn-patrol"';
      expect(echoServer.isDawnPatrolRequest(line)).to.eq(true);
    });
  });

  describe('#eventId', () => {
    it('finds event ID in log line', () => {
      const line = '::ffff:127.0.0.1 - - [25/Jun/2015:20:21:21 +0000] "GET /events/19/results.json HTTP/1.1" 200 5013 "-" "dawn-patrol"';
      expect(echoServer.eventId(line)).to.eq('19');
    });

    it('finds event ID in log line', () => {
      const line = '[echo] url: 173.164.122.113 - - [07/Aug/2015:17:05:07 -0700] "GET /events/7476/results.json HTTP/1.1" 302 109 "-" "-"';
      expect(echoServer.eventId(line)).to.eq('7476');
    });
  });
});
