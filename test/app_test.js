process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const app = require('../src/app').app;
const config = require('config');
const db = require('./db');
const nock = require('nock');
const masterAppHost = config.get('masterAppHost');
const request = require('supertest-as-promised');
const results = require('./app/results');

describe('app', () => {
  beforeEach('truncate DB', () => db.truncate());

  describe('GET /events/:id/results.json for a new event ID', () => {
    const masterAppServer = nock(`http://${masterAppHost}`)
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
          'team_member': true,
        },
      ])
      .matchHeader('User-Agent', 'dawn-patrol');

    it('creates a new result in the DB', () => {
      return expect(results.count()).to.eventually.eq(0)
        .then(() => { return expect(results.countByEvent(23594)).to.eventually.eq(0); })
        .then(() => {
          return request(app)
            .get('/events/23594/results.json')
            .set('Accept', 'application/json')
            .expect('Cache-Control', 'public, max-age=31536000')
            .expect('ETag', /.+/)
            .expect('Last-Modified', 'Tue, 09 Jun 2015 15:24:00 GMT')
            .expect(200);
        })
        .then(() => { return expect(results.countByEvent(23594)).to.eventually.eq(1); })
        .then(() => {
          return expect(results.byMasterID(31168421)).to.eventually.include({
            event_id: 23594,
            person_id: 119267,
            master_id: 31168421,
          });
        });
    });

    after(() => masterAppServer.done());
  });

  describe('GET /events/:id/results.json for existing ID', () => {
    const masterAppServer = nock(`http://${masterAppHost}`);

    beforeEach('insert existing result', () => results.insert());

    it('returns stored result without calling Master app', () => {
      return expect(results.count()).to.eventually.eq(1)
      .then(() => {
        return request(app)
          .get('/events/0/results.json')
          .set('Accept', 'application/json')
          .expect('Cache-Control', 'public, max-age=31536000')
          .expect('ETag', /.+/)
          .expect('Last-Modified', 'Fri, 17 Nov 1995 18:24:00 GMT')
          .expect(200);
      })
      .then(() => expect(results.count()).to.eventually.eq(1));
    });

    describe('#responseWithWebCacheHeaders', () => {
      it('caches headers', () => {
        const response = request(app).get('/events/0/results.json');
        const responseWithWebCacheHeaders = app.responseWithWebCacheHeaders(response);
        expect(responseWithWebCacheHeaders).to.contain('EXTRACT_HEADERS\n');
        expect(responseWithWebCacheHeaders).to.contain('Accept: application/json\n');
        expect(responseWithWebCacheHeaders).to.contain('Cache-Control: public, max-age=31536000\n');
        expect(responseWithWebCacheHeaders).to.contain('ETag');
        expect(responseWithWebCacheHeaders).to.contain('Last-Modified');
        return expect(responseWithWebCacheHeaders).to.not.contain('undefined');
      });

      it('adds no headers for empty responses', () => {
        const response = request(app).get('/events/1999/results.json');
        const responseWithWebCacheHeaders = app.responseWithWebCacheHeaders(response);
        expect(responseWithWebCacheHeaders).to.contain('EXTRACT_HEADERS');
        expect(responseWithWebCacheHeaders).to.not.contain('undefined');
        return expect(responseWithWebCacheHeaders).to.not.contain('ETag');
      });
    });

    after(() => masterAppServer.done());
  });

  describe('GET /results.json', () => {
    it('responds with count json', () => {
      return request(app)
        .get('/results.json')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200, '{"count":0}');
    });
  });

  describe('DELETE /results', () => {
    before(() => results.insert());

    it('deletes all results', () => {
      return request(app)
        .delete('/results.json')
        .set('Accept', 'application/json')
        .expect(200)
        .then(() => expect(results.count()).to.eventually.eq(0));
    });
  });
});
