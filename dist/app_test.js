'use strict';

process.env.NODE_ENV = 'test';

var app = require('./app').app;
var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var expect = chai.expect;
var pgpLib = require('pg-promise');
var Promise = require('bluebird');
var request = require('supertest-as-promised');

chai.use(chaiAsPromised);

var pgp = pgpLib({ promiseLib: Promise });
var config = require('config');
var db = pgp(config.get('database.connection'));

function resultsCount() {
  return db.one('select count(*) from results').then(function (result) {
    return parseInt(result.count);
  });
}

function insertResult() {
  return db.none('insert into results (id, event_id) values (0, 0)');
}

describe('app', function () {
  beforeEach(function () {
    return db.none('truncate results');
  });

  describe('GET /events/:id/results.json', function () {
    it('responds with status OK', function () {
      Promise.settle([request(app).get('/events/0/results.json').set('Accept', 'application/json').expect(200), expect(resultsCount()).to.eventually.eq(1)]);
    });
  });

  describe('GET /results.json', function () {
    it('responds with count json', function () {
      return request(app).get('/results.json').set('Accept', 'application/json').expect('Content-Type', /json/).expect(200, '{"count":0}');
    });
  });

  describe('DELETE /results', function () {
    before(function () {
      return insertResult();
    });

    it('deletes all results', function () {
      return request(app)['delete']('/results.json').set('Accept', 'application/json').expect(200).then(function () {
        return expect(resultsCount()).to.eventually.eq(0);
      });
    });
  });
});