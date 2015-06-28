'use strict';

process.env.NODE_ENV = 'test';

var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var expect = chai.expect;
var httpRequest = require('request-promise');

chai.use(chaiAsPromised);

function deleteResults() {
  return httpRequest({ uri: 'http://0.0.0.0:3000/results.json', method: 'DELETE' });
}

function resultsCount() {
  return httpRequest('http://0.0.0.0:3000/results.json').then(function(response) {
    return JSON.parse(response).count;
  });
}

describe('end to end system', function() {
  before(deleteResults);

  it('should echo Rails API requests', function() {
    return expect(resultsCount()).to.eventually.equal(0)
      .then(httpRequest('http://0.0.0.0:4000/events/0/results.json'))
      .then(function() {
        return expect(resultsCount()).to.eventually.equal(1);
      });
  });
});
