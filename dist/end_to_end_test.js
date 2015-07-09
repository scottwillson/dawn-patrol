'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var config = require('config');
var fs = require('fs');
var request = require('request-promise');
var retry = require('trytryagain');

chai.use(chaiAsPromised);
var expect = chai.expect;

var appHost = config.get('endToEndTest.appHost');

function getResultsCount() {
  return request.get('http://' + appHost + '/results.json').then(function (response) {
    return JSON.parse(response).count;
  });
}

describe('end to end system', function () {
  before(function () {
    fs.closeSync(fs.openSync(config.get('echoServer.webServerLogFilePath'), 'a'));
    return request.del('http://' + appHost + '/results.json');
  });

  it('should echo Rails API requests', function () {
    this.timeout(3000);
    return expect(getResultsCount()).to.eventually.equal(0).then(function () {
      return request.get('http://0.0.0.0:4000/events/' + Math.round(Math.random() * 10000) + '/results.json');
    }).then(function () {
      return retry(function () {
        return expect(getResultsCount()).to.eventually.equal(1);
      }, { interval: 100, timeout: 30000 });
    });
  });
});