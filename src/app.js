const _ = require('lodash');
const express = require('express');
const morgan = require('morgan');
const app = express();

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

function cache(eventId, response, eventResults) {
  webCache.cache(eventId, app.responseWithWebCacheHeaders(response, eventResults));
}

function headers() {
  return ['Cache-Control', 'Content-Length', 'Content-Type', 'ETag', 'Last-Modified'];
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;

  return results.forEvent(eventId)
    .then(eventResults => {
      respondWithJSON(res, eventResults);
      return cache(eventId, res, eventResults);
    });
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({ count })));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

app.responseWithWebCacheHeaders = (response, eventResults) => {
  return _
    .reject(headers(), header => _.isUndefined(response.get(header)))
    .reduce((responseWithHeaders, header) => `${responseWithHeaders}${header}: ${response.get(header)}\r\n`, 'EXTRACT_HEADERS\r\n') +
    '\r\n' +
    JSON.stringify(eventResults);
};

module.exports.app = app;
