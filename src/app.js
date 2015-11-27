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

app.insertResults = function(results) {
  return results.forEach(function (result) {
    return db.none('insert into results (event_id, person_id, rails_id) values ($1, $2, $3)', [result.event_id, result.person_id, result.id])
    .catch(function (error) {
      // duplicate key (make a method for this)
      if (error.code !== '23505') {
        throw error;
      }
    });
  });
};

app.getResponseFromRailsServer = function(eventId) {
  var url = 'http://' + railsAppHost + '/events/' + eventId + '/results.json';
  var options = {
    url: url,
    headers: {
      'User-Agent': 'dawn-patrol'
    }
  };

  return request.get(options)
    .then(function(response) {
      return JSON.parse(response);
    })
    .then(function(response) {
      return app.insertResults(response);
    })
    .catch(function(e) {
      console.error(e + ' getting results from ' + url);
  });
};

app.get('/events/:id/results.json', function (req, res) {
  var eventId = req.params.id;
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then(function(result) {
      if (result.length > 0) {
        res.json(result);
        return true;
      }
      else {
        return app.getResponseFromRailsServer(eventId);
      }
    })
    .then(function() {
      return res.end();
    })
    .catch(function(e) {
      console.error(e + ' getting results for event ID ' + eventId);
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
