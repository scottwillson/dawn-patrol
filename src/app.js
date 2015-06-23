'use strict';

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
}

var express = require('express');
var morgan = require('morgan');
var pg = require('pg');
var pgConnString = 'postgres://localhost/dawn-patrol-test';

var app = express();
app.use(morgan('combined'));

app.get('/events/0/results.json', function (req, res) {
  pg.connectAsync(pgConnString, function(err, database, connDone) {
    database.query('insert into results (id, event_id) values (0, 0)', function() {
      connDone();
    });
  });
  res.send('OK');
});

module.exports.app = app;
