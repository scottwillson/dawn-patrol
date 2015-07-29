'use strict';

var config = require('config');
var express = require('express');
var morgan = require('morgan');
var Promise = require('bluebird');
var pgpLib = require('pg-promise');
var request = require('request-promise');

var pgp = pgpLib({ promiseLib: Promise });
var db = pgp(config.get('database.connection'));

var railsAppHost = config.get('endToEndTest.railsAppHost');

var app = express();

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.get('/events/:id/results.json', function (req, res) {
  request.get('http://' + railsAppHost + '/events/' + req.params.id + '/results.json')
    .then(function(response) {
      return JSON.parse(response);
    })
    .then(function() {
      return db.none('insert into results (event_id) values ($1)', [req.params.id]);
    })
    .then(function() {
      return res.end();
    });
});

app.get('/results.json', function (req, res) {
  db.one('select count(*) from results').then(function(data) { res.json({ count: parseInt(data.count) }); });
});

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', function (req, res) {
    db.none('delete from results').then(res.end());
  });
}

module.exports.app = app;
