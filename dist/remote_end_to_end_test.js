'use strict';

var Promise = require('bluebird');
var http = Promise.promisifyAll(require('http'));

// Make request to mock API server
http.getAsync('http://0.0.0.0:4000/events/0/results.json').then(function (result) {
  console.log(result);
});

// TODO
// Check servers are up