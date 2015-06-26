'use strict';

process.env.NODE_ENV = 'test';

var request = require('supertest');
var app = require('./app').app;

var pgpLib = require('pg-promise');
var pgp = pgpLib({ promiseLib: Promise });
var config = require('config');
var db = pgp(config.get('database.connection'));

describe('app', function () {
  beforeEach(function (done) {
    db.none('truncate results').then(done());
  });

  describe('GET event results', function () {
    it('responds with json', function (done) {
      request(app).get('/events/0/results.json').set('Accept', 'application/json').expect(200, done);
    });
  });

  describe('GET all results', function () {
    it('responds with count json', function (done) {
      request(app).get('/results.json').set('Accept', 'application/json').expect('Content-Type', /json/).expect(200, '{"count":0}', done);
    });
  });
});