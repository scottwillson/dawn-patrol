'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var expect = chai.expect;
var httpRequest = require('request-promise');
var Promise = require('bluebird');

chai.use(chaiAsPromised);

// Delete all results from app server
// Make request to mock API server
// Assert DB has results

describe('end to end system', function () {
  before(function () {
    return httpRequest({ uri: 'http://0.0.0.0:3000/results.json', method: 'DELETE' });
  });
  it('should echo Rails API requests', function () {
    return httpRequest('http://0.0.0.0:3000/results.json').then(function (response) {
      return expect(JSON.parse(response).count).to.equal(0);
    }).then(httpRequest('http://0.0.0.0:4000/events/0/results.json')).then(function () {
      return httpRequest('http://0.0.0.0:3000/results.json');
    }).then(function (response) {
      return expect(JSON.parse(response).count).to.equal(1);
    });
  });
});