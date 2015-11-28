const express = require('express');
const morgan = require('morgan');
const app = express();
const database = require('./app/database');

if (process.env.NODE_ENV !== 'test') {
  require('pmx').init();
  app.use(morgan('combined'));
}

app.get('/events/:id/results.json', (req, res) => {
  const eventId = req.params.id;
  return database.allEventResults(eventId).then(results => res.json(results));
});

app.get('/results.json', (req, res) => database.count().then(count => res.json({count: count})));

if (process.env.NODE_ENV !== 'production') {
  app.delete('/results.json', (req, res) => database.deleteAll().then(res.end()));
}

module.exports.app = app;
