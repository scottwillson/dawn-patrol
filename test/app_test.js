'use strict';

process.env.NODE_ENV = 'test';

var app = require('../src/app').app;
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
  return db.one('select count(*) from results')
    .then(function(result) {
      return parseInt(result.count);
    });
}

function eventResultsCount(eventId) {
  return db.one('select count(*) from results where event_id=$1', [eventId])
    .then(function(result) {
      return parseInt(result.count);
    });
}

function eventResult(railsId) {
  return db.oneOrNone('select * from results where rails_id=$1', [railsId])
  .then(function(result) {
    if (result) {
      return result;
    }
    else {
      return [];
    }
  });

}

function insertResult() {
  return db.none('insert into results (id, event_id, rails_id) values (0, 0, 0)');
}

describe('app', function() {
  beforeEach('truncate DB', function() {
    return db.none('truncate results');
  });

  describe('GET /events/:id/results.json for a new event ID', function() {
    var railsAppServer;

    before(function() {
      railsAppServer = nock('http://' + railsAppHost)
        .get('/events/23594/results.json')
        .reply(200, [
          {
            'id': 31168421,
            'category_id': null,
            'person_id': 119267,
            'race_id': 564366,
            'team_id': 6834,
            'age': null,
            'city': 'Hood River',
            'date_of_birth': null,
            'is_series': null,
            'license': '',
            'notes': null,
            'number': '102',
            'place': '1',
            'place_in_category': 0,
            'points': 0.0,
            'points_from_place': 0.0,
            'points_bonus_penalty': 0.0,
            'points_total': 0.0,
            'state': null,
            'status': null,
            'time': null,
            'time_bonus_penalty': null,
            'time_gap_to_leader': null,
            'time_gap_to_previous': null,
            'time_gap_to_winner': null,
            'created_at': '2015-06-09T08:24:00.000-07:00',
            'updated_at': '2015-06-09T08:24:00.000-07:00',
            'time_total': null,
            'laps': 5,
            'members_only_place': null,
            'points_bonus': 0,
            'points_penalty': 0,
            'preliminary': null,
            'bar': true,
            'gender': null,
            'category_class': null,
            'age_group': null,
            'custom_attributes': {},
            'competition_result': false,
            'team_competition_result': false,
            'category_name': null,
            'event_date_range_s': '6/1',
            'date': '2015-06-01',
            'event_end_date': '2015-06-01',
            'event_id': 23594,
            'event_full_name': 'Portland Short Track Series',
            'first_name': 'Holland',
            'last_name': 'LaRue',
            'name': 'Holland LaRue',
            'race_name': 'Category 2 Women 35-44',
            'race_full_name': 'Portland Short Track Series: Category 2 Women 35-44',
            'team_name': 'Team Finger',
            'year': 2015,
            'non_member_result_id': null,
            'single_event_license': false,
            'team_member': true
          }
        ])
        .matchHeader('User-Agent', 'dawn-patrol');
      return railsAppServer;
    });

    it('creates a new result in the DB', function() {
      return expect(resultsCount()).to.eventually.eq(0)
        .then(function() { return expect(eventResultsCount(23594)).to.eventually.eq(0); })
        .then(function() {
          return request(app)
            .get('/events/23594/results.json')
            .set('Accept', 'application/json')
            .expect(200);
        })
        .then(function() { return expect(eventResultsCount(23594)).to.eventually.eq(1); })
        .then(function() { return expect(eventResult(31168421)).to.eventually.include({
            event_id: 23594,
            person_id: 119267,
            rails_id: 31168421
          });
        });
    });

    after(function() {
      return railsAppServer.done();
    });
  });

  describe('GET /events/:id/results.json for existing ID', function() {
    var railsAppServer;

    beforeEach('insert existing result', function() {
      railsAppServer = nock('http://' + railsAppHost);
      return insertResult();
    });

    it('returns stored result without calling Rails app', function() {
        return expect(resultsCount()).to.eventually.eq(1)
        .then(function() {
          return request(app)
            .get('/events/0/results.json')
            .set('Accept', 'application/json')
            .expect(200);
        })
        .then(function() { return expect(resultsCount()).to.eventually.eq(1); });
    });

    after(function() {
      return railsAppServer.done();
    });
  });

  describe('GET /results.json', function() {
    it('responds with count json', function() {
      return request(app)
        .get('/results.json')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200, '{"count":0}');
    });
  });

  describe('DELETE /results', function() {
    before(function() {
      return insertResult();
    });

    it('deletes all results', function() {
      return request(app)
        .delete('/results.json')
        .set('Accept', 'application/json')
        .expect(200)
        .then(function() {
          return expect(resultsCount()).to.eventually.eq(0);
        });
    });
  });

  describe('#insertResults', function() {
    it('does not insert duplicates', function() {
      return expect(resultsCount()).to.eventually.eq(0)
        .then(function() { return app.insertResults([{ event_id: 0, person_id: 0, id: 0 }]); })
        .then(function() { return expect(resultsCount()).to.eventually.eq(1); })
        .then(function() { return app.insertResults([{ event_id: 0, person_id: 0, id: 0 }]); })
        .then(function() { return expect(resultsCount()).to.eventually.eq(1); });
    });
  });
});
