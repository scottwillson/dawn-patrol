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

function cache(eventId, response) {
  webCache.cache(eventId, app.responseWithWebCacheHeaders(response));
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;

  return results.forEvent(eventId)
    .then(eventResults => Promise.all([
      respondWithJSON(res, eventResults),
      cache(eventId, res),
    ]));
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({count: count})));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

app.responseWithWebCacheHeaders = (response) => {
  return 'EXTRACT_HEADERS\n'
    + `Cache-Control: ${response.get('Cache-Control')}\n`
    + `Content-Length: ${response.get('Content-Length')}\n`
    + `Content-Type: ${response.get('Content-Type')}\n`
    + `ETag: ${response.get('etag')}\n`
    + `Last-Modified: ${response.get('Last-Modified')}\n`
    + '\n'
    + response.body;
};

module.exports.app = app;
