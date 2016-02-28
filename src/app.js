const express = require('express');
const _ = require('lodash');
const morgan = require('morgan');
const app = express();

const results = require('./app/results');
const responseCache = require('./app/response_cache');

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

function findUpdatedAt(eventResults) {
  return _(eventResults).map('updated_at').max();
}

function appendLastModified(res, date) {
  return res.append('Last-Modified', date.toUTCString());
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  res.append('Cache-Control', 'public, max-age=31536000');

  return results.eventUpdatedAt(eventId)
    .then(updatedAt => {
      if (updatedAt) {
        appendLastModified(res, updatedAt);
        return responseCache.get(eventId, updatedAt);
      }
      return null;
    })
    .then(cachedResponse => {
      if (cachedResponse) return res.json(cachedResponse);

      return results.forEvent(eventId)
        .then(eventResults => {
          if (eventResults.error) {
            return res.status(404).end();
          }
          const updatedAt = findUpdatedAt(eventResults);
          appendLastModified(res, updatedAt);
          res.json(eventResults);
          return responseCache.cache(eventId, updatedAt, eventResults);
        });
    });
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({ count })));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

module.exports.app = app;
