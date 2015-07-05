'use strict';

process.env.NODE_ENV = 'test';

var config = require('config');
var expect = require('expect.js');
var request = require('request');

var appHost = config.get('endToEndTest.appHost');

describe('end to end system', function() {
  before(function(done) {
    request.del('http://' + appHost + '/results.json', function(error) {
      done(error);
    });
  });

  it('should echo Rails API requests', function() {
    request.get('http://' + appHost + '/results.json', function(error, response, body) {
      var resultsCount = JSON.parse(body).count;
      expect(resultsCount).to.equal(0);

      request.get('http://0.0.0.0:4000/events/0/results.json', function() {

        request.get('http://' + appHost + '/results.json', function(error2, response2, body2) {
          resultsCount = JSON.parse(body2).count;
          expect(resultsCount).eventually.to.equal(1);
        });
      });
    });
  });
});
