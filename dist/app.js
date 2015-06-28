'use strict';

var express = require('express');
var morgan = require('morgan');

var Promise = require('bluebird');

var pgpLib = require('pg-promise');
var pgp = pgpLib({ promiseLib: Promise });
var config = require('config');
var db = pgp(config.get('database.connection'));

var app = express();

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.get('/events/0/results.json', function (req, res) {
  db.none('insert into results (id, event_id) values (0, 0)').then(res.end());
});

app.get('/results.json', function (req, res) {
  db.one('select count(*) from results').then(function (data) {
    res.json({ count: parseInt(data.count) });
  });
});

app['delete']('/results.json', function (req, res) {
  db.none('delete from results').then(res.end());
});

module.exports.app = app;