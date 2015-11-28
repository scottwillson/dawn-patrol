process.env.NODE_ENV = 'test';

require('bluebird');
const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const expect = chai.expect;
const nock = require('nock');
const pgpLib = require('pg-promise');
const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));

chai.use(chaiAsPromised);

const railsAppHost = config.get('integrationTest.railsAppHost');
const railsServer = require('../../src/app/rails_server');

function insertResult(railsId) {
  if (railsId) {
    return db.none(`insert into results (event_id, rails_id) values (0, ${railsId})`);
  }
  return db.none(`insert into results (event_id, rails_id) values (0, 0)`);
}

describe('railsServer', () => {
  beforeEach('truncate DB', () => db.none('truncate results'));

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

    beforeEach('insert existing result', () => insertResult());

    it('returns event results', () => {
      return railsServer.resultsForEvent(0)
        .then(eventResults => expect(eventResults.length).to.eq(1));
    });

    after(() => railsAppServer.done());
  });
});
