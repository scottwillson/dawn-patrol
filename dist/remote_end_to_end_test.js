'use strict';

var httpRequest = require('request-promise');

// Delete all results from app server
// Make request to mock API server
// Assert DB has results

httpRequest({
  uri: 'http://0.0.0.0:3000/results.json',
  method: 'DELETE'
}).then(function () {
  return httpRequest('http://0.0.0.0:3000/results.json');
}).then(function (response) {
  var count = JSON.parse(response).count;
  if (count !== 0) {
    throw 'Expected result count to be 0, but was: ' + count;
  }
}).then(function () {
  return httpRequest('http://0.0.0.0:4000/events/0/results.json');
}).then(function () {
  return httpRequest('http://0.0.0.0:3000/results.json');
}).then(function (response) {
  var count = JSON.parse(response).count;
  if (count !== 1) {
    throw 'Expected result count to be 1, but was: ' + count;
  }
});

// TODO
// Check servers are up
// disable delete in production
// Make tests run against staging (need config and deply changes)