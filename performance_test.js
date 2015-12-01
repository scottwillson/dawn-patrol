function targetHost() {
  if (typeof process.env.TARGET_HOST === 'undefined') {
    return '0.0.0.0:8001';
  }

  return process.env.TARGET_HOST;
}

const loadtest = require('loadtest');
const options = {
  url: `http://${targetHost()}/events/0/results.json`,
  maxRequests: 1000,
  concurrency: 4,
};

loadtest.loadTest(options, (error, result) => {
  if (error) {
    return console.error(`Got an error: ${error}`);
  }
  console.log(require('util').inspect(result));

  if (result.rps > 20) {
    return 0;
  }

  console.log(`Failed. ${result.rps} requests/sec.`);
  return 1;
});
