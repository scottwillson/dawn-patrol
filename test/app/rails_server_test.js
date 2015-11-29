process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const config = require('config');
const nock = require('nock');

const db = require('../db');
const railsAppHost = config.get('integrationTest.railsAppHost');
const railsServer = require('../../src/app/rails_server');
const results = require('./results');

describe('railsServer', () => {
  beforeEach('truncate DB', () => db.truncate());

  describe('#resultsForEvent', () => {
    const railsAppServer = nock('http://' + railsAppHost)
      .get('/events/0/results.json')
      .reply(200, [
        {
          'id': 31168421,
          'category_id': null,
          'person_id': 119267,
          'race_id': 564366,
          'event_id': 0,
        },
      ])
      .matchHeader('User-Agent', 'dawn-patrol');

    beforeEach('insert existing result', () => results.insert());

    it('returns event results', () => railsServer.resultsForEvent(0)
        .then(eventResults => expect(eventResults.length).to.eq(1)));

    after(() => railsAppServer.done());
  });
});
