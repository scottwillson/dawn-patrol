const express = require('express');
const morgan = require('morgan');
const app = express();
const results = require('./app/results');

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  return results.byEventId(eventId).then(eventResults => res.json(eventResults));
});

app.get('/results.json', (req, res) => results.count().then(count => res.json({count: count})));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => results.deleteAll().then(res.end()));
}

module.exports.app = app;
