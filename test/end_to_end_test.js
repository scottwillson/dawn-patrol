'use strict';

process.env.NODE_ENV = 'test';

var fs = require('fs');
var Promise = require('bluebird');

var pg = Promise.promisifyAll(require('pg'));
var pgConnString = 'postgres://localhost/dawn-patrol-test';

var app = null;
var api = null;
var echoServer = null;

function getResultsCount(database, releaseDatabaseConnection) {
  return database.queryAsync('select count(*) from results')
    .then(function(result) {
      var resultsCount = parseInt(result.rows[0].count);

      if (resultsCount === 1) {
        releaseDatabaseConnection();
        return resultsCount;
      }
      else {
        return Promise.delay(20).then(function() {
          return getResultsCount(database, releaseDatabaseConnection);
        });
      }
  });
}

function truncateResultsTable(database, releaseDatabaseConnection) {
  return database.queryAsync('truncate results')
    .then(function() {
      releaseDatabaseConnection();
    });
}

function startApp() {
  app = require('./app').app.listen(3000);
}

function startApi() {
  api = require('./api_app').app.listen(3001);
}

function startEchoServer() {
  echoServer = require('./echo_server').echoServer;
}

function appendToNginxLog() {
  fs.appendFile('tmp/nginx.log', '/events/0/results.json\n');
}

function teardown() {
  app.unref();
  api.unref();
  echoServer.unwatch();
  pg.end();
}

fs.writeFileSync('tmp/nginx.log', '');

pg.connectAsync(pgConnString)
.spread(truncateResultsTable)
.then(startApp)
.then(startApi)
.then(startEchoServer)
.then(appendToNginxLog)
.then(function() { return pg.connectAsync(pgConnString); })
.spread(getResultsCount)
.timeout(1000)
.finally(teardown)
.done();
