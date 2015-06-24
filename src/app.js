'use strict';

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
}

var express = require('express');
var morgan = require('morgan');

var pgpLib = require('pg-promise');
var pgp = pgpLib();
var config = require('config');
var db = pgp(config.get('database.connection'));

var app = express();
app.use(morgan('combined'));

app.get('/events/0/results.json', function (req, res) {
  db.one('insert into results (id, event_id) values (0, 0)');
  res.send('OK');
});

module.exports.app = app;
