'use strict';

if (typeof process.env.TARGET_HOST === 'undefined') {
  var host = '0.0.0.0:8001';
}
else {
  var host = process.env.TARGET_HOST;
}

var loadtest = require('loadtest');
var options = {
    url: 'http://' + host + '/events/0/results.json',
    maxRequests: 1000,
    concurrency: 4
};

loadtest.loadTest(options, function(error, result) {
  if (error) {
    return console.error('Got an error: %s', error);
  }
  console.log(require('util').inspect(result));

  if (result.rps > 20) {
    return 0;
  }
  else {
    console.log('Failed. ' + result.rps + ' requests/sec.');
    return 1;
  }
});
