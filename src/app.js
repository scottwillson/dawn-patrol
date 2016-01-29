const express = require('express');
const _ = require('lodash');
const morgan = require('morgan');
const app = express();

const results = require('./app/results');
const webCache = require('./app/web_cache');

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

function getFromCache(eventId, updatedAt) {
  return webCache.get(eventId, updatedAt);
}

function cache(eventId, eventResults, response) {
  return webCache.cache(eventId, eventResults, response);
}

function findUpdatedAt(eventResults) {
  return _(eventResults).map('updated_at').max();
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  res.append('Cache-Control', 'public, max-age=31536000');

  return results.eventUpdatedAt(eventId)
    .then(updatedAt => {
      if (updatedAt) {
        res.append('Last-Modified', updatedAt);
        return getFromCache(eventId, updatedAt);
      }
      return null;
    })
    .then(cachedResponse => {
      if (cachedResponse) return res.json(cachedResponse);

      return results.forEvent(eventId)
        .then(eventResults => {
          const updatedAt = findUpdatedAt(eventResults);
          res.append('Last-Modified', updatedAt);
          res.json(eventResults);
          return cache(eventId, updatedAt, eventResults);
        });
    });
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({ count })));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

module.exports.app = app;
