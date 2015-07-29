'use strict';

process.env.NODE_ENV = 'test';

var app = require('./app').app;
var chai = require('chai');
var chaiAsPromised = require('chai-as-promised');
var config = require('config');
var expect = chai.expect;
var nock = require('nock');
var pgpLib = require('pg-promise');
var Promise = require('bluebird');
var request = require('supertest-as-promised');

chai.use(chaiAsPromised);

var pgp = pgpLib({ promiseLib: Promise });
var db = pgp(config.get('database.connection'));

var railsAppHost = config.get('endToEndTest.railsAppHost');

function resultsCount() {
  return db.one('select count(*) from results').then(function (result) {
    return parseInt(result.count);
  });
}

function eventResultsCount(eventId) {
  return db.one('select count(*) from results where event_id=$1', [eventId]).then(function (result) {
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

  describe('GET /events/:id/results.json for a new event ID', function () {
    var railsAppServer;

    before(function () {
      railsAppServer = nock('http://' + railsAppHost).get('/events/719/results.json').reply(200, {
        'event_id': 719
      }).matchHeader('User-Agent', 'dawn-patrol');
      return railsAppServer;
    });

    it('creates a new result in the DB', function () {
      return expect(resultsCount()).to.eventually.eq(0).then(function () {
        return request(app).get('/events/719/results.json').set('Accept', 'application/json').expect(200);
      }).then(function () {
        return expect(resultsCount()).to.eventually.eq(1);
      }).then(function () {
        return expect(eventResultsCount(719)).to.eventually.eq(1);
      });
    });

    after(function () {
      return railsAppServer.done();
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