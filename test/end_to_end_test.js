'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var config = require('config');
var request = require('request-promise');
var retry = require('trytryagain');

chai.use(chaiAsPromised);
var expect = chai.expect;

var appHost = config.get('endToEndTest.appHost');
var railsAppHost = config.get('endToEndTest.railsAppHost');

function getResultsCount() {
  return request.get('http://' + appHost + '/results.json').then(function(response) {
    return JSON.parse(response).count;
  });
}

function eventId() {
  if (config.has('endToEndTest.eventId')) {
    return config.get('endToEndTest.eventId');
  }
  else {
    return Math.round(Math.random() * 10000);
  }
}

describe('end to end system', function() {
  before(function() {
    return request.del('http://' + appHost + '/results.json');
  });

  it('should echo Rails API requests', function() {
    this.timeout(5000);
    return expect(getResultsCount()).to.eventually.equal(0)
    .then(function() { return request.get(`http://${railsAppHost}/events/${eventId()}/results.json`); })
    .then(function() {
      return retry(function () {
        return expect(getResultsCount()).to.eventually.equal(1);
      }, { interval: 100, timeout: 10000 });
    });
  });
});
