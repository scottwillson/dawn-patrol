const config = require('config');
const express = require('express');
const morgan = require('morgan');
const Promise = require('bluebird');
const pgpLib = require('pg-promise');
const request = require('request-promise');

const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));

const railsAppHost = config.get('endToEndTest.railsAppHost');

const app = express();

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.insertResults = (results) => {
  return Promise.each(results, (result) => {
    return db.none('insert into results (event_id, person_id, rails_id) values ($1, $2, $3)', [result.event_id, result.person_id, result.id])
    .catch((error) => {
      // duplicate key (make a method for this)
      if (error.code !== '23505') {
        throw error;
      }
    });
  });
};

app.getResponseFromRailsServer = (eventId) => {
  const url = 'http://' + railsAppHost + '/events/' + eventId + '/results.json';
  const options = {
    url: url,
    headers: {
      'User-Agent': 'dawn-patrol',
    },
  };

  return request.get(options)
    .then((response) => { return JSON.parse(response); })
    .then((response) => { return app.insertResults(response); })
    .catch((e) => { console.error(e + ' getting results from ' + url); });
};

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then((result) => {
      if (result.length > 0) {
        return res.json(result);
      }
      return app.getResponseFromRailsServer(eventId);
    })
    .then(() => {
      return res.end();
    })
    .catch((e) => {
      console.error(e + ' getting results for event ID ' + eventId);
    });
});

app.get('/results.json', (req, res) => {
  db.one('select count(*) from results').then((data) => { res.json({ count: parseInt(data.count) }); });
});

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => {
    db.none('delete from results').then(res.end());
  });
}

module.exports.app = app;
