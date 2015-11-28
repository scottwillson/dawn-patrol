process.env.NODE_ENV = 'test';

const results = require('../../src/app/results');

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const expect = chai.expect;
const pgpLib = require('pg-promise');
const Promise = require('bluebird');

chai.use(chaiAsPromised);

const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));

function insertResult(railsId) {
  if (railsId) {
    return db.none(`insert into results (event_id, rails_id) values (0, ${railsId})`);
  }
  return db.none(`insert into results (event_id, rails_id) values (0, 0)`);
}

function resultsCount() {
  return db.one('select count(*) from results')
    .then(result => Number(result.count));
}

describe('results', () => {
  beforeEach('truncate DB', () => db.none('truncate results'));

  describe('#byEventId', () => {
    beforeEach('insert existing result', () => insertResult());

    it('returns results', () => {
      return results.byEventId(0)
        .then(eventResults => expect(eventResults.length).to.eq(1));
    });
  });

  describe('#count', () => {
    context('no results', () => {
      it('counts results', () =>
        expect(results.count()).to.eventually.eq(0)
      );
    });

    context('single results', () => {
      beforeEach('insert existing result', () => insertResult());

      it('counts results', () =>
        expect(results.count()).to.eventually.eq(1)
      );
    });

    context('many results', () => {
      beforeEach('insert existing results', () => {
        insertResult();
        insertResult(1);
        return insertResult(2);
      });

      it('counts results', () =>
        expect(results.count()).to.eventually.eq(3)
      );
    });
  });

  describe('#deleteAll', () => {
    beforeEach('insert existing result', () => insertResult());

    it('deletes all results', () => {
      expect(resultsCount()).to.eventually.eq(1)
      .then(results.deleteAll())
      .then(expect(resultsCount()).to.eventually.eq(0));
    });
  });

  describe('#insertResults', () => {
    it('does not insert duplicates', () => {
      return expect(resultsCount()).to.eventually.eq(0)
        .then(() => results.insertResults([{ event_id: 0, person_id: 0, id: 0 }]))
        .then(() => expect(resultsCount()).to.eventually.eq(1))
        .then(() => results.insertResults([{ event_id: 0, person_id: 0, id: 0 }]))
        .then(() => expect(resultsCount()).to.eventually.eq(1));
    });
  });

  describe('#resultValues', () => {
    it('returns nil for empty results', () => {
      const result = { id: 9 };
      return expect(results.resultValues(result)).to.eql([ null, null, null, 9 ]);
    });
  });
});
