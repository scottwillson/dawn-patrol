'use strict';

process.env.NODE_ENV = 'test';

var fs = require('fs');
var Promise = require('bluebird');

var pgpLib = require('pg-promise');
var pgp = pgpLib({ promiseLib: Promise });
var config = require('config');
var db = pgp(config.get('database.connection'));

var app = null;
var mockRailsApi = null;
var echoServer = null;

function createTmpDir() {
  if (!fs.existsSync('tmp')) {
    fs.mkdirSync('tmp');
  }
}

function getResultsCount() {
  return db.one('select count(*) from results')
    .then(function(result) {
      var resultsCount = parseInt(result.count);

      if (resultsCount === 1) {
        return resultsCount;
      }
      else {
        return Promise.delay(20).then(getResultsCount());
      }
  });
}

function truncateResultsTable() {
  db.none('truncate results');
}

function startApp() {
  app = require('./app').app.listen(3000);
}

function startMockRailsApi() {
  mockRailsApi = require('./mock_rails_api_app').app.listen(4000);
}

function startEchoServer() {
  echoServer = require('./echo_server').echoServer;
}

function appendToNginxLog() {
  fs.appendFile('tmp/nginx.log', '/events/0/results.json\n');
}

function teardown() {
  if (app) { app.unref(); }
  if (mockRailsApi) { mockRailsApi.unref(); }
  if (echoServer) { echoServer.unwatch(); }
  pgp.end();
}

createTmpDir();
fs.writeFileSync('tmp/nginx.log', '');

Promise.resolve(truncateResultsTable())
.then(startApp())
.then(startMockRailsApi())
.then(startEchoServer)
.then(appendToNginxLog)
.then(getResultsCount)
.timeout(1000)
.finally(teardown)
.done();
