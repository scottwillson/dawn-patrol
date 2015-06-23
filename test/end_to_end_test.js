'use strict';

process.env.NODE_ENV = 'test';

var fs = require('fs');
var Promise = require('bluebird');

var pgpLib = require('pg-promise');
var cn = {
    host: 'localhost',
    database: 'dawn-patrol-test'
};
var pgp = pgpLib(cn);
var db = pgp(cn);

var app = null;
var api = null;
var echoServer = null;

function getResultsCount() {
  return db.one('select count(*) from results')
    .then(function(result) {
      var resultsCount = parseInt(result.count);

      if (resultsCount === 1) {
        return resultsCount;
      }
      else {
        return Promise.delay(20).then(function() {
          return getResultsCount();
        });
      }
  });
}

function truncateResultsTable() {
  db.none('truncate results');
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
  if (app) { app.unref(); }
  if (api) { api.unref(); }
  if (echoServer) { echoServer.unwatch(); }
  pgp.end();
}

fs.writeFileSync('tmp/nginx.log', '');

Promise.resolve(truncateResultsTable())
.then(startApp())
.then(startApi())
.then(startEchoServer)
.then(appendToNginxLog)
.then(getResultsCount)
.timeout(1000)
.finally(teardown)
.done();
