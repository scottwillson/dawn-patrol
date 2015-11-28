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

const resultColumns = [
  'category_id',
  'event_id',
  'person_id',
  'rails_id',
];

const valueArguments = resultColumns.map((_, index) => `$${index + 1}`);

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.resultValues = result => {
  return resultColumns.map(c => {
    if (c === 'rails_id') {
      return result.id;
    }
    if (result.hasOwnProperty(c)) {
      return result[c];
    }
    return null;
  });
};

app.insertResults = results => {
  return Promise.each(results, result => {
    return db.none(
      `insert into results (${resultColumns}) values (${valueArguments})`,
      app.resultValues(result)
    )
    .catch(error => {
      // duplicate key (make a method for this)
      if (error.code !== '23505') {
        throw error;
      }
    });
  });
};

app.getResponseFromRailsServer = eventId => {
  const url = 'http://' + railsAppHost + '/events/' + eventId + '/results.json';
  const options = {
    url: url,
    headers: {
      'User-Agent': 'dawn-patrol',
    },
  };

  return request.get(options)
    .then(response => JSON.parse(response))
    .then(response => app.insertResults(response))
    .catch(e => console.error(e + ' getting results from ' + url));
};

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then(result => {
      if (result.length) {
        return res.json(result);
      }
      return app.getResponseFromRailsServer(eventId);
    })
    .then(() => res.end())
    .catch(e => console.error(e + ' getting results for event ID ' + eventId));
});

app.get('/results.json', (req, res) =>
  db.one('select count(*) from results')
    .then(data => res.json({ count: Number(data.count) }))
);

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) =>
    db.none('delete from results')
      .then(res.end()));
}

module.exports.app = app;
