process.env.NODE_ENV = 'test';

const database = require('../../src/app/database');

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

describe('app', () => {
  beforeEach('truncate DB', () => db.none('truncate results'));

  describe('#count', () => {
    context('no results', () => {
      it('counts results', () =>
        expect(database.count()).to.eventually.eq(0)
      );
    });

    context('single results', () => {
      beforeEach('insert existing result', () => insertResult());

      it('counts results', () =>
        expect(database.count()).to.eventually.eq(1)
      );
    });

    context('many results', () => {
      beforeEach('insert existing results', () => {
        insertResult();
        insertResult(1);
        return insertResult(2);
      });

      it('counts results', () =>
        expect(database.count()).to.eventually.eq(3)
      );
    });
  });

  describe('#deleteAll', () => {
    beforeEach('insert existing result', () => insertResult());

    it('deletes all results', () => {
      expect(database.count()).to.eventually.eq(1)
      .then(database.deleteAll())
      .then(expect(database.count()).to.eventually.eq(0));
    });
  });
});
