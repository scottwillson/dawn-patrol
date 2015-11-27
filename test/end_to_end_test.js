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
    console.log(`getResultsCount ${JSON.parse(response).count}`);
    return JSON.parse(response).count;
  });
}

function randomEventId() {
  if (config.has('endToEndTest.eventId')) {
    return config.get('endToEndTest.eventId');
  }
  else {
    return Math.round(Math.random() * 10000);
  }
}

function requestResultsJSON(eventId) {
  return request.get(`http://${railsAppHost}/events/${eventId}/results.json`);
}

describe('end to end system', function() {
  before(function() {
    return request.del('http://' + appHost + '/results.json');
  });

  it('should store, forward, and cache Rails API requests', function() {
    this.timeout(10000);

    var eventId = randomEventId();
    return expect(getResultsCount()).to.eventually.equal(0)
      .then(function() {
        return retry(function () {
          return requestResultsJSON(eventId).then(
            function(response) {
              var json = JSON.parse(response);
              console.log(`first GET ${json}`);
              expect(json.length).to.equal(3);
              expect(json[0]).to.contain.any.keys('event_id');
              return expect(getResultsCount()).to.eventually.equal(3);
            }
          );
        }, { interval: 100, timeout: 10000 });
      })
      .then(function() {
        return retry(function () {
          return requestResultsJSON(eventId).then(
            function(response) {
              var json = JSON.parse(response);
              console.log(`cached GET ${json}`);
              expect(json.length).to.equal(3);
              expect(json[0]).to.contain.any.keys('event_id');
              return expect(getResultsCount()).to.eventually.equal(3);
            }
          );
        }, { interval: 100, timeout: 10000 });
    });
  });
});
