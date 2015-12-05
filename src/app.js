const _ = require('lodash');
const express = require('express');
const morgan = require('morgan');
const app = express();
const Promise = require('bluebird');

const results = require('./app/results');
const webCache = require('./app/web_cache');

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

function respondWithJSON(res, eventResults) {
  res.append('Cache-Control', 'public, max-age=31536000');
  const updatedAt = _.max(eventResults, 'updated_at').updated_at;
  if (updatedAt) {
    res.append('Last-Modified', updatedAt.toUTCString());
  }
  return res.json(eventResults);
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;

  return results.forEvent(eventId)
    .then(eventResults => Promise.all([
      respondWithJSON(res, eventResults),
      webCache.cache(eventId, eventResults),
    ]));
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({count: count})));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

module.exports.app = app;
