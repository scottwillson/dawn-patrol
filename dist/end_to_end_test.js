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

function getResultsCount() {
  return request.get('http://' + appHost + '/results.json').then(function (response) {
    return JSON.parse(response).count;
  });
}

describe('end to end system', function () {
  before(function () {
    return request.del('http://' + appHost + '/results.json');
  });

  it('should echo Rails API requests', function () {
    return expect(getResultsCount()).to.eventually.equal(0).then(function () {
      return request.get('http://0.0.0.0:4000/events/0/results.json');
    }).then(function () {
      return retry(function () {
        return expect(getResultsCount()).to.eventually.equal(1);
      });
    });
  });
});